# Release and change control

A release is a Git tag plus the package CI built from that exact commit. **We order only from that package**, so the tag, the files and the boards in our hands always match.

## Revisions and tags

| Tag | Meaning | Ordered? |
|---|---|---|
| `triage-main-revA` | Released Rev A, frozen forever | Yes, and only from this |
| `triage-main-revA-rc1`, `-rc2` | Release candidate: CI builds a GitHub **pre-release** for final review | Never |
| `triage-main-revB` | The next physical revision | Yes |

1. The letter changes **only when a changed board is sent to a fab**. Skip I and O.
2. Store the letter once as a project text variable: Schematic Editor → File → Schematic Setup → Project → Text Variables → `BOARD_REV = A`.
3. Put `triage-main Rev ${BOARD_REV}` on F.Silkscreen.
4. The release script **refuses to build** if `BOARD_REV` differs from the tag's letter.
5. The first PR after an order bumps `BOARD_REV` to the next letter.
6. Never move, delete or reuse an ordered tag or letter. Changed files = new letter, even before production starts. (A ruleset on `*-rev*` tags enforces this.)

## Pre-release checklist

- [ ] Everything for this revision is merged and the `checks` CI is green on `main`
- [ ] `BOARD_REV` is the new letter; silkscreen shows board name and revision
- [ ] Fab capabilities re-checked today; Board Setup matches `fab/rules/README.md`
- [ ] `hardware/<board>/FAB-NOTES.md` filled in for this order (template: `docs/templates/FAB-NOTES.md`)
- [ ] Every assembled part has `LCSC` (JLCPCB) or `MPN` + `Manufacturer` (PCBWay); stock checked
- [ ] `CHANGELOG.md` has a `## [<board>-revX] - YYYY-MM-DD` section
- [ ] Mechanical fit checked with the STEP file
- [ ] Order cost fits the remaining budget (`lib/PARTS.csv`)
- [ ] A release candidate was built and reviewed: Gerbers opened in KiCad's Gerber Viewer and the fab's online viewer; BOM and placement files read line by line
- [ ] Approvals per `docs/review.md`

## Make the release

```bash
git switch main
git pull
# 1. Release candidate for final review
git tag -a triage-main-revA-rc1 -m "triage-main Rev A, release candidate 1"
git push origin triage-main-revA-rc1
# CI builds a pre-release. Review every file in it.
# 2. The real release, on the same commit
git tag -a triage-main-revA -m "triage-main Rev A: for JLCPCB order"
git push origin triage-main-revA
```

Preview the package locally first (no tag needed):

```bash
# macOS
export KICAD_CLI=/Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli
bash scripts/build-release.sh triage-main-revA
# Windows (Git Bash) — check the path matches your install
export KICAD_CLI="/c/Program Files/KiCad/10.0/bin/kicad-cli.exe"
```

## What's in the package

```
<tag>-release.zip              everything below, one download
<tag>/
├── <tag>-gerbers.zip          UPLOAD THIS to the fab
├── gerbers/                   same files unzipped
├── assembly/
│   ├── <tag>-bom-jlcpcb.csv   Comment, Designator, Footprint, JLCPCB Part #, Quantity
│   ├── <tag>-cpl-jlcpcb.csv   Designator, Val, Package, Mid X, Mid Y, Rotation, Layer (mm)
│   ├── <tag>-bom-pcbway.csv   Designator, Quantity, MPN, Manufacturer, Description, Value, Package
│   ├── <tag>-pos-kicad.csv    KiCad's own placement file (mm)
│   └── <tag>-bom-full.csv     master BOM, all fields, DNP marked
├── docs/                      schematic PDF, assembly drawing PDF
├── 3d/<tag>.step              board + components, for enclosure fit
├── reports/                   ERC and DRC reports
├── <tag>-FAB-NOTES.md
├── <tag>-MANIFEST.txt         tag, commit, build date, KiCad version
└── SHA256SUMS
```

**Rotation trap:** KiCad's zero orientation may not match the fab's reel orientation. Check every polarised part (diodes, LEDs, ICs) in the fab's placement preview. Set the drill/place file origin once (Place → Drill/Place File Origin, bottom-left corner) and never move it.

## Tag-to-order traceability

1. Download upload files **from the Release page**, never a laptop's project folder.
2. Verify: `sha256sum -c SHA256SUMS` (macOS: `shasum -a 256 -c SHA256SUMS`).
3. A second person checks order options against `FAB-NOTES.md` before anyone pays.
4. Commit an order record: `fab/orders/YYYY-MM-DD-<board>-revX-<fab>.md` (template: `docs/templates/order-record.md`).
5. Save the Release zip to the team's shared drive next to the order record.

---

# Change control (ECO / ECN)

Once a revision is tagged and ordered, every further change starts as a written **ECO issue**, lands through a PR that references it, and is announced through `CHANGELOG.md` and the next Release (together, the ECN).

| Situation | ECO? |
|---|---|
| Design work before a board's first order | No, normal issues and PRs |
| Any change to a board revision that has been tagged and ordered | **Yes** |
| A library fix affecting a released board | Yes, against each affected board |
| Docs, CI, typos | No |

Open one with **New issue → Engineering Change Order**. The ECO number is the issue number: issue #23 is ECO-23.

## After a board has been ordered

1. **Freeze.** The ordered tag is never moved, deleted or edited.
2. **Record the problem** in an ECO issue with evidence, even for tiny fixes.
3. **Decide disposition:** use as is, rework or scrap. For rework, write the steps in `docs/reviews/<board>-revX-rework.md` and mark reworked boards (e.g. "A*").
4. If the order is still open at the fab and files change, it's still a new letter. Record it in the order record.
5. Fix on `eco/<board>-<ECO#>-<summary>`. The first PR after an order bumps `BOARD_REV`.
6. **Tell the firmware people** when pins, I²C addresses or timing change; `firmware/README.md` lists which hardware revision it supports.
7. Release the new revision as above; post the Release link in the team chat.

## Linking

- PR description: `Fixes #23`. GitHub closes the issue on merge.
- Commit messages: `Refs #23` or `ECO-23`.
- On the ECO issue, list the PR and, after release, the new tag: ECO → PR → commits → tag → Release → order record.

## CHANGELOG.md

Newest first, one section per tag. `build-release.sh` copies the section whose heading starts with `## [<tag>]` into the Release notes.

```markdown
## [Unreleased]
### triage-main
- Changed: R5 10k -> 4.7k, I2C pull-up too weak at 400 kHz (ECO-23, #24)

## [triage-main-revA] - 2026-11-20
### Added
- First release: SpO2/HR optical front end, BP pump + valve driver, 3.3 V LDO, triage LEDs.
### Fab
- JLCPCB, 2 layers, assembly top side. Order record: fab/orders/2026-11-20-triage-main-revA-jlcpcb.md
```

At release time, move the board's lines from `[Unreleased]` into the new section, in the PR that finalises the revision.
