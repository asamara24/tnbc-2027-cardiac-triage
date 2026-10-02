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
| `scripts/` | Build, check and release scripts |

## Board owners

| Board | Owner | Current revision | Target fab |
|---|---|---|---|
| _(add when the first board is created)_ | | | |

## How we work (from *PCB Design Control for Small Electrical Teams*)

1. Everyone uses the **same major KiCad version (10.x)**.
2. Nobody pushes to `main` directly. Branch → pull request → at least one approval.
3. **One editor per file.** Claim the schematic or PCB in the team chat or on an issue before editing; release it when your PR merges.
4. Every PR shows clean **ERC and DRC** before review.
5. **Only order boards from a tag** (e.g. `triage-main-revA`). The fab zip is attached to that tag's GitHub Release.
6. One line in `CHANGELOG.md` for every change that affects a board.
7. After a revision is ordered, changes go through an **ECO** issue.

## Getting started

```bash
git clone <repo-url>
cd <repo>
git lfs install
```

New KiCad project: File → New Project, save as `hardware/<board>/<board>.kicad_pro`. Link the team library with project-relative paths:

- Symbols: `${KIPRJMOD}/../../lib/symbols/team.kicad_sym`
- Footprints: `${KIPRJMOD}/../../lib/footprints/team.pretty`
