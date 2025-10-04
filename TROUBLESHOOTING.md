# Common Compilation Issues and Solutions

This document addresses specific error messages you might encounter when compiling the cheatsheets.

## Table of Contents
- [Installation Issues](#installation-issues)
- [Compilation Errors](#compilation-errors)
- [Package Errors](#package-errors)
- [Font Errors](#font-errors)
- [Minted/Pygments Errors](#mintedpygments-errors)

---

## Installation Issues

### "xelatex: command not found"

**Cause:** XeLaTeX is not installed or not in your PATH.

**Solution:**

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install texlive-xetex
```

**macOS:**
```bash
brew install --cask mactex
# Or for a smaller installation:
brew install --cask basictex
sudo tlmgr update --self
sudo tlmgr install xetex
```

**Windows:**
- Download and install MiKTeX from https://miktex.org/download
- Or download TeX Live from https://www.tug.org/texlive/

### "pygmentize: command not found"

**Cause:** Pygments is not installed.

**Solution:**
```bash
# Python 3
pip3 install Pygments

# Or with Python 2 (not recommended)
pip install Pygments

# On Ubuntu/Debian
sudo apt-get install python3-pygments
```

Verify installation:
```bash
pygmentize -V
```

---

## Compilation Errors

### "Package minted Error: You must invoke LaTeX with the -shell-escape flag"

**Cause:** The minted package requires shell-escape to run Pygments.

**Solution:**

Always compile with `-shell-escape`:
```bash
xelatex -shell-escape filename.tex
```

For editors:
- **TeXShop:** Add `% !TEX parameter = -shell-escape` at the top of the file
- **TeXworks:** Preferences → Typesetting → Add `-shell-escape` to the arguments
- **VS Code:** Update your `latex-workshop.latex.tools` in settings.json (see BUILD.md)

### "minted Error: Missing Pygments output"

**Causes and Solutions:**

1. **Pygments not installed:**
   ```bash
   pip install Pygments
   ```

2. **Python not in PATH:**
   - Windows: Reinstall Python and check "Add Python to PATH" during installation
   - macOS/Linux: Add Python to your PATH in `.bashrc` or `.zshrc`

3. **Shell-escape not enabled:**
   ```bash
   xelatex -shell-escape filename.tex
   ```

4. **Pygmentize in wrong location (Windows):**
   - Find where pygmentize is installed: `where pygmentize`
   - Ensure that directory is in your PATH

### "I can't write on file `filename.pdf'"

**Cause:** The PDF file is open in another program (PDF viewer).

**Solution:**
- Close the PDF file in your viewer
- Use a PDF viewer that auto-reloads (like SumatraPDF on Windows, Skim on macOS)

### Compilation is extremely slow (>2 minutes)

**Causes and Solutions:**

1. **Complex TikZ graphics:**
   - First compilation is always slower
   - Consider using draft mode: `xelatex -draftmode filename.tex`

2. **Minted syntax highlighting:**
   - Disable minted temporarily by commenting out `\usepackage{minted}`
   - Replace `\begin{minted}...\end{minted}` with `\begin{verbatim}...\end{verbatim}`

3. **Multiple columns with many formulas:**
   - This is expected for cheatsheets with dense content
   - Use a faster computer or be patient

---

## Package Errors

### "LaTeX Error: File `package.sty' not found"

**Cause:** A required LaTeX package is not installed.

**Solutions by Platform:**

**Ubuntu/Debian:**
```bash
# Install all packages (recommended):
sudo apt-get install texlive-full

# Or install specific package groups:
sudo apt-get install texlive-fonts-recommended texlive-fonts-extra
sudo apt-get install texlive-latex-extra texlive-science
```

**macOS with MacTeX:**
- Packages should be included. If not:
```bash
sudo tlmgr update --self
sudo tlmgr install <package-name>
```

**macOS with BasicTeX:**
```bash
sudo tlmgr install collection-fontsrecommended collection-latexextra
```

**Windows with MiKTeX:**
- MiKTeX should auto-prompt to install missing packages
- If not, open MiKTeX Console → Packages → Search for and install the missing package

### Common missing packages and their installation:

```bash
# For TeX Live (Linux/macOS):
sudo tlmgr install kpfonts sourcesanspro minted enumitem datetime
sudo tlmgr install mdframed microtype lastpage pgf tikz-cd
sudo tlmgr install mathtools makecell multirow xcolor fancyvrb
sudo tlmgr install framed etoolbox ifplatform xstring lineno
```

---

## Font Errors

### "Font kpfonts not found" or similar font errors

**Cause:** Font packages are not installed.

**Solution:**

**TeX Live (Linux):**
```bash
sudo apt-get install texlive-fonts-recommended texlive-fonts-extra
# Or specifically:
sudo tlmgr install kpfonts sourcesanspro
```

**TeX Live (macOS):**
```bash
sudo tlmgr install kpfonts sourcesanspro
```

**MiKTeX (Windows):**
- Let MiKTeX auto-install, or manually install via MiKTeX Console

### "! Package fontspec Error: The font 'Source Sans Pro' cannot be found"

**Cause:** The Source Sans Pro font is not installed system-wide.

**Solutions:**

1. **Use TeX package instead of system font:**
   - The cheatsheets already use `\usepackage[t1]{sourcesanspro}` which should work
   - This uses the LaTeX package, not the system font

2. **Update font cache:**
   ```bash
   # Linux:
   sudo fc-cache -fv
   
   # macOS:
   atsutil databases -remove
   ```

3. **Install as system font (optional):**
   - Download from Google Fonts: https://fonts.google.com/specimen/Source+Sans+Pro
   - Install like any system font

---

## Minted/Pygments Errors

### "Package minted Error: You must have `pygmentize' installed"

**Solution:**
```bash
pip install Pygments

# Verify it's working:
pygmentize -V
```

### "Pygments error: Could not find a lexer for the language"

**Cause:** The specified language in `\begin{minted}{language}` is not recognized.

**Common language names:**
- `javascript` not `js`
- `python` not `py`
- `java` not `Java`
- `haskell` for Haskell code
- `c` for C code
- `cpp` for C++ code

**Solution:** Check the language name in the .tex file and correct it.

List available lexers:
```bash
pygmentize -L lexers
```

### "_minted directory" permissions error

**Cause:** No write permission in the working directory.

**Solution:**
- Compile from a directory where you have write permissions
- Don't compile in system directories
- On Windows, don't compile in C:\Program Files\

### "Package minted Error: Missing Pygments output; \inputminted was probably given a file that does not exist"

**Cause:** Minted is trying to highlight a file that doesn't exist.

**Solution:**
- Check if the file referenced in `\inputminted{language}{filename}` exists
- Check the file path is correct
- For this repository, this shouldn't happen as code is inline, not from files

---

## Platform-Specific Issues

### Windows: "The system cannot find the path specified"

**Cause:** Python Scripts directory not in PATH.

**Solution:**
1. Find Python Scripts directory (usually `C:\Users\YourName\AppData\Local\Programs\Python\Python3x\Scripts\`)
2. Add it to PATH:
   - Right-click "This PC" → Properties → Advanced System Settings
   - Environment Variables → System Variables → Path → Edit
   - Add the Scripts directory

### macOS: "xcrun: error: invalid active developer path"

**Cause:** Command Line Tools not installed (needed for some build tools).

**Solution:**
```bash
xcode-select --install
```

### Linux: "! LaTeX Error: File `sourcesanspro.sty' not found"

**Cause:** Incomplete TeX Live installation.

**Solution:**
```bash
# Install everything (recommended):
sudo apt-get install texlive-full

# Or specific packages:
sudo apt-get install texlive-fonts-extra
```

---

## Still Having Issues?

If you're still experiencing problems:

1. **Check the .log file:** Look at `filename.log` for detailed error messages

2. **Try a minimal example:** Create a simple test file:
   ```tex
   % !TEX TS-program = xelatex
   \documentclass{article}
   \usepackage{minted}
   \begin{document}
   \begin{minted}{python}
   print("Hello")
   \end{minted}
   \end{document}
   ```
   Compile with: `xelatex -shell-escape test.tex`

3. **Try Overleaf:** Upload to Overleaf.com to see if it compiles there

4. **Check versions:**
   ```bash
   xelatex --version
   python --version
   pygmentize -V
   ```

5. **Report the issue:** If you're sure it's a problem with the cheatsheet itself, open an issue on GitHub with:
   - Your operating system and version
   - TeX distribution and version (`xelatex --version`)
   - Python version (`python --version`)
   - Pygments version (`pygmentize -V`)
   - The complete error message from the .log file
   - Which cheatsheet you're trying to compile

## Quick Diagnosis Script

Run this to check your setup:

```bash
#!/bin/bash
echo "=== System Check ==="
echo -n "xelatex: "
command -v xelatex >/dev/null && xelatex --version | head -1 || echo "NOT FOUND"
echo -n "python: "
command -v python3 >/dev/null && python3 --version || echo "NOT FOUND"
echo -n "pygmentize: "
command -v pygmentize >/dev/null && pygmentize -V || echo "NOT FOUND"
echo ""
echo "If all three are found, you should be able to compile the cheatsheets."
```

Save this as `check-setup.sh`, make it executable (`chmod +x check-setup.sh`), and run it (`./check-setup.sh`).
