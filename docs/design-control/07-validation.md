# 07 Validation

**What it's for:** prove the device meets the user needs, with real users, in a real or simulated setting. The question is "did we build the right thing?"

## Questions it answers

- Can an untrained volunteer, with only the quick-start sheet, triage several patients correctly?
- Does the result make sense to someone under time pressure?
- Which needs did we miss?

## How it differs from verification

| | [Verification (06)](06-verification.md) | Validation (07) |
| --- | --- | --- |
| Checks against | Design inputs (DI) | User needs (UN) |
| Who runs it | Usually the team | Real users, not the designers |
| Setting | Bench or lab | As close to the real scene as possible: noise, dim light, time pressure |

## Template: simulated-use session

Decide the success criterion **before** the session.

| Field | What to write | Example: VAL-01 |
| --- | --- | --- |
| Session ID | VAL-xx | VAL-01 |
| Validates | User need IDs | UN-01, UN-02 |
| Participants | Who, how many, how found | [N] students from outside the team, no medical training |
| Scenario | What they face | Three mock patients, based on the challenge package examples: low SpO2 with high heart rate; high BP with an irregular rhythm; weak pulse with low SpO2 |
| Materials | What they get | The device and the quick-start sheet, nothing else |
| What we watch | Tasks | Set up, get a result, rank the patients |
| What we record | Measures | Time per patient, correct ranking, mistakes, SUS score (see [10 Usability](10-usability.md)) |
| Success criterion | Agreed in advance | [team target] of [N] rank all patients correctly |
| Result |  |  |
| Changes made |  |  |

## Two things to sort out first

- **Healthy volunteers give normal readings.** To test abnormal patients, you need a patient simulator, or a clearly labelled scenario mode that plays back recorded vitals. Decide which with the team.
- **Research ethics.** Testing on people, even classmates, may need review by your university's research ethics board under TCPS 2, Canada's research ethics policy. Ask your faculty advisor before the first session.

## What a real device would also need

Clinical validation studies, such as ISO 81060-2 for blood pressure and ISO 80601-2-61 for pulse oximeters. These are beyond a student prototype, but they belong in the pitch's roadmap to clinical use.

## Common mistakes

- **Team members as test users.** They already know how it works.
- **Helping during the session.** If you have to explain, that's a finding; write it down.
- **Only testing the happy path.** Include a lead falling off or a patient who moves.

## Free resources

- [FDA Human Factors guidance](https://www.fda.gov/regulatory-information/search-fda-guidance-documents/applying-human-factors-and-usability-engineering-medical-devices): the section on simulated-use validation testing.
- [TCPS 2 (2022)](https://ethics.gc.ca/eng/tcps2-eptc2_2022_introduction.html): Canada's policy on research involving humans.
- [STRIDE BP](https://www.stridebp.org): how blood pressure monitors are clinically validated, and which ones passed.
- [Greenlight Guru: verification vs validation](https://www.greenlight.guru/blog/design-verification-and-design-validation): validation best practices.
