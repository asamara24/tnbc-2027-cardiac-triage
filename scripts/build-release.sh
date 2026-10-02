#!/usr/bin/env bash
# build-release.sh: build the complete fab + assembly package for ONE board revision.
#
# Usage (run from anywhere inside the repo):
#   bash scripts/build-release.sh <board>-rev<REV>
# Examples:
#   bash scripts/build-release.sh triage-main-revA       # the Rev A you will order
#   bash scripts/build-release.sh triage-main-revB-rc1   # a release candidate for review
#
# Expects:
#   hardware/<board>/<board>.kicad_pro, .kicad_sch, .kicad_pcb
#   hardware/<board>/FAB-NOTES.md   (board specs for the fab)
#   a project text variable BOARD_REV equal to the revision letter (A, B, ...)
#
# Works on Linux, macOS and Windows (Git Bash). Needs KiCad 10's kicad-cli.
# If kicad-cli is not on your PATH, point KICAD_CLI at it first, e.g.:
#   macOS:   export KICAD_CLI=/Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli
#   Windows: export KICAD_CLI="/c/Program Files/KiCad/10.0/bin/kicad-cli.exe"  (verify path)
#
# Source: PCB Design Control for Small Electrical Teams, Section 10.
set -euo pipefail

KICAD_CLI="${KICAD_CLI:-kicad-cli}"

# ---------- 1. Work out board and revision from the tag ----------
TAG="${1:-}"
if [[ -z "$TAG" || "$TAG" != *-rev* ]]; then
  echo "Usage: $0 <board>-rev<REV>   (example: triage-main-revA)" >&2
  exit 2
fi
BOARD="${TAG%-rev*}"          # triage-main-revB-rc1 -> triage-main
REV="${TAG##*-rev}"           # triage-main-revB-rc1 -> B-rc1
REV_LETTER="${REV%%-*}"       # B-rc1 -> B
NAME="$TAG"                   # every output file starts with the tag

cd "$(dirname "$0")/.."       # repo root
PROJ_DIR="hardware/$BOARD"
PRO="$PROJ_DIR/$BOARD.kicad_pro"
SCH="$PROJ_DIR/$BOARD.kicad_sch"
PCB="$PROJ_DIR/$BOARD.kicad_pcb"
for f in "$PRO" "$SCH" "$PCB" "$PROJ_DIR/FAB-NOTES.md"; do
  [[ -f "$f" ]] || { echo "ERROR: missing $f" >&2; exit 1; }
done

# ---------- 2. Safety checks before generating anything ----------
# The design itself must say the same revision as the tag.
SRC_REV="$(grep -o '"BOARD_REV"[[:space:]]*:[[:space:]]*"[^"]*"' "$PRO" | head -n 1 \
  | sed 's/.*"\([^"]*\)"$/\1/' || true)"
if [[ "$SRC_REV" != "$REV_LETTER" ]]; then
  echo "ERROR: tag says revision '$REV_LETTER' but $PRO has BOARD_REV='$SRC_REV'." >&2
  echo "Fix it in Schematic Setup > Project > Text Variables, commit, then re-tag." >&2
  exit 1
fi

# Record exactly which commit this package came from.
COMMIT="${GITHUB_SHA:-${CI_COMMIT_SHA:-unknown}}"
if command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  COMMIT="$(git rev-parse HEAD)"
  # Refuse to package unsaved or uncommitted design work.
  if [[ -n "$(git status --porcelain -- hardware lib)" ]]; then
    echo "ERROR: uncommitted changes in hardware/ or lib/. Commit or stash them first." >&2
    exit 1
  fi
fi

OUT="out/$NAME"
rm -rf "$OUT" "out/$NAME-release.zip" "out/$NAME-release-notes.md"
mkdir -p "$OUT/gerbers" "$OUT/assembly" "$OUT/docs" "$OUT/3d" "$OUT/reports"
KICAD_VERSION="$("$KICAD_CLI" version)"
echo "Building $NAME from commit $COMMIT with KiCad $KICAD_VERSION"

# ---------- 3. ERC and DRC: refuse to release a design with errors ----------
echo "==> ERC"
if ! "$KICAD_CLI" sch erc --severity-error --exit-code-violations \
     --output "$OUT/reports/$NAME-erc.rpt" "$SCH"; then
  cat "$OUT/reports/$NAME-erc.rpt" 2>/dev/null || true
  echo "ERROR: ERC found errors. Release stopped." >&2
  exit 1
fi
echo "==> DRC (with schematic parity)"
if ! "$KICAD_CLI" pcb drc --schematic-parity --refill-zones --severity-error \
     --exit-code-violations --output "$OUT/reports/$NAME-drc.rpt" "$PCB"; then
  cat "$OUT/reports/$NAME-drc.rpt" 2>/dev/null || true
  echo "ERROR: DRC found errors. Release stopped." >&2
  exit 1
fi

# ---------- 4. Fabrication files ----------
# Layers for a 2-layer board. For 4 layers add In1.Cu,In2.Cu after F.Cu.
# Canonical KiCad layer names: F.SilkS is the layer the editor shows as F.Silkscreen.
LAYERS="F.Cu,B.Cu,F.Paste,B.Paste,F.SilkS,B.SilkS,F.Mask,B.Mask,Edge.Cuts"
echo "==> Gerbers"
# --use-drill-file-origin: Gerbers, drill and placement all share one origin
# --check-zones: refill copper pours if needed (not saved to the board file)
"$KICAD_CLI" pcb export gerbers --output "$OUT/gerbers/" --layers "$LAYERS" \
  --subtract-soldermask --use-drill-file-origin --check-zones "$PCB"
echo "==> Drill files + drill map"
"$KICAD_CLI" pcb export drill --output "$OUT/gerbers/" --format excellon \
  --drill-origin plot --excellon-units mm --generate-map --map-format gerberx2 "$PCB"

# ---------- 5. Assembly files ----------
echo "==> Placement (pick-and-place / centroid / CPL)"
# Units default to INCHES in kicad-cli, so always pass --units mm.
POS_KICAD="$OUT/assembly/$NAME-pos-kicad.csv"
"$KICAD_CLI" pcb export pos --output "$POS_KICAD" --format csv --units mm \
  --side both --use-drill-file-origin --exclude-dnp "$PCB"
# JLCPCB-style copy: same data, header renamed to the names JLCPCB's KiCad guide lists.
EXPECTED_HDR="Ref,Val,Package,PosX,PosY,Rot,Side"
ACTUAL_HDR="$(head -n 1 "$POS_KICAD" | tr -d '"\r')"
if [[ "$ACTUAL_HDR" != "$EXPECTED_HDR" ]]; then
  echo "ERROR: unexpected placement header '$ACTUAL_HDR' (expected '$EXPECTED_HDR')." >&2
  echo "KiCad's format may have changed; update this script." >&2
  exit 1
fi
{ echo "Designator,Val,Package,Mid X,Mid Y,Rotation,Layer"; tail -n +2 "$POS_KICAD"; } \
  > "$OUT/assembly/$NAME-cpl-jlcpcb.csv"

echo "==> BOMs"
# QUANTITY is a virtual field. Write it as QUANTITY, not ${QUANTITY}: inside
# double quotes the shell would replace ${QUANTITY} with an empty string.
# --ref-range-delimiter "" lists R1,R2,R3 instead of R1-R3.
# --string-delimiter '"' quotes each field, so "R1,R2" stays one CSV cell.
COMMON_BOM_ARGS=(--ref-range-delimiter "" --string-delimiter '"')
# Master BOM: every field, DNP parts included and marked.
"$KICAD_CLI" sch export bom --output "$OUT/assembly/$NAME-bom-full.csv" \
  --fields "Reference,Value,Footprint,MPN,Manufacturer,LCSC,Description,Datasheet,QUANTITY,DNP" \
  --labels "Reference,Value,Footprint,MPN,Manufacturer,LCSC,Description,Datasheet,Qty,DNP" \
  --group-by "Value,Footprint,MPN,LCSC,DNP" "${COMMON_BOM_ARGS[@]}" "$SCH"
# JLCPCB assembly BOM: Comment, Designator, Footprint, JLCPCB Part #
"$KICAD_CLI" sch export bom --output "$OUT/assembly/$NAME-bom-jlcpcb.csv" \
  --fields "Value,Reference,Footprint,LCSC,QUANTITY" \
  --labels "Comment,Designator,Footprint,JLCPCB Part #,Quantity" \
  --group-by "Value,Footprint,LCSC" --exclude-dnp "${COMMON_BOM_ARGS[@]}" "$SCH"
# PCBWay turnkey BOM: designators, quantity, MPN, manufacturer, description, package
"$KICAD_CLI" sch export bom --output "$OUT/assembly/$NAME-bom-pcbway.csv" \
  --fields "Reference,QUANTITY,MPN,Manufacturer,Description,Value,Footprint" \
  --labels "Designator,Quantity,Manufacturer Part Number,Manufacturer,Description,Value,Package" \
  --group-by "MPN,Manufacturer,Value,Footprint" --exclude-dnp "${COMMON_BOM_ARGS[@]}" "$SCH"

# ---------- 6. Documentation and 3D ----------
echo "==> Schematic PDF, assembly drawing, STEP"
"$KICAD_CLI" sch export pdf --output "$OUT/docs/$NAME-schematic.pdf" "$SCH"
"$KICAD_CLI" pcb export pdf --output "$OUT/docs/$NAME-assembly.pdf" \
  --layers "F.Fab,B.Fab" --common-layers "Edge.Cuts" --mode-multipage "$PCB"
"$KICAD_CLI" pcb export step --output "$OUT/3d/$NAME.step" \
  --force --subst-models --no-dnp "$PCB"

cp "$PROJ_DIR/FAB-NOTES.md" "$OUT/$NAME-FAB-NOTES.md"
cat > "$OUT/$NAME-MANIFEST.txt" <<EOF
Tag:           $TAG
Board:         $BOARD
Revision:      $REV
Commit:        $COMMIT
Built (UTC):   $(date -u +%Y-%m-%dT%H:%M:%SZ)
KiCad version: $KICAD_VERSION
Upload to the fab: $NAME-gerbers.zip (+ assembly/*-bom-*.csv and *-cpl-*.csv / *-pos-*.csv for assembly)
EOF

# ---------- 7. Zip the Gerbers, then checksum everything ----------
if command -v zip >/dev/null 2>&1; then
  (cd "$OUT/gerbers" && zip -q -r "../$NAME-gerbers.zip" .)
else
  echo "Note: 'zip' not found, skipping zips (CI makes them; Git Bash has no zip)."
fi

if command -v sha256sum >/dev/null 2>&1; then SHA_CMD="sha256sum"; else SHA_CMD="shasum -a 256"; fi
(
  cd "$OUT"
  # Write the list outside the folder first, so it never lists itself.
  find . -type f | LC_ALL=C sort | while IFS= read -r f; do
    # shellcheck disable=SC2086  # SHA_CMD is deliberately split into command + options
    $SHA_CMD "$f"
  done > "../$NAME.sha256.tmp"
  mv "../$NAME.sha256.tmp" SHA256SUMS
)

if command -v zip >/dev/null 2>&1; then
  (cd out && zip -q -r "$NAME-release.zip" "$NAME")
fi

# ---------- 8. Release notes: this tag's section of CHANGELOG.md ----------
{
  echo "**Board:** $BOARD | **Revision:** $REV | **Commit:** $COMMIT | **KiCad:** $KICAD_VERSION"
  echo
  if [[ -f CHANGELOG.md ]] && grep -q "^## \[$TAG\]" CHANGELOG.md; then
    awk -v hdr="## [$TAG]" 'index($0, hdr) == 1 {grab = 1; next} grab && /^## / {exit} grab {print}' CHANGELOG.md
  else
    echo "No CHANGELOG.md entry found for $TAG."
  fi
  echo
  echo "Order from the files attached to this release only. Check SHA256SUMS after downloading."
} > "out/$NAME-release-notes.md"

echo "Done: $OUT"
