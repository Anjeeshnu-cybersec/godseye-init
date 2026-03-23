#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#   manage_inputs.py - Manage different types of inputs for godseye.
#    Copyright (C) 2021 ANJEESHNU
#
#    
#
#Import any needed modules.
from .run_command import *
from .term_colors import printYellow, returnRed
# Create a function to handle numerical input ranges.
def takeNumericInput(inputQuestion, minimumValue, maximumValue, colorClass):
    COL = colorClass
    INPUTPROMPT = COL.green + "[+] " + COL.endl
    PS1 = COL.blue + " ~" + COL.red + "$ " + COL.endl
    while True:
        try:
            inputValue = int(input(INPUTPROMPT + inputQuestion + PS1))
            if minimumValue <= inputValue <= maximumValue:
                break
            else:
                raise ValueError
        except(ValueError):
            createNewLine()
            printYellow(COL, "Error: Please enter an integer between {} and {}.".format(
                minimumValue,
                maximumValue))
            createNewLine()
            continue
    return inputValue
#Create a function to get the numeric dictionary values
def getDictRange(inputDict):
    minVal = list(inputDict.items())[0][0]
    maxVal = list(inputDict.items())[-1][0]
    return (minVal, maxVal)
#Create function to list items from dictionary.
def showDictList(inputDict, colorClass):
    createNewLine()
    for i in inputDict.items():
        print(" (" + returnRed(colorClass, i[0]) + ") " + i[1])
    createNewLine()
#From a 2D list, return two dictionaries
def createDictMap(inputList):
    menuDict = {}
    mappingDict = {}
    for i in enumerate(inputList, start=1):
        menuDict[i[0]] = i[1][0]
        mappingDict[i[0]] = i[1][1]
    return (menuDict, mappingDict)
