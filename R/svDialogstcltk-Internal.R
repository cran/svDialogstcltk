.onLoad <- function(lib, pkg) {
  # Add a dispatch to 'tcltkGUI' in the .GUI object
  svGUI::gui_widgets(.GUI) <- "tcltkGUI"
}

#.onUnload <- function(libpath) {
#  # We do nothing, because other packages may also use the 'tcltkWidgets' dispatch
#}
