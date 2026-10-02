# Your first pull request

Every new member's first PR adds their name to the **Team** table in the root `README.md`. It's a harmless change that walks you through the exact loop we use for every schematic, layout and firmware change.

Steps 1–4 are one-time setup. Steps 5–8 are the loop.

## 1. Accept the invite

Ask Ali to add your GitHub username as a collaborator. Accept from the email, or at
**github.com/asamara24/tnbc-2027-cardiac-triage/invitations**.

## 2. Install Git and the GitHub CLI

| OS | Install |
|---|---|
| **Windows** | Git for Windows from git-scm.com (keep the defaults), then GitHub CLI from cli.github.com. Run everything below in **Git Bash**. |
| **macOS** | `brew install git git-lfs gh` |
| **Linux** | `sudo apt install git git-lfs gh` |

The GitHub CLI (`gh`) is the easiest way to sign in, since GitHub no longer accepts passwords for `git push`. It also opens PRs from the terminal.

## 3. One-time setup

```bash
git config --global user.name "Adhavaa"
git config --global user.email "adhavaa@example.com"   # same email as your GitHub account
git config --global init.defaultBranch main
git lfs install

gh auth login
# choose: GitHub.com → HTTPS → Yes (authenticate Git) → Login with a web browser
# it shows a code, opens github.com, you paste the code and approve
```

## 4. Clone the repo

```bash
cd ~/Documents          # or wherever you keep projects
git clone https://github.com/asamara24/tnbc-2027-cardiac-triage.git
cd tnbc-2027-cardiac-triage
```

## 5. Make the change on a branch

```bash
git switch -c docs/add-adhavaa
```

Open `README.md` in any editor and add your row under **Team**:

```markdown
| Adhavaa | <your role> | @Adhavaa |
```

Save, then check what changed:

```bash
git status            # shows README.md modified
git diff              # shows the added line
```

## 6. Commit, push and open the PR

```bash
git add README.md
git commit -m "docs: add Adhavaa to team table"
git push -u origin docs/add-adhavaa
gh pr create --fill --web
```

`gh pr create --web` opens the PR page in your browser with the checklist template pre-filled. For a README change, write "N/A — docs only" in the checks section, then click **Create pull request**.

## 7. Review and merge (someone else)

- The `erc-drc` check runs automatically and passes in about a minute.
- A reviewer who **isn't the author** opens the PR → **Files changed** → **Review changes** → **Approve**. From the terminal: `gh pr review <number> --approve`.
- Then **Merge pull request**, or `gh pr merge <number> --merge`. The branch deletes itself on GitHub.

Tip: review the *next* new member's PR, so everyone has both opened and reviewed one.

## 8. Clean up locally (author)

```bash
git switch main
git pull
git branch -d docs/add-adhavaa
```

That's the whole loop. For real work only the branch prefix changes: `sch/`, `layout/`, `lib/`, `fw/`, `mech/`, `fix/`, `eco/` (see [`workflow.md`](workflow.md)).
