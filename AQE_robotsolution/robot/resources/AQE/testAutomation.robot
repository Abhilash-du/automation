*** Settings ***
Resource    ../commonKeywords.robot
Library    SeleniumLibrary    
Resource    ../browser_setup.robot
*** Test Cases ***

Demo
    ${user}    common get username
    Log To Console    ${user}    
    browser_setup.Setup Browser
    Go To    https://www.google.com
    Common Click Element    googl    //input[@name="q" and @type="text"]    
    