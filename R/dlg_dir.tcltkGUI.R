#' A Tcl/Tk version of the {svDialogs} directory selection dialog box
#'
#' Select an existing directory, or create a new one.
#'
#' @param default The path to the default directory that is proposed (e.g.,
#' current working directory).
#' @param title A title to display on top of the dialog box.
#' @param ... Not used yet.
#' @param gui The 'gui' object concerned by this dialog box.
#'
#' @return The path to the selected folder.
#' @export
#' @rdname dlg_dir
#' @method dlg_dir tcltkGUI
#' @seealso [svDialogs::dlg_dir()]
#' @keywords misc
#' @concept Modal dialog box
#' @examples
#' library(svDialogstcltk) # Tcl/Tk dialog boxes are now used by default
#' \dontrun{
#' # A quick default directory changer
#' setwd(dlg_dir(default = getwd())$res)
#' }
dlg_dir.tcltkGUI <- function(default = getwd(), title = "Choose a directory",
..., gui = .GUI) {
  gui$setUI(args = list(default = default, title = title), widgets = "tcltkGUI")
  # TODO: we don't display multiline title here! => what to do?
  res <- tclvalue(tkchooseDirectory(initialdir = gui$args$default,
    mustexist = FALSE, title = gui$args$title))
  # tkchooseDirectory returns "" if cancelled
  if (res == "")
    res <- character(0)
  gui$setUI(res = res, status = NULL)
  return(invisible(gui))
}
