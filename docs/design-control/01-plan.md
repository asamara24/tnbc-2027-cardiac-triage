# 01 Plan

**What it's for:** agree who does what, how decisions get made, and what "done" means, before anyone designs anything.

## Questions it answers

- What are we building, in one sentence?
- What is in scope, and what is not?
- Who owns each block and each document?
- Which stage ends get a design review?
- Which rules and standards apply?
- Where do files live, and how do we name versions?

## Template

The right-hand column is an example draft. Replace it with the team's decisions.

| Section | What to write | Example draft |
| --- | --- | --- |
| Project goal | One sentence | A portable, battery-only device that measures SpO2, blood pressure and heart rhythm and suggests a High, Medium or Low triage priority, as decision support |
| In scope | What we will build | Main unit, ECG leads, SpO2 clip, BP cuffs, quick-start sheet |
| Out of scope | What we will not build | Diagnosis, cloud or internet features |
| Owners | Each block and document → one person | See [Who owns which template](README.md#who-owns-which-template) |
| Design reviews | Which stage ends get a review | After design inputs, after architecture, before ordering the PCB, before the competition |
| Rules that apply | Competition rules + standards list | Challenge package; standards list from the clinical & regulatory advisor |
| Budget | The cap and who approves spending | $1,500 cap, donated parts counted at their value; leads approve their own block's spending |
| Files | Where they live and how they're named | This repo; see [`docs/workflow.md`](../workflow.md) for branch and file names |
| Changes | How we change something already decided | A pull request with one line on what and why, approved by the owner and their lead |

## Common mistakes

- **Planning tasks but not decisions.** Write down who decides, not just who works.
- **No out-of-scope list.** Without one, scope creeps until nothing finishes.
- **A plan nobody updates.** Change it when reality changes; it is a living file.

## Free resources

- [FDA Design Control Guidance](https://www.fda.gov/regulatory-information/search-fda-guidance-documents/design-control-guidance-medical-device-manufacturers): read the design and development planning section.
- [MIT Medical Device Design course](https://meddevdesign.mit.edu/): how a university course runs a student medical-device design process. Its [syllabus](https://meddevdesign.mit.edu/wp-content/uploads/275_2025_Syllabus-FINAL.pdf) shows the phases.
