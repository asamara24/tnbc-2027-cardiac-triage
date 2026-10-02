# Daily workflow

Every change follows the same loop: fresh branch from `main`, small commits, pull request, review, merge, delete the branch. Keep branches short-lived: days, not weeks.

## Branch names

`<type>/<board>-<short-description>`, lowercase, hyphens.

| Type | Use for | Example |
|---|---|---|
| `sch` | Schematic changes | `sch/triage-main-add-status-led` |
| `layout` | PCB layout changes | `layout/triage-main-route-power` |
| `lib` | Library additions or fixes | `lib/add-max30102` |
| `fix` | Bugs found in review or on hardware | `fix/triage-main-swap-sda-scl` |
| `eco` | Changes to an already-released board | `eco/triage-main-12-pullup-value` |
| `fw` | Firmware | `fw/bp-oscillometric-algorithm` |
| `mech` | Enclosure / cuff / clip CAD | `mech/enclosure-v2` |
| `docs` / `chore` | Docs, report, CI, housekeeping | `docs/dfmea-first-pass` |

## Commit messages

`<type>(<scope>): <what changed, imperative, under ~72 chars>`, then optionally a blank line and a body saying **why**. Reference the issue.

```
feat(triage-main): add status LED D2 with 1k current-limit resistor
fix(triage-main): swap SDA/SCL on J1 to match the MCU pinout

Issue found at Rev A bring-up. Fixes #14.
lib: add MAX30102 symbol, OLGA-14 footprint and STEP model
fw(triage): add High/Medium/Low thresholds for SpO2 and HR
```

Bad messages: `update`, `changes`, `final`, `asdf`. Six months later nobody can tell what changed or whether it was ordered.

## The daily loop

```bash
# 1. Start from an up-to-date main
git switch main
git pull
# 2. One branch per focused change
git switch -c sch/triage-main-add-status-led
# 3. Edit in KiCad, save, check what changed
git status
git diff --stat
# 4. Commit each logical step
git add hardware/triage-main/triage-main.kicad_sch
git commit -m "feat(triage-main): add status LED D2 with 1k resistor"
# 5. Push at least once a day, so work is never only on one laptop
git push -u origin sch/triage-main-add-status-led
# 6. Open a pull request on GitHub and request review (see review.md)
# 7. After merge, clean up
git switch main
git pull
git branch -d sch/triage-main-add-status-led
```

## Never two editors on one file

Git cannot merge two people's layout work on the same `.kicad_pcb`. Prevent the collision instead.

1. **Split by file.** Use hierarchical schematic sheets (`power.kicad_sch`, `spo2.kicad_sch`, `bp.kicad_sch`), each its own file, so people can work on different sheets. A board is one file, so only one layout person at a time.
2. **Claim before you edit.** Open a **draft PR** as soon as you start; it is your visible lock. Title it `[PCB] triage-main: route power` or `[SCH power] triage-main: ...`. Also post in the team chat: `CLAIM triage-main PCB until Thu`.
3. Release the claim when the PR merges or closes.
4. **Schematic first, then layout.** Merge the schematic PR; the layout person branches from the fresh `main` and runs Tools → Update PCB from Schematic.

For 6+ people, also keep a pinned issue "Who is editing what" listing open claims.

## Merge conflicts in KiCad files

`.gitattributes` makes Git refuse to half-merge a schematic or board; it stops and asks you to pick one whole version.

```bash
git fetch origin
git merge origin/main
# CONFLICT ... in hardware/triage-main/triage-main.kicad_pcb
# During a merge: --ours = your branch, --theirs = main

# Option A: keep main's board, then redo your (smaller) change in KiCad
git checkout --theirs hardware/triage-main/triage-main.kicad_pcb
# Option B: keep your board, then redo main's (smaller) change in KiCad
git checkout --ours hardware/triage-main/triage-main.kicad_pcb

# After re-applying the lost change in KiCad and saving:
git add hardware/triage-main/triage-main.kicad_pcb
git commit -m "merge: bring in main, re-apply LED placement"
```

Keep the version with more work in it and redo the smaller change by hand. Run DRC before committing.

Text conflicts (`.kicad_pro`, `sym-lib-table`, `fp-lib-table`, `CHANGELOG.md`, firmware) are ordinary: edit out the `<<<<<<<` / `=======` / `>>>>>>>` markers, save, `git add`, `git commit`.

**If it won't resolve cleanly:**

```bash
git merge --abort
mkdir -p out/compare
git show layout/triage-main-route-power:hardware/triage-main/triage-main.kicad_pcb > out/compare/mine.kicad_pcb
```

Make a fresh branch from `main`, open `out/compare/mine.kicad_pcb` in a second standalone PCB Editor as a reference, and redo your change. If both sides changed a lot, get on a 20-minute call; the board owner decides. Afterwards, ask why two people were in the same file. It's almost always a skipped claim.

## Seeing what changed

```bash
# Which files changed on this branch vs main?
git diff --stat main
# Schematic changes word by word (easier for values)
git diff --word-diff main -- hardware/triage-main/triage-main.kicad_sch
```

Look for `(property "Value"`, `(property "Footprint"`, `(property "MPN"` and whole symbol blocks added or removed. Pages of `(at x y)` changes mean something moved; check those visually.

**BOM and PDF diff, side by side:**

```bash
git worktree add ../review-main main
mkdir -p out/compare
kicad-cli sch export bom --output out/compare/bom-main.csv ../review-main/hardware/triage-main/triage-main.kicad_sch
kicad-cli sch export bom --output out/compare/bom-branch.csv hardware/triage-main/triage-main.kicad_sch
git diff --no-index out/compare/bom-main.csv out/compare/bom-branch.csv
kicad-cli sch export pdf --output out/compare/sch-main.pdf ../review-main/hardware/triage-main/triage-main.kicad_sch
kicad-cli sch export pdf --output out/compare/sch-branch.pdf hardware/triage-main/triage-main.kicad_sch
git worktree remove ../review-main
```

Optional visual tools: **KiRI** (KiCad Revision Inspector, leoheck) and **KiDiff** (INTI-CMNB). Check their READMEs for KiCad 10 support first.

## Git LFS

Use it for enclosure CAD, large STEP assemblies, photos and videos. **Never** for `.kicad_sch`, `.kicad_pcb`, `.kicad_sym` or `.kicad_mod`. GitHub Free includes 10 GiB of LFS storage and bandwidth per month; every clone and CI checkout counts.

```bash
git lfs track "mech/**/*.step"
git lfs track "docs/photos/**"
git add .gitattributes
git commit -m "chore: track mechanical CAD and photos with Git LFS"
git lfs ls-files
```
