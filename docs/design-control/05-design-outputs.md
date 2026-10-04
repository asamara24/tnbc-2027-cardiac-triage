# 05 Design outputs

**What it's for:** keep the files that fully describe the design, so another team could build the device from them alone. Each output says which inputs it meets.

## Questions it answers

- Could someone else build our device from these files?
- Does every design input have an output that meets it?
- Which version is current, and has it been reviewed?

## Template: outputs register

Example rows.

| ID | Output | Type | Meets inputs | Version | Owner | Reviewed? |
| --- | --- | --- | --- | --- | --- | --- |
| DO-01 | Main board schematic | KiCad files | DI-01, DI-04, DI-05 | v0.1 | Board architect | Not yet |
| DO-02 | LTspice simulations | Sim files + results | DI-04 | v0.1 | Board architect | Not yet |
| DO-03 | Bill of materials | `lib/PARTS.csv` | DI-05 | v0.1 | Electrical lead | Not yet |
| DO-04 | Firmware | Source code in Git | DI-01, DI-02 | v0.1 | Firmware | Not yet |
| DO-05 | Triage logic description | Document | DI-01 | v0.1 | Signal processing | Not yet |
| DO-06 | Enclosure and cuff CAD | CAD files | DI-06 | v0.1 | Mechanical | Not yet |
| DO-07 | Quick-start sheet | One page | UN-02 | v0.1 | Scientific writer | Not yet |

## Template: decision log

One line per real decision, written when it's made. The report writer will thank you.

| Decision | Options considered | Chosen | Why | Decided by |
| --- | --- | --- | --- | --- |
| ECG front-end chip (example) | AD8232, ADS1292R, own circuit | ADS1292R | Built-in right-leg drive and lead-off detection, digital output, can also measure breathing | Electrical lead |
|  |  |  |  |  |

## Firmware: the simple version of IEC 62304

IEC 62304 is the software lifecycle standard. It sorts software into class A, B or C by how badly a failure could hurt someone; a higher class means more documentation and testing. For a student prototype, keep three things:

1. A short software requirements list, each line traced to a design input.
2. A list of third-party libraries and their versions (the standard calls these SOUP: software of unknown provenance).
3. Everything in version control (Git), with a tag for each tested version.

## Common mistakes

- **Files with no version number.** Nobody can tell which schematic was tested.
- **Decisions with no "why".** In three months nobody will remember, and the report needs it.
- **Outputs that trace to nothing.** A feature no input asks for is scope creep.

## Free resources

- [FDA Design Control Guidance](https://www.fda.gov/regulatory-information/search-fda-guidance-documents/design-control-guidance-medical-device-manufacturers): the design output section.
- [OpenRegulatory IEC 62304 templates](https://openregulatory.com/iec-62304-templates): free software plan, requirements and SOUP list templates.
