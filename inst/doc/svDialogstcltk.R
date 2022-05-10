## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## -----------------------------------------------------------------------------
# This must be TRUE in order to see the Tcl/Tk dialog boxes
capabilities("tcltk")

## -----------------------------------------------------------------------------
library(svGUI)
library(svDialogs)
# The default GUI
.GUI
def_widgets <- gui_widgets(.GUI)
def_widgets

## ---- eval=FALSE--------------------------------------------------------------
#  dlg_message("Hello world!")$res

## -----------------------------------------------------------------------------
library(svDialogstcltk)
gui_widgets(.GUI)

## ---- eval=FALSE--------------------------------------------------------------
#  dlg_message("Hello world!")$res

## -----------------------------------------------------------------------------
# Restore nativeGUI + textual fallback for the default .GUI
gui_change('.GUI', widgets = def_widgets, reset = TRUE)

# Add a new GUI called myGUI
gui_add("myGUI")
myGUI
# Switch to Tcl/Tk version of the dialog boxes exclusively for myGUI
gui_change('myGUI', widgets = "tcltkGUI", reset = TRUE)

## -----------------------------------------------------------------------------
# A message box in the default GUI (native)
dlg_message("Hello from the default GUI!")$res

# A message box in myGUI (Tcl/Tk version)
dlg_message("Hello from myGUI (Tcl/Tk)!", gui = myGUI)$res

