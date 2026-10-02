# Portable Cardiac Triage System — True North Biomedical Competition 2026-27

TMU Biodesign's entry to the True North Biomedical Competition (CUBEC, title sponsor Boston Scientific).

**The challenge:** a portable, interoperable device that measures **SpO₂, blood pressure and heart rate**, works with no external power or network, adjusts to different patient sizes, and outputs a clear **High / Medium / Low priority** triage recommendation. It is framed as decision support, not autonomous diagnosis.

## Key dates

| Milestone | Date |
|---|---|
| Boston Scientific workshop | October |
| Design process workshop + Check-in 1 | November |
| Check-in 2 + Business pitch workshop | January |
| **Design report + CAD due** | **Feb 5, 2027** |
| Pitch deck due | Mar 5, 2027, 11:59 pm EST |
| **Competition weekend** (Western University) | **Mar 6–7, 2027** |

Budget cap: **$1500** (purchased + donated parts; tools excluded). Track every part in `lib/PARTS.csv`.

## What lives where

| Folder | Contents |
|---|---|
| `hardware/` | KiCad projects, one folder per board (`hardware/<board>/`) |
| `lib/` | Team KiCad library (symbols, footprints, 3D) and `PARTS.csv` approved-parts / budget register |
| `fab/rules/` | Fab capability notes (JLCPCB / PCBWay), with the date checked |
| `fab/orders/` | One record per board order: tag, fab, date, options, order number |
| `firmware/` | Microcontroller code (sensor drivers, triage logic) |
| `software/` | Any companion tools: data logging, analysis, display UI |
| `mech/` | Enclosure CAD, cuff/strap design, STEP/DXF exchange with the PCB |
| `docs/report/` | Design report drafts (10 pages max, 12 pt, double-spaced, IEEE refs) |
| `docs/dfmea/` | DFMEA (required by Rules §2.2) |
| `docs/pitch/` | Business pitch deck and budget breakdown |
| `docs/eco/`, `docs/reviews/` | Engineering change orders, review and bring-up notes |
| `scripts/` | `check-boards.sh` (ERC/DRC) and `build-release.sh` (fab package) |
| `docs/templates/` | Board README, FAB-NOTES, order record, library tables |

## Team

| Name | Role | GitHub |
|---|---|---|
| Ali Samara | | @asamara24 |

_New members: add yourself here as your first PR (see `docs/onboarding.md`)._

## Board owners

| Board | Owner | Current revision | Target fab |
|---|---|---|---|
| _(add when the first board is created)_ | | | |

## How we work

Based on *PCB Design Control for Small Electrical Teams* (@Adhavaa). The seven essentials:

1. Everyone uses the **same major KiCad version (10.x)**.
2. Nobody pushes to `main` directly. Branch → pull request → at least one approval from someone who isn't the author.
3. **One editor per file.** Claim the schematic or PCB with a draft PR (plus a chat message) before editing.
4. Every PR shows clean **ERC and DRC**. CI runs them automatically.
5. **Only order boards from a tag** (e.g. `triage-main-revA`). CI builds the fab package and attaches it to that tag's GitHub Release.
6. One line in `CHANGELOG.md` for every change that affects a board.
7. After a revision is ordered, changes go through an **ECO** issue.

| Doc | What's in it |
|---|---|
| [`docs/onboarding.md`](docs/onboarding.md) | Install KiCad + Git, day-one checklist, access and backups |
| [`docs/workflow.md`](docs/workflow.md) | Branch names, commit messages, daily loop, claiming files, merge conflicts, diffs, LFS |
| [`docs/review.md`](docs/review.md) | Fab rules, ERC/DRC, schematic and layout checklists, required approvals |
| [`docs/release.md`](docs/release.md) | Revisions and tags, pre-release checklist, release package, order records, ECO/ECN, changelog |
| [`docs/recovery.md`](docs/recovery.md) | Common mistakes and how to undo them |
| [`docs/practice-exercise.md`](docs/practice-exercise.md) | 2–3 hour team dry run with a throwaway LED board |
| [`docs/cheat-sheet.md`](docs/cheat-sheet.md) | One page to print |
| [`lib/README.md`](lib/README.md) | Team library rules, required symbol fields, who approves parts |
| [`mech/README.md`](mech/README.md) | Enclosure workflow and KiCad ↔ CAD exchange |

## Automation

| File | Runs | Does |
|---|---|---|
| `.github/workflows/checks.yml` | Every PR and push to `main` | `scripts/check-boards.sh`: ERC + DRC on every board in the KiCad 10 Docker image |
| `.github/workflows/release.yml` | Every `*-rev*` tag | `scripts/build-release.sh`: revision check, ERC/DRC, Gerbers, drill, BOMs (JLCPCB + PCBWay), placement, PDFs, STEP, checksums → GitHub Release (`-rc` tags become pre-releases) |

## Getting started

```bash
git clone git@github.com:asamara24/tnbc-2027-cardiac-triage.git
cd tnbc-2027-cardiac-triage
git lfs install
```

New board:

```bash
mkdir -p hardware/<board>
cp docs/templates/sym-lib-table docs/templates/fp-lib-table docs/templates/FAB-NOTES.md hardware/<board>/
cp docs/templates/board-README.md hardware/<board>/README.md
```

Then in KiCad: File → New Project, save as `hardware/<board>/<board>.kicad_pro`, and add the text variable `BOARD_REV = A` (Schematic Setup → Project → Text Variables).
