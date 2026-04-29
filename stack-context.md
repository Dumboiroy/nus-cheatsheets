# Stack context — TeX edit / format / preview

OS: macOS

TeX distribution: MacTeX / TeX Live (installed via Homebrew cask; this machine: mactex 2025)

TeX engine: `xelatex` (XeTeX via TeX Live) — used for compilation.

Build automation: `latexmk` (called by LaTeX Workshop or via `./compile.sh`).

Syntax highlighting: `minted` → requires Python 3 + Pygments (`pygmentize`).

Formatter: `latexindent` (Perl script installed with TeX Live) + required Perl modules installed via `cpanm`:

- Installed modules: `File::HomeDir`, `YAML::Tiny`, `Log::Dispatch`, `File::Spec`, `Unicode::GCString` (installed via `brew install cpanminus` + `sudo cpanm ...`).

Editor & extension: VS Code + LaTeX Workshop (`James-Yu.latex-workshop`) for build, preview, and format-on-save.

VS Code formatter settings used:

```jsonc
"[latex]": {
  "editor.defaultFormatter": "James-Yu.latex-workshop",
  "editor.formatOnSave": true 
},
"latex-workshop.formatting.latex": "latexindent",
"latex-workshop.latexindent.path": "/Library/TeX/texbin/latexindent"
```

Auto-compile on save: LaTeX Workshop watches saves and runs `latexmk` (recipe → `xelatex -shell-escape` or `latexmk -pdf -outdir=... -auxdir=...`). `minted` requires `-shell-escape` so Pygments runs.

Viewer: LaTeX Workshop previews PDF and attempts to auto-refresh the viewer on successful builds.

Verification commands (agent should run these):

```
which xelatex
xelatex --version
which tlmgr
tlmgr --version
which latexindent
latexindent -v
which pygmentize
pygmentize -V
./check-setup.sh
```

If `latexindent` fails: typical error is missing Perl modules (e.g. `Can't locate File/HomeDir.pm`). Fix by:

```
brew install cpanminus
sudo cpanm File::HomeDir YAML::Tiny Log::Dispatch File::Spec Unicode::GCString

/Library/TeX/texbin/latexindent -v
/Library/TeX/texbin/latexindent -w path/to/file.tex
```

Where to look for logs: VS Code → View → Output (Cmd+Shift+U) → select **LaTeX Workshop**. This shows formatter command, `latexmk` output, and any missing-module errors.

Repository docs: see `auto-format.md` (instructions added) and run `./check-setup.sh` to confirm compile/tooling readiness.

Use this file as the agent bootstrap: run the verification commands, confirm `latexindent` and `pygmentize` succeed, ensure VS Code settings above are present, then enable format-on-save and build-on-save in LaTeX Workshop.
