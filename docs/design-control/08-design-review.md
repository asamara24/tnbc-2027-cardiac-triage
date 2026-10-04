# 08 Design review

**What it's for:** a short meeting at the end of a stage that decides one of three things: go, go with actions, or fix first.

For board-level checklists (ERC/DRC, schematic and layout), use [`docs/review.md`](../review.md). This template covers the stage-gate review around it.

## Who attends

- The owner of the work, who presents it.
- The lead for that discipline, who chairs.
- At least one person who didn't do the work. Without a fresh pair of eyes it's a status update, not a review.
- Someone taking notes, usually the scientific writer.

## What each review checks

| Review | Ready when | Key questions |
| --- | --- | --- |
| Needs + inputs | Every user need has at least one design input; every input has a test | Is every input measurable? Does any input have no source? |
| Concept + architecture | Decision matrix and interface list are done | Do the design inputs justify the choice? Does every interface have an owner? |
| Detailed design (before ordering the PCB) | Schematic, simulations and BOM are complete | Does every output trace to an input? Are any DFMEA actions still open? |
| Competition readiness | Verification results are in; usability has been tested | Which inputs failed? What is the plan for each? |

## Template: review record

Save completed records in [`docs/reviews/`](../reviews/).

| Field | Example |
| --- | --- |
| Review | Main board schematic review |
| What was reviewed (version) | Main board schematic v0.3 |
| Attendees |  |
| Decision | Go / Go with actions / Fix first |

## Template: findings

Severity scale: **Critical** (safety or compliance risk), **Significant** (fix before moving on), **Minor** (fix, low impact), **Observation** (worth considering).

| # | Severity | Finding | Action | Owner | Closed? |
| --- | --- | --- | --- | --- | --- |
| 1 | Critical (example) | ECG inputs have no series current-limiting resistors | Add series resistors and ESD protection on every patient input | Board architect | No |
| 2 |  |  |  |  |  |

## Tips

- Share the files before the meeting so people arrive having read them.
- Review the work, not the person.
- A review with zero findings usually means nobody read it closely.
- Close every finding in writing, with the version that fixed it.

## Free resources

- [FDA Design Control Guidance](https://www.fda.gov/regulatory-information/search-fda-guidance-documents/design-control-guidance-medical-device-manufacturers): the design review section explains purpose and who should attend.
- [NASA Systems Engineering Handbook (PDF)](https://www.nasa.gov/sites/default/files/atoms/files/nasa_systems_engineering_handbook_0.pdf): Appendix N gives guidance on technical peer reviews.
