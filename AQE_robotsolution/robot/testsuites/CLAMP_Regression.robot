*** Settings ***

Resource    ../resources/CLAMP/CLAMP_RESOURCE.robot
Library    callReporter    
Library    testScreenshot    
Library    OSUtils    

Library    SeleniumLibrary
#Test Teardown    Close All Browsers

*** Variables ***
${test}



*** Test Cases ***


#----------------------------------------------- Simplified Model - START ----------------------------------------#

CLAMP Simplified Flow - Simplified_Template
    [Tags]    Simplified_Model    Shakeout

    Log To Console                         Starting the Execution of Test Case - CLAMP Shakeout Simplified Flow - Simplified_Template
    ${STATUS_SIMPLIFIED_TEMPLATE_MODEL}    Simplified_Template Model Create and Deploy
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Log To Console    Status Code for Component - CLAMP Simplified Flow - Simplified_Template - is ${STATUS_SIMPLIFIED_TEMPLATE_MODEL}
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Close Browser

    Run Keyword If     '${STATUS_SIMPLIFIED_TEMPLATE_MODEL}'=='1'    Fail    ***Execution of testcase - CLAMP Shakeout Simplified Flow - Simplified_Template Failed. Please check.***
    Run Keyword If     '${STATUS_SIMPLIFIED_TEMPLATE_MODEL}'=='0'    Log To Console    ***Execution of testcase - CLAMP Shakeout Simplified Flow - Simplified_Template is Successful.***


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

CLAMP Simplified Flow - Simplified_Template_without_Ops_Policy
    [Tags]    Simplified_Model

    Log To Console                         Starting the Execution of Test Case - CLAMP Shakeout Simplified Flow - Simplified_Template_without_Ops_Policy
    ${STATUS_SIMPLIFIED_TEMPLATE_MODEL}    Simplified_Template_without_Ops_Policy Model Create and Deploy
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Log To Console    Status Code for Component - CLAMP Simplified Flow - Simplified_Template_without_Ops_Policy - is ${STATUS_SIMPLIFIED_TEMPLATE_MODEL}
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Close Browser

    Run Keyword If     '${STATUS_SIMPLIFIED_TEMPLATE_MODEL}'=='1'    Fail    ***Execution of testcase - CLAMP Simplified Flow - Simplified_Template_without_Ops_Policy Failed. Please check.***
    Run Keyword If     '${STATUS_SIMPLIFIED_TEMPLATE_MODEL}'=='0'    Log To Console    ***Execution of testcase - CLAMP Simplified Flow - Simplified_Template_without_Ops_Policy is Successful.***    

    

#----------------------------------------------- Simplified Model - END ----------------------------------------#
    

# ------------------------------------------------ Normal Model - START -------------------------------------------#   

CLAMP Normal Model - HighlandPark Stringmatch
    [Tags]    Normal_Model    Shakeout   
    Log To Console    Starting the Execution of Testcase - CLAMP Shakeout Normal Model - HighlandPark Stringmatch
    ${STATUS_NORMAL_SMHP_MODEL}          Normal Model StringMatch HighlandPark Model Create and Submit
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Log To Console    Status Code for Component - Normal Model StringMatch HighlandPark Model Create and Submit - is ${STATUS_NORMAL_SMHP_MODEL} 
    Log To Console    -------------------------------------------------------------------------------------------------------------------------
    Close Browser
    Run Keyword If    '${STATUS_NORMAL_SMHP_MODEL}'=='1'   Fail    ***Execution of testcase - CLAMP Shakeout Normal Model - HighlandPark Stringmatch Failed. Please check.*** 
    Run Keyword If    '${STATUS_NORMAL_SMHP_MODEL}'=='0'   Log To Console    ***Execution of testcase - CLAMP Shakeout Normal Model - HighlandPark Stringmatch is Successful.***        

CLAMP Normal Model - Argus
    [Tags]    Normal_Model  
    Log To Console    Starting the Execution of Testcase - CLAMP Shakeout Normal Model - Argus
    ${STATUS_NORMAL_ARGUS_MODEL}          Normal Model Argus Model Create and Submit
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Log To Console    Status Code for Component - Normal Model Argus Model Create and Submit - is ${STATUS_NORMAL_ARGUS_MODEL} 
    Log To Console    -------------------------------------------------------------------------------------------------------------------------
    Close Browser
    Run Keyword If    '${STATUS_NORMAL_ARGUS_MODEL}'=='1'   Fail    ***Execution of testcase - CLAMP Shakeout Normal Model - Argus Failed. Please check.***
    Run Keyword If    '${STATUS_NORMAL_ARGUS_MODEL}'=='0'   Log To Console    ***Execution of testcase - CLAMP Shakeout Normal Model - Argus is Successful.***    
       
CLAMP Normal Model - MTCA
    [Tags]    Normal_Model  
    Log To Console    Starting the Execution of Testcase - CLAMP Shakeout Normal Model - MTCA
    ${STATUS_NORMAL_MTCA_MODEL}          Normal Model MTCA Model Create and Submit
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Log To Console    Status Code for Component - Normal Model MTCA Model Create and Submit - is ${STATUS_NORMAL_MTCA_MODEL} 
    Log To Console    -------------------------------------------------------------------------------------------------------------------------
    Close Browser
    Run Keyword If    '${STATUS_NORMAL_MTCA_MODEL}'=='1'   Fail    ***Execution of testcase - CLAMP Shakeout Normal Model - MTCA Failed. Please check.***
    Run Keyword If    '${STATUS_NORMAL_MTCA_MODEL}'=='0'   Log To Console    ***Execution of testcase - CLAMP Shakeout Normal Model - MTCA is successful. Please check.***
    
     
# ------------------------------------------------ Normal Model - END -------------------------------------------#  

CLAMP Tosca HP GOC Enhancements
    [Tags]    Tosca_HP_GOC
    Log To Console                         Starting the Execution of Test Case - CLAMP Tosca HP GOC Enhancements
    ${STATUS_TOSCA_GP_GOC_MODEL}    Tosca HP GOC Enhancements Model Create and Deploy
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Log To Console    Status Code for Component - CLAMP Tosca HP GOC Enhancements - is ${STATUS_TOSCA_GP_GOC_MODEL}
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Close Browser

    Run Keyword If     '${STATUS_TOSCA_GP_GOC_MODEL}'=='1'    Fail    ***Execution of testcase - CLAMP Tosca HP GOC Enhancements Failed. Please check.***
    Run Keyword If     '${STATUS_TOSCA_GP_GOC_MODEL}'=='0'    Log To Console    ***Execution of testcase - CLAMP Tosca HP GOC Enhancements is Successful.***  
    




CLAMP CellSite Flow - Update Model
    [Tags]    CellSite
    Log To Console                         Starting the Execution of Test Case - CLAMP CellSite Flow - Update Model
    ${STATUS_SIMPLIFIED_CELLSITE}    CellSite Model Update and Validate Policy
    Close Browser   
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Log To Console    Status Code for Component - CLAMP CellSite Flow - Update Model - is ${STATUS_SIMPLIFIED_CELLSITE}
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Run Keyword If     '${STATUS_SIMPLIFIED_CELLSITE}'=='1'    Fail    ***Execution of testcase - CLAMP CellSite Flow - Update Model Failed. Please check.***
    Run Keyword If     '${STATUS_SIMPLIFIED_CELLSITE}'=='0'    Log To Console    ***Execution of testcase - CLAMP CellSite Flow - Update Model is Successful.*** 


       
CLAMP Shakeout Flow
    [Tags]    Shakeout_Flow
    Log To Console    Starting the Execution of Shakeout Test Case 1 - Normal Model StringMatch HighlandPark Model Create and Submit
    ${STATUS_NORMAL_SMHP_MODEL}          Normal Model StringMatch HighlandPark Model Create and Submit
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Log To Console    Status Code for Component - Normal Model StringMatch HighlandPark Model Create and Submit - is ${STATUS_NORMAL_SMHP_MODEL} 
    Log To Console    -------------------------------------------------------------------------------------------------------------------------
    Close Browser
    
    Log To Console    Starting the Execution of Shakeout Test Case 2 - Simplified_Template Model Create and Deploy
    ${STATUS_SIMPLIFIED_TEMPLATE_MODEL}       Simplified_Template Model Create and Deploy 
    Log To Console    -------------------------------------------------------------------------------------------------------------------------
    Log To Console    Status Code for Component - Simplified_Template Model Create and Deploy - is ${STATUS_SIMPLIFIED_TEMPLATE_MODEL}  
    Log To Console    -------------------------------------------------------------------------------------------------------------------------  
    Close Browser                  
     
    Run Keyword If    '${STATUS_NORMAL_SMHP_MODEL}'=='1' or '${STATUS_SIMPLIFIED_TEMPLATE_MODEL}'=='1'    Fail    ***Execution of testcase - CLAMP Shakeout Flow Failed. Please check.***   
    Run Keyword If    '${STATUS_NORMAL_SMHP_MODEL}'=='0' and '${STATUS_SIMPLIFIED_TEMPLATE_MODEL}'=='0'    Log To Console    ***Execution of testcase - CLAMP Shakeout Flow is successful.***



# ---------------------------------------------- Under Development - START ----------------------------------#




       
test
    
    Login to CLAMP
    Verify Policies in PDP    CellSite_EnergySavings_Demo   
    # Setup Browser Chrome
    # Go To    ${PORTAL_URL_IST_1902}
    # Maximize Browser Window
    # Execute Javascript    document.body.style.zoom='80%'
    

# ---------------------------------------------- Under Development - END ----------------------------------#

  
       
*** Keywords ***

Normal Model StringMatch HighlandPark Model Create and Submit
    #Tested and Verified
    Login to CLAMP
    ${STATUS_FINAL_RESULT}    Set Variable                     1
    ${MODEL_NAME}=            Create Template and CL Model     ${FILE_STRINGMATCH_YAML}    @{TEMPLATE_HPSM}    #@{TEMPLATE_ARGUS}
    Configure CL              ${MODEL_NAME}                    ${COMMON_SERVICE_NAME}

#    ${STATUS_TEST}            Run Keyword And Return Status    Manage-Test
     ${STATUS_TEST}            Manage-Test
#    ${STATUS_SUBMIT}          Run Keyword And Return Status    Manage-Submit
     ${STATUS_SUBMIT}          Manage-Submit

    Run Keyword If    '${STATUS_TEST}' == '0' and '${STATUS_SUBMIT}'=='0'    Set Test Variable    ${STATUS_FINAL_RESULT}    0   

#     Manage-Delete
     ASDC Service Check in    ${COMMON_SERVICE_NAME}
     Return From Keyword      ${STATUS_FINAL_RESULT}
    
#    Run Keyword If    '${STATUS_FINAL_RESULT}'=='1'    Fail    There is error at Manage>Test or Manage>Submit. Please check
#    Close Browser

Normal Model MTCA Model Create and Submit
    # 
    Login to CLAMP
    ${STATUS_FINAL_RESULT}    Set Variable                     1
    ${MODEL_NAME}=            Create Template and CL Model     ${FILE_MTCA_YAML}    @{TEMPLATE_MTCA}
    Configure CL              ${MODEL_NAME}                    NarraISTService

    ${STATUS_TEST}                Manage-Test
    ${STATUS_SUBMIT}              Manage-Submit
     
     Run Keyword If    '${STATUS_TEST}' == '0' and '${STATUS_SUBMIT}'=='0'    Set Test Variable    ${STATUS_FINAL_RESULT}    0
     
#    Manage-Delete
     ASDC Service Check in    NarraISTService
     Return From Keyword      ${STATUS_FINAL_RESULT}

Normal Model Argus Model Create and Submit

    Login to CLAMP
    ${STATUS_FINAL_RESULT}    Set Variable                     1
    ${MODEL_NAME}=    Create Template and CL Model    ${FILE_ARGUS_YAML}    @{TEMPLATE_ARGUS}    
    Configure CL      ${MODEL_NAME}    ${COMMON_SERVICE_NAME}
    
    ${STATUS_TEST}          Manage-Test    
    ${STATUS_SUBMIT}        Manage-Submit
    
    Run Keyword If    '${STATUS_TEST}' == '0' and '${STATUS_SUBMIT}'=='0'    Set Test Variable    ${STATUS_FINAL_RESULT}    0
    
#    Manage-UnDeploy
#    Manage-Delete
    ASDC Service Check in    ${COMMON_SERVICE_NAME}
    Return From Keyword      ${STATUS_FINAL_RESULT}

Simplified_Template Model Create and Deploy
    #Tested and Verified
    Login to CLAMP
    ${STATUS_FINAL_RESULT}    Set Variable    1
    ${MODEL_NAME}=    Create New Model - Simple Upload    Simplified_Template
    Configure CL    ${MODEL_NAME}    NA
    
    ${STATUS_FINAL_RESULT}=    Deploy The Model
#    ${STATUS_FINAL_RESULT}=       Submit The Model
    Manage-UnDeploy
    Manage-Delete
#    Run Keyword And Return If    '${STATUS_FINAL_RESULT}'=='1'    Fail    There is error at Manage>Test or Manage>SubmitToDCAE or Manage>Deploy. Please check
#    Close Browser
    Return From Keyword     ${STATUS_FINAL_RESULT}
    
Simplified_HighlandPark_Template Model Create and Deploy
    #
    Login to CLAMP
    ${STATUS_FINAL_RESULT}    Set Variable    1
    ${MODEL_NAME}=    Create New Model - Simple Upload    Simplified_HighlandPark_Template
    Configure CL    ${MODEL_NAME}    NA
  
    ${STATUS_FINAL_RESULT}=     Deploy The Model
     
    Manage-UnDeploy
    Manage-Delete
#    Run Keyword And Return If    '${STATUS_FINAL_RESULT}'=='1'    Fail    There is error at Manage>Test or Manage>SubmitToDCAE or Manage>Deploy. Please check
#    Close Browser    
     Return From Keyword     ${STATUS_FINAL_RESULT} 
 
Simplified_Template_without_Ops_Policy Model Create and Deploy
    #
    Login to CLAMP
    ${STATUS_FINAL_RESULT}    Set Variable    1
    ${MODEL_NAME}=    Create New Model - Simple Upload    Simplified_Template_without_Ops_Policy
    Configure CL    ${MODEL_NAME}    NA
    
    ${STATUS_FINAL_RESULT}=     Deploy The Model
     
    Manage-UnDeploy
    Manage-Delete    
    Return From Keyword     ${STATUS_FINAL_RESULT}


    

Tosca HP GOC Enhancements Model Create and Deploy
    #
    Login to CLAMP
    ${STATUS_FINAL_RESULT}    Set Variable    1
    ${MODEL_NAME}=    Create New Model - Simple Upload    Tosca_HP_GOC
    Configure the CL - Tosca_HP_GOC      ${MODEL_NAME}
    ${STATUS_FINAL_RESULT}=     Submit The Model
    Manage-Stop
    Manage-Delete
    Return From Keyword     ${STATUS_FINAL_RESULT}
   
   
CellSite Model Update and Validate Policy
    #
    Login to CLAMP
    ${STATUS_FINAL_RESULT}    Set Variable    1
    ${STATUS_POLICY}    Remove Policies from PDP and PAP   CellSite_EnergySavings_Demo
    Log To Console    Status of Removing Policy from PDP and PAP is : ${STATUS_POLICY}
    Run Keyword If    '${STATUS_POLICY}'=='1'    Return From Keyword    1
    Open CL Model    CellSite_EnergySavings_Demo
    ${STATUS_SIMPLIFIED_CELLSITE}    Manage-Update
    ${STATUS_POLICY}    Verify Policies in PDP    CellSite_EnergySavings_Demo
    Log To Console    Return value of the Keyword Verify Policy is :${STATUS_POLICY}
    Run Keyword If    '${STATUS_POLICY}' == '0' and '${STATUS_SIMPLIFIED_CELLSITE}'=='0'    Set Test Variable    ${STATUS_FINAL_RESULT}    0
    Return From Keyword    ${STATUS_FINAL_RESULT}         
    