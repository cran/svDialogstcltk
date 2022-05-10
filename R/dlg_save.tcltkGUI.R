#' A Tcl/Tk version of the {svDialogs} file save dialog box
#'
#' @param default The default file to start with (use `/dir/*` or `/dir/*.*` to
#' start in a given directory, but without predefined name).
#' @param title A title to display on top of the dialog box.
#' @param filters A specification of file filters as a `nx2` matrix, or a
#' character string with even number of items. First items is the label, second
#' one is the filter. See `dlg_filters` for examples. This is currently ignored
#' on MacOS, since such kind of filter is defined differently there.
#' @param ... Not used yet.
#' @param gui The 'gui' object concerned by this dialog box.
#'
#' @return The path to the file to save to.
#' @export
#' @rdname dlg_save
#' @method dlg_save tcltkGUI
#' @seealso [svDialogs::dlg_save()]
#' @keywords misc
#' @concept Modal dialog box
#' @examples
#' library(svDialogstcltk) # Tcl/Tk dialog boxes are now used by default
#' \dontrun{
#' # Choose one R filename to save some R script into it
#' dlg_save(title = "Save R script to", filters = dlg_filters[c("R", "All"), ])$res
#' }
dlg_save.tcltkGUI <- function(default = "untitled", title = "Save file as",
filters = dlg_filters["All", ], ..., gui = .GUI) {
  gui$setUI(args = list(default = default, title = title, filters = filters),
    widgets = "tcltkGUI")
  # In tkgetSaveFile, filters are presented differently!
  filters <- gui$args$filters
  # If filters is not a matrix, transform it now
  if (is.null(dim(filters)))
    filters <- matrix(filters, ncol = 2, byrow = TRUE)
  filters <- paste("{\"", filters[, 1], "\" {\"", gsub(";", "\" \"",
    filters[, 2]), "\"}}", sep = "", collapse = " ")
  # Use tkgetSaveFile()
  default <- gui$args$default
  if (!length(default) || default == "")
    default <- file.path(getwd(), "*.*")
  res <- as.character(tkgetSaveFile(title = gui$args$title,
    initialfile = basename(default),
    initialdir = dirname(default), # defaultextension = Not used!
    filetypes = filters))
  if (!length(res) || res == "")
    res <- character(0)
  # Note: confirmation is built-in!
  gui$setUI(res = res, status = NULL)
  return(invisible(gui))
}
