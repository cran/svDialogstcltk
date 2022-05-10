# svDialogstcltk 1.0.0

-   All functions are renamed using snake_case. For instance, `dlgDir()` is now `dlg_dir()`.

-   Reimplementation of man pages using Roxygen with more details and examples.

-   NEWS file in Markdown format now.

-   GitHub actions and {pkgdown} site building.

-   README.md file added.

-   in `dlg_open()` and `dlg_save()` if `filters =` was not a matrix, but a vector, an error was generated. Now, it is silently transformed into a 2-cols matrix.

# svDialogstcltk 0.9-4

-   Removed {svDialogs} in Enhances field, because already in Depends.

-   Rework of Author and [Authors\@R](mailto:Authors@R){.email} fields in the DESCRIPTION file.

# svDialogstcltk 0.9-3

-   NEWS file reworked to support new Rd format.

# svDialogstcltk 0.9-2

-   An imports for {svGUI} was missing in the NAMESPACE file.

# svDialogstcltk 0.9-1

-   `xxxx.tcltkWidgets()` is now rewritten as `xxxx.tcltkGUI()` to match convention used in {svDialogs} (nativeGUI).

-   The message argument in `dlgDir.tcltkGUI()` is replaced by title to match change made in {svDialogs} 0.9-48.

-   There are new `dlgOpen.tcltkGUI()` and `dlgSave.tcltkGUI()` functions.

# svDialogstcltk 0.9-0

-   This is the first version on R-forge. It is a refactoring from the old {svDialogs} function that are replaced there by native dialog boxes, as much as possible.
