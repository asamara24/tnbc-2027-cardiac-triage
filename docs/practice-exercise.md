# Practice exercise: `practice-led`

The whole team takes a three-part board through every step of the workflow in about 2–3 hours, **before any real board depends on it**. This is also the first real run of the CI scripts with real KiCad.

**The board:** J1, 2-pin header (pin 1 = 5 V in, pin 2 = GND); R1, 1 kΩ 0603; D1, red LED 0603. About 3 mA through the LED at 5 V. Outline 20 × 15 mm, two layers.

**Roles:** Lead (L), Schematic designer (S), Layout designer (P). The reviewer is never the author. Bigger teams rotate roles or run pairs on `practice-led-<name>` copies.

## Part 0. Skeleton (L, 20 min)

```bash
git switch main && git pull
git switch -c chore/practice-led-skeleton
mkdir -p hardware/practice-led
cp docs/templates/sym-lib-table docs/templates/fp-lib-table hardware/practice-led/
cp docs/templates/FAB-NOTES.md hardware/practice-led/
```

1. KiCad: File → New Project, save as `hardware/practice-led/practice-led.kicad_pro`.
2. Schematic Setup → Project → Text Variables: `BOARD_REV = A`.
3. Write a one-line `hardware/practice-led/README.md` (owner, "practice only").
4. Commit, push, PR, S approves, merge.

```bash
git add hardware/practice-led
git commit -m "chore(practice-led): project skeleton, BOARD_REV=A, fab notes"
git push -u origin chore/practice-led-skeleton
```

## Part 1. Schematic (S draws, P reviews, 30 min)

```bash
git switch main && git pull
git switch -c sch/practice-led-circuit
```

1. Claim it: open a draft PR `[SCH] practice-led: LED circuit`.
2. Place `Connector_Generic:Conn_01x02` (J1), `Device:R` (R1, `1k`), `Device:LED` (D1, `RED`). Wire J1.1 → R1 → D1 anode, D1 cathode → J1.2. Label nets `VIN` and `GND`.
3. Footprints: `Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical`, `Resistor_SMD:R_0603_1608Metric`, `LED_SMD:LED_0603_1608Metric`.
4. Fill `MPN`, `Manufacturer`, `LCSC`, or write `practice`.
5. ERC until clean (power symbols need a `PWR_FLAG`).
6. `bash scripts/check-boards.sh`, commit, push, mark Ready for review, fill the template.
7. P reviews with the schematic checklist, leaves at least one comment, approves. S merges.

## Part 2. Layout (P lays out, S reviews, 45 min)

```bash
git switch main && git pull
git switch -c layout/practice-led-route
```

1. Claim with draft PR `[PCB] practice-led: layout`.
2. Tools → Update PCB from Schematic.
3. Draw a 20 × 15 mm rectangle on Edge.Cuts; set the drill/place origin at its bottom-left corner.
4. Place and route. Add silkscreen `practice-led Rev ${BOARD_REV}` and check it shows "Rev A".
5. DRC with the team's fab rules until clean. Commit, push, ready for review.
6. S reviews with the layout checklist including the 3D viewer. P merges.

## Part 3. Release (L, 30 min)

1. On a branch, add `## [practice-led-revA] - <today>` with "First practice release" to `CHANGELOG.md`. Merge through a PR.
2. Release candidate:
   ```bash
   git switch main && git pull
   git tag -a practice-led-revA-rc1 -m "practice-led Rev A, candidate 1"
   git push origin practice-led-revA-rc1
   ```
3. Watch the **Actions** tab. When the pre-release appears, download it and check: the Gerber zip opens in KiCad's Gerber Viewer; the JLCPCB BOM lists R1 and D1; the placement file is in mm with sensible coordinates; `sha256sum -c SHA256SUMS` passes.
4. Final tag on the same commit:
   ```bash
   git tag -a practice-led-revA -m "practice-led Rev A"
   git push origin practice-led-revA
   ```
5. Write `fab/orders/<today>-practice-led-revA-PRACTICE.md` from the template, marked "not ordered".

## Part 4. ECO drill (everyone, 30 min)

1. Open an ECO issue: "practice-led: LED too bright, R1 1k → 2.2k". Note its number (say #31).
2. S branches `eco/practice-led-31-r1-2k2`, changes R1, bumps `BOARD_REV` to `B`, adds an `[Unreleased]` CHANGELOG line mentioning ECO-31.
3. PR says `Fixes #31`. P reviews and merges; the issue closes itself.
4. L moves the line into `## [practice-led-revB] - <today>`, tags `practice-led-revB`, checks the new Release.
5. Everyone compares:
   ```bash
   git fetch --tags
   git diff --stat practice-led-revA practice-led-revB
   git diff --word-diff practice-led-revA practice-led-revB -- hardware/practice-led/practice-led.kicad_sch
   ```

## Part 5. Conflict drill (pairs, 15 min)

1. Two people branch from the same `main`: `layout/practice-led-move-d1-alice` and `layout/practice-led-move-d1-bob`.
2. Both move D1 to different places, save, commit, push.
3. Alice merges first. Bob runs `git fetch origin && git merge origin/main`, gets the conflict, resolves it per `docs/workflow.md` (keep one whole board, redo the other change, run DRC).
4. Discuss: which rule would have stopped this?

## Done when

- [ ] Two Releases exist, `practice-led-revA` and `practice-led-revB`, each with zips and `SHA256SUMS`
- [ ] Every PR had a reviewer who was not the author
- [ ] ECO issue closed by its PR; CHANGELOG has both sections
- [ ] Everyone has opened a PR, reviewed a PR and resolved (or watched) a conflict
- [ ] Anything that didn't work as written is a new issue labelled `guide`
