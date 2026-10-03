# 06 Verification

**What it's for:** prove each design input is met, using a written test and a recorded result. The question is "did we build it right?"

## Questions it answers

- Does every design input have a test?
- Did each test pass, with numbers to show it?
- If it failed, what did we change?

## Four ways to verify

| Method | Meaning | Example |
| --- | --- | --- |
| Test | Measure it | Our SpO2 vs a reference oximeter |
| Inspection | Look at it | Result screen shows colour, word and shape |
| Analysis | Calculate or simulate it | LTspice shows the overpressure cut-off trips in time |
| Demonstration | Show it working | Device runs a full triage on battery |

## Template: one protocol per test

Write this **before** running the test, and don't change the pass criterion afterwards. Save completed protocols in [`docs/reviews/`](../reviews/).

| Field | What to write | Example: VER-03 |
| --- | --- | --- |
| Test ID | VER-xx | VER-03 |
| Verifies | Design input IDs | DI-03 |
| Purpose | One line | Check SpO2 accuracy against a reference oximeter |
| Equipment | Device version + instruments | Our device v0.2; reference fingertip oximeter [model] |
| Setup | Steps someone else can repeat | Seated, rested; our clip on one hand, reference on the other |
| Pass criterion | Copied from the design input | Error within ±[check standard] % |
| Sample size | How many people and readings | [N] volunteers × [M] readings |
| Result | Numbers, not "it worked" |  |
| Pass / fail |  |  |
| Tested by / checked by | Two different people |  |

## Template: results log

| Test ID | Verifies | Device version | Result | Pass / fail | Notes |
| --- | --- | --- | --- | --- | --- |
|  |  |  |  |  |  |

## Tips for our device

- **Test rhythm detection on recorded ECGs first.** The free MIT-BIH Arrhythmia Database has 48 half-hour recordings with expert labels.
- **Choose a validated reference BP monitor.** STRIDE BP lists monitors that passed recognised validation protocols.
- **Test SpO2 across skin tones.** FDA's draft pulse-oximeter guidance focuses on accuracy differences linked to skin pigmentation. Recruit a range of volunteers and report results honestly.
- **Testing on people?** Check with your faculty advisor whether research ethics review is needed first (see [07 Validation](07-validation.md)).

## Common mistakes

- **The designer tests their own work alone.** A second person should check the result.
- **Moving the goalposts.** Changing the pass criterion after seeing the result defeats the test.
- **"It worked."** Record the numbers, the device version and the setup.

## Free resources

- [NASA: Requirements Verification Matrix](https://www.nasa.gov/reference/appendix-d-requirements-verification-matrix): an example matrix showing how every requirement gets verified.
- [Greenlight Guru: beginner's guide to verification and validation](https://www.greenlight.guru/blog/design-verification-and-design-validation): the difference, with best practices.
- [PhysioNet: MIT-BIH Arrhythmia Database](https://physionet.org/content/mitdb/1.0.0/): free labelled ECG recordings for testing.
- [STRIDE BP](https://www.stridebp.org): lists of validated blood pressure monitors.
- [FDA: Pulse oximeters](https://www.fda.gov/medical-devices/products-and-medical-procedures/pulse-oximeters): FDA's page on accuracy concerns, linking the draft guidance.
