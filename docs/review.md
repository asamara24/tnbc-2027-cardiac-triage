# Review process

No pull request merges until ERC and DRC are clean, the checklist is ticked, and someone **who did not do the work** has approved it.

## Step 0: load the fab's rules before layout starts

Design rules entered after routing produce a wall of DRC errors. Fill `fab/rules/README.md` from the JLCPCB and PCBWay capability pages (design to the stricter value), enter them in **File → Board Setup**, and re-check before every order.

## ERC and DRC

**Rule: zero errors.** Each warning is either fixed or excluded in the ERC/DRC dialog, with the reason written in the PR description.

Run them in KiCad (Inspect → Electrical Rules Checker / Design Rules Checker), or exactly as CI does:

```bash
bash scripts/check-boards.sh
# macOS: export KICAD_CLI=/Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli first
```

or for one board:

```bash
mkdir -p out
kicad-cli sch erc --severity-error --exit-code-violations \
  --output out/erc.rpt hardware/triage-main/triage-main.kicad_sch
kicad-cli pcb drc --schematic-parity --refill-zones --severity-error --exit-code-violations \
  --output out/drc.rpt hardware/triage-main/triage-main.kicad_pcb
```

## Schematic review checklist

- [ ] Every IC's power pins connected; decoupling capacitors present per datasheet
- [ ] Pin numbers of every new symbol checked against the datasheet (library PR done first)
- [ ] Net names on all inter-sheet and connector signals; no unnamed nets crossing sheets
- [ ] Pull-ups/pull-downs on I²C, reset, enable, boot pins as datasheets require
- [ ] Polarity and orientation of LEDs, diodes, electrolytic caps, connectors
- [ ] Connector pinouts match the mating board or cable (mating part written in a note)
- [ ] Voltage and power ratings of passives fit
- [ ] Every part has `MPN`, `Manufacturer`, `LCSC` (or is marked DNP)
- [ ] Patient-contact circuits (SpO₂ sensor, any electrodes) isolated/current-limited per the DFMEA
- [ ] ERC clean

## Layout review checklist

- [ ] Board Setup matches `fab/rules/README.md` for the target fab
- [ ] Board outline closed on Edge.Cuts; mounting holes match `mech/INTERFACE.md`
- [ ] Decoupling caps close to their pins with short return paths
- [ ] Power and ground track widths suit the current (pump/valve drivers!); ground pour connected and refilled
- [ ] No silkscreen on pads; refdes readable; pin 1 and polarity marks visible
- [ ] Board name and `Rev ${BOARD_REV}` on silkscreen
- [ ] Connector, button and display positions checked in the 3D viewer against the enclosure
- [ ] Test points on power rails and key signals
- [ ] DRC clean with schematic parity

## Reviewing a layout PR

```bash
git fetch origin
git switch layout/triage-main-route-power   # or: gh pr checkout 12
```

Open the board in KiCad, run DRC, look at the 3D view, and compare against screenshots of `main` attached to the PR. **Don't save changes to someone else's branch**; leave comments instead ("U2, top-left, via too close to pad"). Screenshots with arrows help.

## Required approvals

| Change | Approvals | Who |
|---|---|---|
| Docs, report, CI, housekeeping | 1 | Anyone |
| Schematic, layout or firmware, normal work | 1 | Not the author |
| Library part | 1 | Library owner, not the author |
| The PR that will be tagged and ordered | 2 (6+ people) / 1 + lead sign-off (3–5) | Including the board owner |
| ECO on a released board | Same as ordering | Including whoever approved the release |
