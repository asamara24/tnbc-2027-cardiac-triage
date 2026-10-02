# Onboarding

Give this to every new member. **Target: first merged PR on day one.**

## 1. Install the tools (everyone)

**KiCad 10.x** from kicad.org → Download. Everyone on the **same major version**: files saved by a newer major version can't be opened by an older one. Ideally the same bug-fix version too (KiCad 10.0.2 had a Git-integration bug fixed in 10.0.3). Accept the default global library tables on first launch.

```bash
kicad-cli version
# macOS: /Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli version
```

**Git + Git LFS**

| OS | Install |
|---|---|
| Windows | Git for Windows (git-scm.com), defaults. Includes Git Bash, Credential Manager and LFS. Run every command in **Git Bash**. |
| macOS | `brew install git git-lfs` |
| Linux | `sudo apt install git git-lfs` |

```bash
git lfs install
git config --global user.name "Your Name"
git config --global user.email "you@example.com"   # the email on your GitHub account
git config --global init.defaultBranch main
```

**Sign in to GitHub:** Windows opens a browser sign-in on first push. macOS/Linux use an SSH key:

```bash
ssh-keygen -t ed25519 -C "you@example.com"
cat ~/.ssh/id_ed25519.pub
# paste into GitHub: Settings → SSH and GPG keys → New SSH key
```

GitHub Desktop and KiCad's own Version Control menu are fine once the basics work.

## 2. Day-one checklist

1. Accept the collaborator invite to `asamara24/tnbc-2027-cardiac-triage` and **turn on two-factor authentication**.
2. Install KiCad 10.x, Git and Git LFS; run `git lfs install`.
3. Set `user.name` / `user.email`; set up SSH or Credential Manager.
4. Clone: `git clone git@github.com:asamara24/tnbc-2027-cardiac-triage.git`
5. Open each `hardware/<board>/<board>.kicad_pro`. Confirm no missing-library warnings, the `team` libraries appear in the choosers, and the 3D viewer shows every part.
6. Run the checks locally: `bash scripts/check-boards.sh` (macOS/Windows: set `KICAD_CLI` first).
7. Read the root README, `docs/workflow.md` and `docs/review.md`.
8. First PR on a harmless file: add your name and role to the team table in `README.md` on branch `docs/add-<yourname>`. Get it reviewed and merged. Step-by-step commands: [`first-pr.md`](first-pr.md).
9. Find out who owns which board (each `hardware/<board>/README.md`) and how files are claimed.
10. Do the practice exercise (`docs/practice-exercise.md`) or pair with a buddy on your first real change.

## Access and backups

| Role | GitHub | Who |
|---|---|---|
| Owner | Repo owner (asamara24) + 1 backup admin | 2 leads |
| Maintainer | Maintain | Board owners, library owners |
| Designer | Write | Everyone doing schematic, layout, firmware |
| Viewer | Read (public repo: anyone) | Advisors, mentors |

- **Two owners, never one**, so nobody is locked out.
- **No secrets in the repo**: no passwords, API keys or tokens. CI gets them from GitHub's encrypted secrets.
- **Fab accounts:** order from a team account on a team email, password in a shared password manager.
- **Offboarding:** remove the person from the repo, revoke any tokens/deploy keys they set up, change the fab account password.
- **Push daily.** Keep KiCad's own project backups on (zip files in `<project>-backups/`, ignored by Git).
- **Release zips** also go to the shared drive next to the order record.
- **Weekly mirror** (a lead runs it):
  ```bash
  git clone --mirror git@github.com:asamara24/tnbc-2027-cardiac-triage.git tnbc-mirror.git   # first time
  cd tnbc-mirror.git && git remote update --prune                                              # every week
  ```
  Copy the mirror folder to a drive the team controls. `git clone tnbc-mirror.git` restores a normal repo.
