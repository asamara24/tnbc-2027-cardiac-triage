# 04 Concept & architecture

**What it's for:** come up with several ways to meet the design inputs, pick one with a fair comparison, then draw how the parts connect.

## Questions it answers

- What are at least three ways to solve each big choice?
- Which one best meets the design inputs, and why?
- What are the blocks, and what passes between them?

## Step 1: generate concepts

List at least three options for each big choice before judging any. Big choices for our device:

- One handheld unit, or a hub with sensor pods?
- For each sensor: a ready-made chip, or a circuit we design ourselves?
- How is the result shown: screen, lights, sound, or a mix?

## Step 2: choose with a decision matrix

Criteria come from the design inputs. Weight each 1 to 5, score each concept 1 to 5, multiply and add. The scores below are blank on purpose; fill them in as a team.

| Criterion (design input) | Weight (1–5) | A: single handheld | B: hub + pods | C: |
| --- | --- | --- | --- | --- |
| Setup time (DI-02) |  |  |  |  |
| Measurement accuracy (DI-03) |  |  |  |  |
| Patient safety (DI-04) |  |  |  |  |
| Cost within the $1,500 cap |  |  |  |  |
| Build risk with our skills |  |  |  |  |
| **Weighted total** |  |  |  |  |

## Step 3: architecture

Draw a block diagram, then list every interface: anything that crosses from one block or person's work to another's.

| ID | From | To | What passes | How (bus, connector, tube) | Owner |
| --- | --- | --- | --- | --- | --- |
| IF-01 | ECG front end | Microcontroller | ECG samples | SPI bus | Board architect + firmware |
| IF-02 | Pressure sensor | ADC | Cuff pressure | Analog voltage | Board architect |
| IF-03 | Main unit | BP cuff | Air | Tube + quick-release connector | Mechanical |
| IF-04 | Battery | Power rails | Power | On-board | Board architect |
| IF-05 |  |  |  |  |  |

The interface rows are examples based on one candidate design.

## Common mistakes

- **Choosing first, scoring second.** Fill the matrix before anyone argues for a favourite.
- **Criteria that aren't design inputs.** "Looks cool" doesn't belong unless it traces to a need.
- **Forgetting cross-team interfaces.** Most integration bugs live where electrical meets mechanical or firmware.

## Free resources

- [AHRQ: Decision matrix how-to](https://digital.ahrq.gov/health-it-tools-and-resources/evaluation-resources/workflow-assessment-health-it-toolkit/all-workflow-tools/decision-matrix): six steps for a weighted decision matrix.
- [NASA Systems Engineering Handbook (PDF)](https://www.nasa.gov/sites/default/files/atoms/files/nasa_systems_engineering_handbook_0.pdf): Appendix L is an outline for documenting interfaces.
- [MIT Medical Device Design syllabus](https://meddevdesign.mit.edu/wp-content/uploads/275_2025_Syllabus-FINAL.pdf): how concept generation and selection fit into a student project.
