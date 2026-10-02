# Scripts

| Script | What it does | When |
|---|---|---|
| `check-boards.sh` | ERC + DRC (with schematic parity) on every board under `hardware/` | Every PR and push to `main` (CI), or by hand before review |
| `build-release.sh <board>-rev<X>` | Revision check, ERC/DRC, every fab and assembly output, checksums, zips, release notes into `out/` | Every `*-rev*` tag (CI), or by hand to preview |

On macOS or Windows, point `KICAD_CLI` at KiCad's CLI first:

```bash
export KICAD_CLI=/Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli          # macOS
export KICAD_CLI="/c/Program Files/KiCad/10.0/bin/kicad-cli.exe"                 # Windows Git Bash
```

The scripts pass ShellCheck. They were written against the KiCad 10.0 CLI reference but haven't yet run against a real board; the practice exercise (`docs/practice-exercise.md`) is that first run.
