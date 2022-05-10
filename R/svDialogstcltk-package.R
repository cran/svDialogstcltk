#' @details
#' Implementation of Tcl/Tk dialog boxes for {svDialogs}. When the package is
#' loaded, it inserts a new `tcltkGUI` dependency in the `.GUI` object (if it is
#' not defined yet). That way, every call to `.GUI` dispatches first to the
#' current Tcl/Tk implementation of the dialog boxes. For your own, separate GUI
#' (say called `myGUI`), you have to create the binding by yourself by calling
#' `svGUI::gui_widgets(myGUI) <- "tcltkGUI"`.
#'
#' @section Important functions:
#'
#'- [dlg_message()] display a message box,
#'- [dlg_input()] prompt for textual input,
#'- [dlg_list()] select one or more items in a list,
#'- [dlg_open()] open one or more existing file(s),
#'- [dlg_save()] prompt for a file to save to (and ask confirmation if the file
#'already exists),
#'- [dlg_dir()] select a directory,
#'
#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
#' @import tcltk
#' @import svDialogs
#' @import svGUI
#' @importFrom utils alarm
NULL
