# 10 Usability

**What it's for:** make sure a stressed person with little training uses the device correctly. The competition's usability round tests exactly this.

## Questions it answers

- Who uses it, where, and under what stress?
- Which tasks, done wrong, could cause harm or a wrong triage?
- Did real users manage those tasks without help?

## The process (IEC 62366-1, simple version)

1. **Use specification:** who uses it, on whom, where.
2. **Critical tasks:** tasks where a mistake could hurt someone or give a wrong priority.
3. **Formative tests:** small, early, informal tests to find problems. Fix them and test again.
4. **Summative test:** the final test that shows users can do the critical tasks. It feeds [07 Validation](07-validation.md).

## Template: critical tasks

Example rows.

| ID | Task | What could go wrong | Possible harm | Design fix |
| --- | --- | --- | --- | --- |
| T-01 | Attach ECG leads | Leads swapped or loose | Wrong rhythm reading | Colour-coded leads; lead-off alert |
| T-02 | Place the SpO2 clip | Clip put on the cuff arm | No reading while the cuff inflates | Picture on the quick-start sheet; on-screen warning |
| T-03 | Wrap the cuff | Wrong cuff size | Wrong BP reading | Size range printed on each cuff |
| T-04 | Start a new patient | Forgets to start a new record | Readings on the wrong patient | Device forces a "new patient" step |
| T-05 | Read the result | Misreads the priority in bright sun | Wrong priority | Colour, word and shape together |
| T-06 |  |  |  |  |

## Template: formative test log

| Round | Participants | Problems seen | Fix | Retested? |
| --- | --- | --- | --- | --- |
| 1 |  |  |  |  |

## Measuring it: the System Usability Scale (SUS)

After each session, users rate 10 standard statements from 1 (strongly disagree) to 5 (strongly agree). To score it:

- Odd-numbered items: score minus 1.
- Even-numbered items: 5 minus score.
- Add them up and multiply by 2.5. The result is 0 to 100; higher is better.

## Rules for the quick-start sheet

- One page, pictures first, numbered steps.
- Every critical task appears on it.
- Test it on someone who has never seen the device. Don't help them.

## Free resources

- [FDA Human Factors guidance](https://www.fda.gov/regulatory-information/search-fda-guidance-documents/applying-human-factors-and-usability-engineering-medical-devices): critical tasks, formative and validation testing.
- [OpenRegulatory templates](https://openregulatory.com/templates/): free IEC 62366 usability evaluation plan, protocol and report.
- [Digital.gov: System Usability Scale](https://digital.gov/2014/08/29/system-usability-scale-improving-products-since-1986): the 10 statements and how teams use them.
