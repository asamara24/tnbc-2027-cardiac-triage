---
name: Engineering Change Order (ECO)
about: Propose a change to a board revision that has been released or ordered
title: "ECO: <board> - <short description>"
labels: eco
---

## Board and revision affected
- Board: <e.g. triage-main>
- Released revision(s) affected: <e.g. triage-main-revA>

## Problem (what is wrong, and how we know)
<!-- Evidence: bring-up notes, measurements, photos, datasheet section. -->

## Proposed change
<!-- Exactly what changes: parts, values, nets, footprints, layout areas. -->

## Items affected (tick all that apply)
- [ ] Schematic sheet(s): ____
- [ ] PCB layout
- [ ] BOM lines: ____
- [ ] Team library part(s): ____
- [ ] Enclosure / mechanical interface (mech/)
- [ ] Firmware (pins, addresses, timing)
- [ ] Test procedure or documentation
- [ ] DFMEA (docs/dfmea/)

## Impact
- Cost / lead time: ____ (check against the $1500 cap)
- Can existing boards be reworked? yes / no. How: ____

## What happens to boards already built (disposition)
- [ ] Use as is
- [ ] Rework (describe the bodge; mark reworked boards, e.g. "A*")
- [ ] Scrap

## New revision
- [ ] Next revision letter: ____ (BOARD_REV is bumped in the PR)
- [ ] Or: fold into a revision already in progress

## Verification
<!-- How we will prove the fix works on the new boards. -->

## Approval
- [ ] Board owner: @____
- [ ] Reviewer: @____
