# 09 Risk (DFMEA)

**What it's for:** list how each part could fail, what that would do to the patient or user, and how we stop it from causing harm. The competition rules require every failure mode in the DFMEA to be mitigated.

The team's filled-in DFMEA lives in [`docs/dfmea/`](../dfmea/). Copy this template there to start it.

## Questions it answers

- How can each block fail?
- What happens to the patient or user if it does?
- How bad, and how likely?
- What did we add to prevent it, and did we test that it works?

## How to do it

1. Pick one block, for example the BP cuff system.
2. List what it must do.
3. For each job, brainstorm how it could fail.
4. Write the effect on the patient or user.
5. Rate severity (S) and how often it could happen (O), 1 to 5 each.
6. Add a control, link the test that proves it works, then re-rate.

FMEA is one tool that teams use for the risk analysis ISO 14971 asks for. ISO 14971 is the medical-device risk management standard.

## Pick controls in this order

1. **Safe by design.** Remove the hazard. Example: a valve that opens by itself when power is lost.
2. **Protective measure.** Catch it when it happens. Example: a hardware pressure cut-off.
3. **Information.** A warning on the quick-start sheet. This is the weakest; use it only when the first two aren't possible.

## Rating scales

The team can adjust these, but agree on them before rating anything.

| Score | Severity (S) | Occurrence (O) |
| --- | --- | --- |
| 1 | No injury, minor annoyance | Very unlikely |
| 2 | Discomfort, no treatment needed | Unlikely |
| 3 | Minor injury, or a delayed triage | Possible |
| 4 | Injury needing treatment, or a wrong triage | Likely |
| 5 | Serious injury | Very likely |

## Template

Example rows; the S and O numbers are illustrations, not ratings.

| ID | Block | Failure mode | Effect on patient or user | S | O | Control (type) | Verified by | S × O after |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| R-01 | BP cuff | Pump keeps running | Painful overpressure on the arm | 5 | 2 | Hardware pressure cut-off and maximum-time timer (protective) | VER-xx |  |
| R-02 | BP cuff | Power lost mid-inflation | Cuff stays tight | 4 | 2 | Valve opens without power (by design) | DI-04 test |  |
| R-03 | Pressure sensor | Tube pops off the sensor | Sensor reads zero; pump keeps going | 5 | 2 | Timer cuts the pump; consider a mechanical relief valve (protective) | VER-xx |  |
| R-04 | Power | Charger plugged in while connected to a patient | Leakage current path to the patient | 5 | 2 | Hardware switches off patient circuits while charging (by design) | VER-xx |  |
| R-05 | Triage output | Readings shown for the wrong patient | Wrong priority | 4 | 3 | Forced "new patient" step (by design); numbered patient tags (information) | VAL-01 |  |
| R-06 | SpO2 | Reading biased on darker skin | Low oxygen missed | 4 | 3 | Test across skin tones; show reading confidence; state the limitation (information) | VER-03 |  |
| R-07 |  |  |  |  |  |  |  |  |

Any row with severity 5 needs a control, however unlikely it seems.

## Common mistakes

- **Rating before agreeing the scales.** Everyone's "3" means something different.
- **Controls that are only warnings.** Judges and regulators look for design fixes first.
- **Controls never tested.** Every control needs a verification ID.

## Free resources

- [ASQ: What is FMEA?](https://asq.org/quality-resources/fmea): step-by-step method and a [free FMEA spreadsheet template](https://asq.org/-/media/public/learn-about-quality/data-collection-analysis-tools/asq-fmea-template.xls).
- [OpenRegulatory ISO 14971 templates](https://openregulatory.com/iso-14971-templates): free FMEA risk table, risk management plan and report.
- [ISO 14971 page](https://www.iso.org/contents/data/standard/07/27/72704.html): free preview of the standard's scope and definitions.
