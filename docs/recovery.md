# Common mistakes and how to recover

Almost everything in Git can be undone **if you stop and ask before typing more commands**. The two things that can't: an order already in production, and a force-push that overwrote other people's work.

| Mistake | First thing to do | Prevention |
|---|---|---|
| Committed a huge file | Remove it (A) | `.gitignore`, LFS rules, `git status` before committing |
| Broke a library path | Find the absolute path, restore the table (B) | `${KIPRJMOD}` paths only; library PRs reviewed |
| Fabbed the wrong revision | Identify exactly what was uploaded (C) | Order only from the Release; second person checks |
| Ordered with wrong fab rules | Read the fab's DFM feedback; ECO (D) | Rules re-checked and recorded before every order |
| Committed to `main` locally | Move the commits to a branch (E) | Branch protection; `git switch -c` first |
| Pushed something bad to `main` | Revert, never rewrite (F) | Branch protection, required review |
| Someone saved with a newer KiCad | Revert their commit; plan an upgrade (G) | Same major version for everyone |
| Tag pushed, CI release failed | Delete the tag if nothing was ordered, fix, re-tag (H) | Release-candidate tags first |
| "My changes disappeared" | `git reflog` (I) | Commit small, push daily |

## A. Committed a huge file

Not pushed yet:

```bash
git reset --soft HEAD~1                 # undo the last commit, keep changes staged
git restore --staged path/to/huge.step  # unstage the big file
# add a .gitignore or 'git lfs track' rule, then commit again
```

Already pushed: `git rm --cached path/to/huge.step` and commit. It stays in history (GitHub rejects >100 MiB, warns from 50 MiB). To purge history, a lead does this once, then everyone re-clones:

```bash
git lfs migrate import --include="*.step,*.stp" --everything   # move STEPs into LFS
# or: git filter-repo --path mech/huge.step --invert-paths     # delete one file from history
git push --force --all && git push --force --tags              # temporarily lift branch protection
```

## B. Broke a library path

Symptoms: missing symbols/footprints, "library not found", parts without 3D bodies on a teammate's machine.

```bash
grep -n "uri" hardware/*/sym-lib-table hardware/*/fp-lib-table           # good lines contain ${KIPRJMOD}
grep -n "(model " hardware/<board>/<board>.kicad_pcb | grep -v '\${'      # 3D paths without a variable
git restore --source=main -- hardware/<board>/sym-lib-table hardware/<board>/fp-lib-table
```

## C. Fabbed the wrong revision

1. **Stop.** Tell the board owner before anyone solders or tests.
2. Download what was actually uploaded from the fab's order page and fingerprint it:
   ```bash
   shasum -a 256 <file>.zip    # Linux: sha256sum
   gh release download <board>-revA -p SHA256SUMS -O revA.sums
   grep -i "<hash>" revA.sums || echo "not the Rev A package"
   ```
3. Compare against each Release's `SHA256SUMS` until you find the match.
4. Open an ECO for the boards received (use as is / rework / scrap). Record it in the order record.

## D. Ordered with the wrong fab rules

Read the fab's DFM email carefully and answer it. If boards were made anyway, inspect thin tracks, small drills and tight clearances under magnification before assembly. Fix Board Setup, record corrected values in `fab/rules/README.md`, release a new revision through an ECO.

## E. Committed on `main` by accident (not pushed)

```bash
git switch -c sch/<board>-my-change   # new branch keeps your commits
git switch main
git reset --hard origin/main          # main back to the server's version
```

## F. Something bad reached `main` on the server

```bash
git switch main && git pull
git revert <commit-sha>   # new commit that undoes it
git push                  # through a PR, since main is protected
```

**Never `git push --force` to `main`.**

## G. Someone saved with a newer KiCad major version

Revert that commit (F) and agree an upgrade day. One person upgrades every file in one PR and everyone installs together:

```bash
kicad-cli sch upgrade hardware/<board>/<board>.kicad_sch   # each sheet
kicad-cli pcb upgrade hardware/<board>/<board>.kicad_pcb
```

Update the CI image tag (`kicad/kicad:10.0`) in the same PR.

## H. Tag pushed, CI release failed

If no order references the tag:

```bash
git push origin --delete <board>-revA-rc1
git tag -d <board>-revA-rc1
```

The tag ruleset blocks this for non-admins; the repo owner deletes it. **Never delete a tag an order record points to.**

## I. "My changes disappeared"

```bash
git reflog                  # every place your branch has been
git switch -c rescue <sha>  # branch at the commit that still has your work
```

Never committed? Look in the project's `-backups/` folder for KiCad's zip backups.
