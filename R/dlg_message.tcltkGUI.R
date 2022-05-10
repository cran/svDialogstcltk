#' A Tcl/Tk version of the {svDialogs} message box
#'
#' @param message The message to display in the dialog box.
#' @param type The type of dialog box: `'ok'`, `'okcancel'`, `'yesno'` or
#' `'yesnocancel'`.
#' @param ... Not used yet.
#' @param gui The 'gui' object concerned by this dialog box.
#'
#' @return The button pressed by the user.
#' @export
#' @rdname dlg_message
#' @method dlg_message tcltkGUI
#' @seealso [svDialogs::dlg_message()]
#' @keywords misc
#' @concept Modal dialog box
#' @examples
#' library(svDialogstcltk) # Tcl/Tk dialog boxes are now used by default
#' \dontrun{
#' # A simple information box
#' dlg_message("Hello world!")$res
#'
#' # Ask to continue
#' dlg_message(c("This is a long task!", "Continue?"), "okcancel")$res
#'
#' # Ask a question
#' dlg_message("Do you like apples?", "yesno")$res
#'
#' # Idem, but one can interrupt too
#' res <- dlg_message("Do you like oranges?", "yesnocancel")$res
#' if (res == "cancel")
#'   cat("Ah, ah! You refuse to answer!\n")
#' }
dlg_message.tcltkGUI <- function(message, type = c("ok", "okcancel", "yesno",
"yesnocancel"), ..., gui = .GUI) {
  gui$setUI(args = list(message = message, type = type), widgets = "tcltkGUI")
  # TODO: use custom dialog boxes, not tkmessageBox() cf. ugly in Linux
  # and buggy on MacOS!!!
  # Use tkmessageBox for now
  tkDefault <- switch(gui$args$type[1],
    "ok" = "ok",
    "okcancel" = "ok",
    "yesno" = "yes",
    "yesnocancel" = "yes",
    stop("'type' must be \"ok\", \"okcancel\", \"yesno\" or \"yesnocancel\"")
  )
  if (type[1] == "ok") {
    alarm()
    tkIcon <- "info"
    tkTitle <- "Information"
  } else {
    tkIcon <- "question"
    tkTitle <- "Question"
  }
  res <- tkmessageBox(message = gui$args$message, title = tkTitle,
    type = gui$args$type[1], default = tkDefault, icon = tkIcon)
  res <- tolower(tclvalue(res))
  # Under Windows, we have to bring the R Console to top manually
  # TODO: this does not work in RTerm... but it is a minor annoyance
  if (.Platform$OS.type == "windows")
    grDevices::bringToTop(-1)
  gui$setUI(res = res, status = NULL)
  return(invisible(gui))
}
