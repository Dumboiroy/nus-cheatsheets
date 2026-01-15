# Fixing Blank Columns/Pages in LaTeX `multicols*` Cheatsheets

## Problem

- When using `multicols*` with custom column/page output code (e.g. redefining `\multi@column@out`), columns/pages may appear blank or only one column is filled.

## Solution Steps

1. **Remove Custom Output Redefinition**

   - Comment out or delete any custom `\def\multi@column@out{...}` code in your preamble.
   - This restores the default column/page balancing behavior.

2. **Remove Column-Specific Header Injection**

   - If you have code that tries to inject a header into only one column (e.g. with `\ifnum\count@=\@ne ...`), remove it.

3. **Place Header Before `multicols*`**

   - Instead of injecting headers per column, simply place your header command (e.g. `\header`) before the `\begin{multicols*}{...}` environment in your document body.

   Example:

   ```tex
   \begin{document}
   \header
   \begin{multicols*}{4}
   % ... your content ...
   \end{multicols*}
   \end{document}
   ```

4. **(Optional) Remove `\raggedcolumns`**
   - If present, comment out or remove `\raggedcolumns` for more balanced columns.

## Result

- Columns and pages will be filled and balanced automatically.
- The header will appear at the top of the first page (or wherever you place it).

## Next Time Checklist

- **Do NOT redefine `\multi@column@out` unless you know exactly what you're doing.**
- **Place headers before the `multicols*` environment.**
- **Let the default `multicols*` logic handle column balancing.**

## Reference

- [multicol package documentation](https://ctan.org/pkg/multicol)
