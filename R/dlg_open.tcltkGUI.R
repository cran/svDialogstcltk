#' A Tcl/Tk version of the {svDialogs} file open dialog box
#'
#' @param default The default file to start with (use `/dir/*` or `/dir/*.*` to
#' start in a given directory).
#' @param title A title to display on top of the dialog box.
#' @param multiple Is a multiple selection of files allowed?
#' @param filters A specification of file filters as a `nx2` matrix, or a
#' character string with even number of items. First items is the label, second
#' one is the filter. See `dlg_filters` for examples. This is currently ignored
#' on MacOS and RStudio, since such kind of filter is defined differently there.
#' @param ... Not used yet.
#' @param gui The 'gui' object concerned by this dialog box.
#'
#' @return The path to the file to open.
#' @export
#' @rdname dlg_open
#' @method dlg_open tcltkGUI
#' @seealso [svDialogs::dlg_open()]
#' @keywords misc
#' @concept Modal dialog box
#' @examples
#' library(svDialogstcltk) # Tcl/Tk dialog boxes are now used by default
#' \dontrun{
#' # Choose one R file
#' dlg_open(title = "Select one R file", filters = dlg_filters[c("R", "All"), ])$res
#' # Choose several files
#' dlg_open(multiple = TRUE)$res
#' }
dlg_open.tcltkGUI <- function(default = "", title = if (multiple) "Select files"
else "Select file", multiple = FALSE, filters = dlg_filters["All", ], ...,
gui = .GUI) {
  gui$setUI(args = list(default = default, title = title,
    multiple = multiple, filters = filters), widgets = "tcltkGUI")
  # In tkgetOpenFile, filters are presented differently!
  filters <- gui$args$filters
  # If filters is not a matrix, transform it now
  if (is.null(dim(filters)))
    filters <- matrix(filters, ncol = 2, byrow = TRUE)
  filters <- paste("{\"", filters[, 1], "\" {\"", gsub(";", "\" \"",
    filters[, 2]), "\"}}", sep = "", collapse = " ")
  # Use tkgetOpenFile()
  res <- as.character(tkgetOpenFile(title = gui$args$title,
    initialfile = basename(gui$args$default),
    initialdir = dirname(gui$args$default), multiple = gui$args$multiple,
    filetypes = filters))
  if (length(res) == 1 && res == "")
    res <- character(0)
  gui$setUI(res = res, status = NULL)
  return(invisible(gui))
}
