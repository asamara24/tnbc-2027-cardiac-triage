# Team library

Every part with a specific manufacturer part number, and every footprint we drew or modified, lives here. Generic passives and common connectors can use KiCad's official libraries.

| Path | Contents |
|---|---|
| `symbols/team.kicad_sym` | Team symbols (library nickname `team`) |
| `footprints/team.pretty/` | Team footprints, one `.kicad_mod` each |
| `3d/` | STEP models, named the same as their footprint |
| `PARTS.csv` | Approved-parts register **and budget tracker** (cost columns count toward the $1500 cap) |

## Hooking a board up to the library

In each board's project (Preferences → Manage Symbol / Footprint Libraries → Project Specific Libraries):

| Library | Nickname | Path |
|---|---|---|
| Symbols | `team` | `${KIPRJMOD}/../../lib/symbols/team.kicad_sym` |
| Footprints | `team` | `${KIPRJMOD}/../../lib/footprints/team.pretty` |
| 3D model (per footprint) | | `${KIPRJMOD}/../../lib/3d/<footprint-name>.step` |

Commit the `sym-lib-table` and `fp-lib-table` files KiCad writes. Ready-made copies are in `docs/templates/`. **Never use an absolute path** like `/Users/ali/...`.

## Naming

| Item | Convention | Example |
|---|---|---|
| Part-specific symbol | Manufacturer part number or series | `MAX30102` |
| Footprint | KiCad Library Convention: package, size, pitch | `SOT-23-5` |
| Part-specific footprint | Manufacturer + part or series | `Molex_PicoBlade_53047-0410` |
| 3D model | Same name as its footprint | `SOT-23-5.step` |

## Required fields on every team symbol

| Field | Contents |
|---|---|
| Value | `10k`, `100nF`, or the part name |
| Footprint | `team:...` or an official footprint |
| Datasheet | Manufacturer datasheet URL (not a PDF in the repo) |
| Description | One line: what it is |
| MPN | Manufacturer part number |
| Manufacturer | Manufacturer name |
| LCSC | JLCPCB/LCSC part number (starts with `C`) |

MPN + Manufacturer is the fab-agnostic truth; LCSC is a JLCPCB convenience. Keeping both means switching fabs changes only the BOM export, not the design.

## Who approves new parts

1. Library changes go in **their own PR touching only `lib/`**, on a branch named `lib/add-<part>`. Open it with the library template: add `?template=library.md` to the new-PR URL.
2. **The person who drew a part cannot approve it.** A second person checks it against the datasheet.
3. Library owners are listed in `.github/CODEOWNERS` and are requested automatically.

## PARTS.csv

One row per approved part. `status` is `approved`, `in-review` or `do-not-use`; keep obsolete parts listed and marked so nobody re-adds them. `source` is `bought` or `donated`. Donated parts still count toward the budget at the value we place on them (Rules §2.1).

## JLCPCB vs PCBWay assembly BOMs

| | JLCPCB | PCBWay |
|---|---|---|
| Parts identified by | JLCPCB/LCSC part number | MPN or distributor part number + description |
| Library must hold | `LCSC` field | `MPN` + `Manufacturer` fields |
