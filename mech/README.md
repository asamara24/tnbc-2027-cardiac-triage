# Mechanical

Enclosure CAD, cuff/strap and finger-clip designs, board outline DXFs, and STEP exchange with the PCB. The board and enclosure meet at a short written interface, [`INTERFACE.md`](INTERFACE.md), that both sides own.

Required for the **Feb 5 submission**: overall assembly model and an exploded view with BOM.

## Rules

- Large STEP assemblies and enclosure CAD files go through **Git LFS**:
  ```bash
  git lfs track "mech/**/*.step"
  git lfs track "mech/**/*.stp"
  git add .gitattributes
  ```
  Never put `.kicad_*` files in LFS (it hides their diffs).
- **Cloud CAD (Onshape, Fusion):** at each board release, create a named version in that tool with the same name as the tag, export a STEP snapshot and commit it here.
- **File-based CAD (SolidWorks, FreeCAD):** commit the files here through LFS, so the board tag also captures the enclosure that fits it.
- Before every release, the mechanical owner opens the new full-board STEP inside the enclosure and ticks "Mechanical fit checked" on the pre-release checklist.

## Exports from KiCad

```bash
# Board + components, for fit checks (the release package already contains this)
kicad-cli pcb export step --subst-models --force \
  --output out/<board>-full.step hardware/<board>/<board>.kicad_pcb
# Bare board with holes, lighter for designing the enclosure around
kicad-cli pcb export step --board-only --force \
  --output out/<board>-board.step hardware/<board>/<board>.kicad_pcb
# 2D outline in mm (DXF defaults to inches), using the drill/place origin
kicad-cli pcb export dxf --layers Edge.Cuts --mode-single --output-units mm \
  --use-drill-origin --output out/<board>-outline.dxf hardware/<board>/<board>.kicad_pcb
# 1:1 paper print for a fit check (print at 100%, measure a known dimension)
kicad-cli pcb export pdf --layers "F.Fab,Edge.Cuts" --mode-single --scale 1 \
  --output out/<board>-1to1.pdf hardware/<board>/<board>.kicad_pcb
```

Bringing a mechanical outline in: export a DXF of the outline (mm, 1:1, origin at the agreed corner), then in the PCB Editor use File → Import → Graphics onto Edge.Cuts. Place mounting holes as `MountingHole` footprints at the coordinates in `INTERFACE.md`, not by eye.

## With no dedicated mechanical engineer

1. **Buy before you draw.** If we use an off-the-shelf enclosure, record its model number and dimension-drawing link below before layout starts.
2. Sketch the enclosure's inner wall and bosses on the `User.Drawings` layer (never sent to the fab).
3. Check part heights against lid clearance in the 3D viewer.
4. 3D-print a test fit from the bare-board STEP before committing to an enclosure.

## Off-the-shelf parts used

| Part | Model | Dimension drawing |
|---|---|---|

## Board ↔ enclosure compatibility

| Board tag | Enclosure | Status |
|---|---|---|
