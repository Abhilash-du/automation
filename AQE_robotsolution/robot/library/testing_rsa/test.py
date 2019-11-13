from pywinauto.application import Application
import pyautogui
import pyperclip
import subprocess
#import tkinter as tk
# import ttk
def launchDesktopAppCMD(path):
    proc = subprocess.Popen('cmd.exe', stdin = subprocess.PIPE, stdout = subprocess.PIPE)
    stdout, stderr = proc.communicate(path)

def launchDesktopApplication(path):
        try:
            app=Application.Start(path)
        except FileNotFoundError as fnfe:
            print('File is not present in specified location',fnfe)

def locateImageinScreen(imagePath):
        try:
            buttonLocation=pyautogui.locateOnScreen(imagePath)
            buttonx, buttony = pyautogui.center(buttonLocation)
        except FileNotFoundError as fnfe:
            print('Image not found in specified location',fnfe)
        return buttonx,buttony
def click_XY_Cordinates(buttonX, buttonY):        
        pyautogui.click(buttonX, buttonY)
#         buttonLocation=pyautogui.locateOnScreen("url_text.png")
def write_XY_Cordinates(stringValue):
        pyautogui.typewrite(stringValue)
      
def getCopiedItem():
        return pyperclip.paste()