*** Settings ***
Resource    ../commonKeywords.robot
Library    SeleniumLibrary    
Resource    ../browser_setup.robot
Resource    testAutomation_OR.robot
Test Teardown    Close All Browsers 
*** Keywords ***
Launch webpage
    [Arguments]    ${url}
    browser_setup.Setup Browser
    Go To    ${url}
Open Amazon
    Launch webpage    ${AmazonUrl}         
    Common Click Element    click on sign in link    ${AMZ_signInAnchor}
    Sleep    3s    
    Common Click Element    click on sign in button    ${AMZ_signInAnchor} 
    ${user}    common get username
    Common Input Text    Entering username    ${TxtUserName}    ${user}
    Common Click Element    Clicking on continue button    ${BtnUserContinue}    
    ${pass}    common get password
    Common Input Password    Entering password    ${TxtUserPass}    ${pass}
    Common Click Element    Click on login button    ${BtnLogin}    
*** Test Cases ***
AQE
    Open Amazon