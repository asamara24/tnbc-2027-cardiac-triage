# 03 Design inputs

**What it's for:** turn each user need into measurable requirements the design must meet. If nobody can write a test for it, it isn't a design input yet.

## Questions it answers

- What exactly must the device do, and how well?
- Under what conditions?
- How will we check it, and what counts as a pass?

## The formula

**The device shall** [do something] [how well] [under what condition]. Then add the test method and the pass criterion.

## Template

Example rows only. Numbers marked [check standard] must come from the standard itself; [team target] is a number the team picks and justifies.

| ID | From | Requirement ("shall") | How we test it | Pass if | Source |
| --- | --- | --- | --- | --- | --- |
| DI-01 | UN-01 | The device shall show the priority as a colour, a word and a shape | Inspection | All three appear on every result screen | Team |
| DI-02 | UN-01 | The device shall show a priority within [team target] s of the last sensor going on | Timed test, 10 runs | Every run within the target | Team |
| DI-03 | UN-06 | The device shall measure SpO2 within ±[check standard] % of a reference oximeter | Paired readings against the reference | Error within the limit | ISO 80601-2-61 |
| DI-04 | UN-03 | The cuff shall deflate below [check standard] mmHg within [check standard] s when power is lost | Remove the battery during inflation | Pressure meets the limit with no power | Risk R-02 |
| DI-05 | UN-04 | The device shall run on its internal battery only | Inspection + run test | Completes [team target] triages on one charge | Challenge package |
| DI-06 | UN-05 | The BP cuffs shall fit arm sizes from [team target] | Fit test on volunteers | Every listed size fits | Challenge package |
| DI-07 |  |  |  |  |  |

## Checklist for every row

- One "shall" per row.
- A number, not an adjective. "Fast", "accurate" and "easy" are not inputs.
- Says **what**, not **how**. No part numbers here; those are outputs.
- Has a test and a pass criterion written now, not later.
- Traces back to a user need, a rule, a standard or a risk. Risk controls are inputs too.

## Common mistakes

- **Vague words.** "User-friendly" can't be tested. "A volunteer completes setup in under [team target] s using only the quick-start sheet" can.
- **Picking the part too early.** "Shall use the ADS1292R" is a design output, not an input.
- **Guessing standard limits from memory.** Leave [check standard] until someone has read the standard.

## Free resources

- [NASA: How to Write a Good Requirement](https://www.nasa.gov/seh/appendix-c-how-to-write-a-good-requirement): the best one-page checklist for this stage.
- [Greenlight Guru: bridging user needs into design requirements](https://www.greenlight.guru/blog/bridging-user-needs-into-design-requirements): worked examples of needs becoming inputs.
- [FDA Design Control Guidance](https://www.fda.gov/regulatory-information/search-fda-guidance-documents/design-control-guidance-medical-device-manufacturers): the design input section.
