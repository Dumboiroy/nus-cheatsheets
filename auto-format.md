## Auto-format for LaTeX in VS Code (macOS)

Problem
- You save `.tex` files in VS Code but they are not auto-formatted (Format on Save fails).
- LaTeX Workshop reports: "Formatting failed. Please refer to LaTeX Workshop Output for details." The output often shows two symptoms:
  - `Can't locate File/HomeDir.pm` (or other missing Perl modules).
  - An ENOENT error trying to remove `indent.log` (secondary cleanup error).

Why this happens
- VS Code's LaTeX Workshop uses `latexindent` to format `.tex` files. `latexindent` is a Perl script that depends on several Perl modules (YAML::Tiny, File::HomeDir, Log::Dispatch, File::Spec, Unicode::GCString, etc.).
- MacTeX / TeX Live installs `latexindent` itself but not necessarily the extra Perl modules or `cpanminus` (cpanm). If the modules are missing, `latexindent` aborts and the extension reports formatting failure.
- The ENOENT cleanup error is a follow-up from the extension trying to remove a file that `latexindent` didn't create because it failed.

How to check your system (run these commands in Terminal)

```bash
which xelatex
xelatex --version
which tlmgr
tlmgr --version
which latexindent
latexindent -v
echo $PATH | tr ':' '\n' | grep -x '/Library/TeX/texbin' || true
./check-setup.sh
```

Fix (macOS) — step-by-step

1) Ensure MacTeX/TeX Live is installed and `/Library/TeX/texbin` is in your PATH. If missing, install MacTeX:

```bash
# Homebrew (preferred):
brew install --cask mactex

# Or download installer: https://tug.org/mactex/
```

2) Install `cpanminus` (cpanm) and required Perl modules (preferred: Homebrew + cpanm):

```bash
brew install cpanminus       # installs cpanm
sudo cpanm File::HomeDir YAML::Tiny Log::Dispatch File::Spec Unicode::GCString
```

Alternative (if you prefer CPAN):

```bash
sudo cpan App::cpanminus
sudo cpanm File::HomeDir YAML::Tiny Log::Dispatch File::Spec Unicode::GCString
```

3) Verify `latexindent` works and can format a file safely:

```bash
/Library/TeX/texbin/latexindent -v
/Library/TeX/texbin/latexindent -w "path/to/your.tex"
```

4) Configure VS Code (User or Workspace `settings.json`)

Add or update these settings so LaTeX Workshop uses `latexindent` and formats on save:

```jsonc
{
  "editor.formatOnSave": true,
  "[latex]": {
    "editor.defaultFormatter": "James-Yu.latex-workshop",
    "editor.formatOnSave": true
  },
  "latex-workshop.formatting.latex": "latexindent",
  "latex-workshop.latexindent.path": "/Library/TeX/texbin/latexindent"
}
```

5) Reproduce and debug
- Save a `.tex` file. If formatting still fails, open the Output panel in VS Code (View → Output or Cmd+Shift+U) and select **LaTeX Workshop** from the dropdown. Copy the error lines (they show missing Perl modules or the exact latexindent command).
- If a module is still missing, install it with `cpanm` and re-try.

Notes
- `latexindent` changes source indentation/line breaks; it does not change typeset line spacing in the generated PDF.
- Documenting this dependency is important because installing MacTeX alone may not install optional Perl modules. Consider adding this file's contents to `BUILD.md` or `QUICKSTART.md` if you want repository-level installation instructions.

If you want, I can add the short snippet from this file to `BUILD.md` for you.
