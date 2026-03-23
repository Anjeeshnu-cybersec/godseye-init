#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#   gui_elements.py - Basic GUI elements for godseye.
#    Copyright (C) 2021 ANJEESHNU
#
#    
#
#Import gui modules
from tkinter import filedialog
from tkinter import Tk
from tkinter import messagebox
Tk().withdraw() #Don't show the root window
#Define function to pick directory
def pickDirectory():
    while True:
        dirPath = filedialog.askdirectory()
        if dirPath is None:
            continue
        elif str(dirPath) in ["()",""]:
            continue
        else:
            return str(dirPath)
#Define function to choose file
def pickFile():
    while True:
        filePath = filedialog.askopenfilename()
        if filePath is None:
            continue
        elif str(filePath) in ["()",""]:
            continue
        else:
            return str(filePath)
#Define function to ask yes/no question
def pickYesOrNo(windowTitle,windowText):
    return messagebox.askyesno(windowTitle,windowText)
#Define function to ask retry/cancel question
def pickRetryOrCancel(windowTitle,windowText):
    return messagebox.askretrycancel(windowTitle,windowText)
#Define function to ask ok/cancel question
def pickOkOrCancel(windowTitle,windowText):
    return messagebox.askokcancel(windowTitle,windowText)