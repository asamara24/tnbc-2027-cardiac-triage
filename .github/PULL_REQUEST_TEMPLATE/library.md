## New library part: <part name / MPN>

<!-- Library PRs touch only lib/. Branch: lib/add-<part>. The reviewer must not be the person who drew the part. -->

- Datasheet: <manufacturer URL>, revision/date: ____

## New-part checklist
- [ ] Datasheet link is the manufacturer's page, and the revision/date is noted
- [ ] Symbol pin numbers match the datasheet pin table, including exposed pad
- [ ] Footprint pad sizes follow the datasheet's recommended land pattern
- [ ] Pin 1 marked on silkscreen and fab layer; courtyard present
- [ ] 3D model lines up with pads in the 3D viewer (check pin 1 and rotation)
- [ ] `MPN`, `Manufacturer`, `LCSC` filled; LCSC number checked in the JLCPCB parts library
- [ ] Row added to `lib/PARTS.csv`, including unit cost and source (bought/donated)

## Drawn by / checked by
- Drawn by: @____
- Checked by: @____ (not the author)
