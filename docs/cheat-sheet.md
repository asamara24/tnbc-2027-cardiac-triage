# Cheat sheet

Print this and pin it next to the lab computer.

## The rules

1. Same KiCad major version (10.x) for everyone.
2. Never push to `main`; everything goes through a PR with a reviewer who isn't the author.
3. Claim a schematic sheet or the PCB (draft PR) before editing. One editor per file.
4. ERC and DRC clean before review.
5. New parts go through a library PR, with MPN, Manufacturer, LCSC, datasheet link and cost.
6. Order only from a tagged GitHub Release; write the order record; a second person checks it.
7. After an order, every change needs an ECO; the next PR bumps `BOARD_REV`.
8. Push your work at least once a day.

## Daily commands

```bash
git switch main && git pull                          # start fresh
git switch -c sch/triage-main-add-led                # new branch for one change
git status                                           # what changed?
git diff --stat                                      # which files, how much
git add <files> && git commit -m "feat(triage-main): add status LED D2"
git push -u origin sch/triage-main-add-led           # then open a PR
bash scripts/check-boards.sh                         # ERC + DRC like CI
git fetch origin && git merge origin/main            # bring your branch up to date
git switch main && git pull && git branch -d sch/triage-main-add-led   # after merge
```

## Release commands

```bash
bash scripts/build-release.sh triage-main-revA       # preview the package locally
git tag -a triage-main-revA-rc1 -m "Rev A candidate 1" && git push origin triage-main-revA-rc1
git tag -a triage-main-revA -m "Rev A" && git push origin triage-main-revA
shasum -a 256 -c SHA256SUMS                          # check downloads (Linux: sha256sum -c)
```

## Names

| Thing | Pattern | Example |
|---|---|---|
| Branch | `<type>/<board>-<what>` (sch, layout, lib, fix, eco, fw, mech, docs, chore) | `layout/triage-main-route-power` |
| Commit | `<type>(<scope>): <what>` + why in body | `fix(triage-main): swap SDA/SCL on J1` |
| Tag | `<board>-rev<letter>`, candidates add `-rc<n>` | `triage-main-revB`, `triage-main-revB-rc1` |
| ECO | issue number | ECO-23 = issue #23 |
| Release files | start with the tag | `triage-main-revA-gerbers.zip` |

## Where things live

| What | Where |
|---|---|
| KiCad projects | `hardware/<board>/` |
| Team symbols, footprints, 3D | `lib/` (paths use `${KIPRJMOD}/../../lib/...`) |
| Approved parts + budget | `lib/PARTS.csv` |
| Fab rules, order records | `fab/rules/`, `fab/orders/` |
| Enclosure interface | `mech/INTERFACE.md` |
| What changed per revision | `CHANGELOG.md` |
| Ordered files | GitHub Releases, one per tag |
| Report, DFMEA, pitch | `docs/report/`, `docs/dfmea/`, `docs/pitch/` |

## When something goes wrong

| Problem | See |
|---|---|
| Merge conflict in `.kicad_pcb` / `.kicad_sch` | `docs/workflow.md` |
| Missing libraries or 3D models | `docs/recovery.md` B |
| Huge file committed | `docs/recovery.md` A |
| Wrong revision ordered | `docs/recovery.md` C |
| Anything else | **Stop, don't force-push, ask the board owner** |
