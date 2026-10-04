# 11 Traceability matrix

**What it's for:** one table that links every user need to its design inputs, outputs, tests and risks. A blank cell is a gap someone has to close.

## Questions it answers

- Does every user need have at least one design input?
- Does every design input have an output and a test?
- Is every risk control verified?
- What is still open?

## Template

One row per design input. Example rows use the IDs from the other templates. Status is one of: Open, Verified, Failed.

| User need | Design input | Design output | Verification | Validation | Risk link | Status |
| --- | --- | --- | --- | --- | --- | --- |
| UN-01 | DI-01 | DO-04 firmware, DO-07 quick-start | VER-01 | VAL-01 | R-05 | Open |
| UN-01 | DI-02 | DO-04 firmware | VER-02 | VAL-01 |  | Open |
| UN-03 | DI-04 | DO-01 schematic (valve driver) | VER-04 |  | R-02 | Open |
| UN-06 | DI-03 | DO-01 schematic, DO-05 triage logic | VER-03 |  | R-06 | Open |
|  |  |  |  |  |  |  |

## How to check it

- Read down each column: any blank in Design input, Design output or Verification is a gap.
- Every risk control in [09 Risk](09-risk-dfmea.md) needs its own row, even if no user need asked for it.
- Before each design review, sort by Status and look at everything still Open or Failed.

## Common mistakes

- **Building it at the end.** Add rows as each stage happens; reconstructing it later is painful.
- **Linking to a whole document.** Point to the exact ID, such as VER-03, not "the test report".

## Free resources

- [Greenlight Guru: what a traceability matrix is and how to build one](https://www.greenlight.guru/blog/traceability-matrix).
- [NASA: Requirements Verification Matrix](https://www.nasa.gov/reference/appendix-d-requirements-verification-matrix): a worked example of the verification half.
