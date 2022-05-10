#' A Tcl/Tk version of the {svDialogs} list selection dialog box
#'
#' @param choices The list of items. It is coerced to character strings.
#' @param preselect A list of preselections, or `NULL` (then, the first element
#' is selected in the list). Preselections not in choices are tolerated (but
#' they are ignored without warning or error).
#' @param multiple Is it a multiple selection dialog box?
#' @param title The title of the dialog box, or `NULL` to use a default title
#' instead.
#' @param ... Not used yet.
#' @param gui The 'gui' object concerned by this dialog box.
#'
#' @return A character vector with the items that were selected by the user.
#' @export
#' @rdname dlg_list
#' @method dlg_list tcltkGUI
#' @seealso [svDialogs::dlg_list()]
#' @keywords misc
#' @concept Modal dialog box
#' @examples
#' library(svDialogstcltk) # Tcl/Tk dialog boxes are now used by default
#' \dontrun{
#' # Select one or several months
#' res <- dlg_list(month.name, multiple = TRUE)$res
#' if (!length(res)) {
#'   cat("You cancelled the choice\n")
#' } else {
#'   cat("You selected:\n")
#'   print(res)
#' }
#' }
dlg_list.tcltkGUI <- function(choices, preselect = NULL, multiple = FALSE,
title = NULL, ..., gui = .GUI) {
  gui$setUI(args = list(choices = choices, preselect = preselect,
    multiple = multiple, title = title), widgets = "tcltkGUI")
  res <- tk_select.list(choices = gui$args$choices,
    preselect = gui$args$preselect, multiple = gui$args$multiple,
    title = gui$args$title)
  gui$setUI(res = res, status = NULL)
  return(invisible(gui))
}

## This is old code to rework later...
#    ## We construct the list dialog box with tcltk commands
#    lbox <- tktoplevel()
#	tkwm.withdraw(lbox)
#    tktitle(lbox) <- title
#    tkgrid(tklabel(lbox, text = message), sticky = "w", padx = 5)
#    lstFrame <- tkframe(lbox, width = as.character(width))
#    scr <- tkscrollbar(lstFrame, repeatinterval = 5,
#           command = function (...) tkyview(tl, ...))
#    SelMode <- if (multiple) "extended" else "single"
#    tl <- tklistbox(lstFrame, width = width - 2, height = 5, selectmode = SelMode,
#          yscrollcommand = function (...) tkset(scr, ...), background = "white")
#    tkgrid(tl, scr)
#    tkgrid.configure(scr, rowspan = 5, sticky = "nsw")
#    tkgrid(lstFrame, padx = 5, pady = 2, sticky = "w")
#    for (i in 1:(length(items)))
#        tkinsert(tl, "end", items[i])
#    if (!is.null(default)) {
#        for (i in 1:length(default))
#        tkselection.set(tl, default[i] - 1)  # Default indexing starts at zero.
#        tkyview(tl, default[1] - 1)  # Make sure first selected item is visible
#    }
#    sep <- tkcanvas(lbox, height = "0", relief = "groove", borderwidth = "1")
#    tkgrid(sep)
#    onOk <- function () {
#        res <- items[as.numeric(tkcurselection(tl)) + 1]
#        assignTemp(".res.list", res)
#        tkdestroy(lbox)
#        return(res)
#    }
#    butFrame <- tkframe(lbox)
#    wbutOK <- tkbutton(butFrame, text = "OK", width = "12", command = onOk,
#        default = "active")
#    wlabSep <- tklabel(butFrame, text = " ")
#    wbutCancel <- tkbutton(butFrame, text = "Cancel", width = "12",
#        command = function () tkdestroy(lbox))
#    tkgrid(wbutOK, wlabSep, wbutCancel, sticky = "w")
#    tkgrid(butFrame, pady = 5)
#    .Tcl("update idletasks")
#    tkwm.resizable(lbox, 0, 0)
#    tkbind(lbox, "<Return>", onOk)
#    tkbind(lbox, "<Double-Button-1>", onOk)
#    tkwm.deiconify(lbox)
#    tkfocus(lbox)
#    tkwait.window(lbox)
#    ## Retrieve result
#    res <- getTemp(".res.list")
#    rmTemp(".res.list")
#    return(res)
#}
