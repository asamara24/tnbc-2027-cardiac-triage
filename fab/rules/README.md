# Fab rules

Enter these in KiCad **File → Board Setup before layout starts**. Design to the stricter of the two fabs so either can build the board. Re-check the fab pages before every order.

| Category | Where in KiCad Board Setup | JLCPCB (date) | PCBWay (date) | Value we use |
|---|---|---|---|---|
| Layer count, board thickness | Board Stackup → Physical Stackup | | | |
| Copper weight, outer and inner | Board Stackup → Physical Stackup | | | |
| Minimum track width | Design Rules → Constraints | | | |
| Minimum clearance (copper to copper) | Design Rules → Constraints | | | |
| Minimum via hole (drill) | Design Rules → Constraints | | | |
| Minimum via diameter (pad) | Design Rules → Constraints | | | |
| Minimum annular ring | Design Rules → Constraints | | | |
| Minimum hole-to-hole spacing | Design Rules → Constraints | | | |
| Minimum hole-to-copper clearance | Design Rules → Constraints | | | |
| Copper-to-board-edge clearance | Design Rules → Constraints | | | |
| Solder mask expansion, minimum mask web | Solder Mask/Paste | | | |
| Silkscreen min line width and text height | Design Rules → Constraints; Text & Graphics | | | |
| Minimum slot / NPTH size | Design Rules → Constraints, or Custom Rules | | | |
| Special features (castellated, via-in-pad, impedance) | Custom Rules + order options | | | |
| Board size limits, panelisation | Not a KiCad rule: check before ordering | | | |

No numbers are pre-filled on purpose: fab capabilities change and differ by layer count, copper weight and price tier. Take them from JLCPCB "PCB Capabilities" and PCBWay "PCB Capabilities" on the day you check, and write the date.

**Recommended:** once filled, save an empty board with these settings as `fab/rules/two-layer-rules.kicad_pcb`. For each new board use Board Setup → Import Settings to copy them in.
