# <board>

- **Purpose:** <one line: what this board does in the triage system>
- **Owner:** @____
- **Current revision:** A (`BOARD_REV` in the project's text variables)
- **Target fab:** JLCPCB / PCBWay
- **Firmware supported:** see `firmware/README.md`

## Files

| File | What |
|---|---|
| `<board>.kicad_pro` | Project settings, net classes, `BOARD_REV` |
| `<board>.kicad_sch` | Root schematic (one extra `.kicad_sch` per hierarchical sheet) |
| `<board>.kicad_pcb` | The board |
| `sym-lib-table`, `fp-lib-table` | Point at the team library (`${KIPRJMOD}/../../lib/...`) |
| `FAB-NOTES.md` | Board specs for the fab, filled before every tag |

## Revisions

| Tag | Date | Ordered from | Notes |
|---|---|---|---|
