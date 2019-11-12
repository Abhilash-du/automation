*** Settings ***

Resource    ../resources/CLAMP/CLAMP_RESOURCE.robot
Library    callReporter       
# Library    testScreenshot
# Library    OSUtils
Library    SeleniumLibrary

*** Test Cases ***
Closed Loop Automation
    CLAMP Simplified Flow - Simplified_HighlandPark_Template
    #Simplified_HighlandPark_Template Model Create and Deploy

*** Keywords ***
CLAMP Simplified Flow - Simplified_HighlandPark_Template
    [Tags]    Simplified_Model

    Log To Console                         Starting the Execution of Test Case - CLAMP Shakeout Simplified Flow - Simplified_HighlandPark_Template
    ${STATUS_SIMPLIFIED_TEMPLATE_MODEL}    Simplified_HighlandPark_Template Model Create and Deploy
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Log To Console    Status Code for Component - CLAMP Simplified Flow - Simplified_HighlandPark_Template - is ${STATUS_SIMPLIFIED_TEMPLATE_MODEL}
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Close Browser

    Run Keyword If     '${STATUS_SIMPLIFIED_TEMPLATE_MODEL}'=='1'    Fail    ***Execution of testcase - CLAMP Simplified Flow - Simplified_HighlandPark_Template Failed. Please check.***
    Run Keyword If     '${STATUS_SIMPLIFIED_TEMPLATE_MODEL}'=='0'    Log To Console    ***Execution of testcase - CLAMP Simplified Flow - Simplified_HighlandPark_Template is Successful.***    


Simplified_HighlandPark_Template Model Create and Deploy
    #
    Login to CLAMP
    ${STATUS_FINAL_RESULT}    Set Variable    1
    ${MODEL_NAME}=    Create New Model - Simple Upload     Tosca_HP-SM
    Configure CL    ${MODEL_NAME}    NA
    ${STATUS_FINAL_RESULT}=     Deploy The Model
    
    # Manage-UnDeploy    ----> BM
    # Manage-Delete             --->BM
    
    
#    Run Keyword And Return If    '${STATUS_FINAL_RESULT}'=='1'    Fail    There is error at Manage>Test or Manage>SubmitToDCAE or Manage>Deploy. Please check
#    Close Browser    
     Return From Keyword     ${STATUS_FINAL_RESULT} 