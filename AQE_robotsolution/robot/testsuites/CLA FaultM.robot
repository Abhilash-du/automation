*** Settings ***

Resource    ../CLAMP/CLAMP_RESOURCE.robot
Resource    ../CLAMP/CLAMP_DATA.robot
Resource    ../CLAMP/CLAMP_OR.robot
Library     callReporter
Resource    DCAE_data.robot
Library     SeleniumLibrary
Library     SSHLibrary
Library     OperatingSystem
Library     Collections
Library     String
Resource    DCAE_closedLoopAutomation.robot
*** Test Cases ***
Closed Loop Automation
    ${MODEL_NAME}    CLAMP Simplified Flow - Simplified_HighlandPark_Template
    Login to Policy Handler docker     ${MODEL_NAME}
    Login to Hp Overland docker    ${MODEL_NAME}
    Policy Validation in Consul     ${MODEL_NAME}
   
*** Keywords ***
CLAMP Simplified Flow - Simplified_HighlandPark_Template
    [Tags]    Simplified_Model

    Log To Console                         Starting the Execution of Test Case - CLAMP Shakeout Simplified Flow - Simplified_HighlandPark_Template
    ${STATUS_SIMPLIFIED_TEMPLATE_MODEL}    ${MODEL_NAME}    Simplified_HighlandPark_Template Model Create and Deploy
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Log To Console    Status Code for Component - CLAMP Simplified Flow - Simplified_HighlandPark_Template - is ${STATUS_SIMPLIFIED_TEMPLATE_MODEL}
    Log To Console    -------------------------------------------------------------------------------------------------------------------------    
    Close Browser

    Run Keyword If     '${STATUS_SIMPLIFIED_TEMPLATE_MODEL}'=='1'    Fail    ***Execution of testcase - CLAMP Simplified Flow - Simplified_HighlandPark_Template Failed. Please check.***
    Run Keyword If     '${STATUS_SIMPLIFIED_TEMPLATE_MODEL}'=='0'    Log To Console    ***Execution of testcase - CLAMP Simplified Flow - Simplified_HighlandPark_Template is Successful.***    
    [Return]    ${MODEL_NAME}
    
    
Simplified_HighlandPark_Template Model Create and Deploy
    Login to CLAMP
    ${STATUS_FINAL_RESULT}    Set Variable    1

    ${MODEL_NAME}=    Create New Model - Simple Upload     Tosca_HP-SM
    Configure CL    ${MODEL_NAME}    NA
    ${STATUS_FINAL_RESULT}=     Deploy The Model
    #Verify Policies in PDP    ${MODEL_NAME}    
   
    # Manage-UnDeploy    ----> BM
    # Manage-Delete             --->BM
#    Run Keyword And Return If    '${STATUS_FINAL_RESULT}'=='1'    Fail    There is error at Manage>Test or Manage>SubmitToDCAE or Manage>Deploy. Please check
#    Close Browser    
     Return From Keyword     ${STATUS_FINAL_RESULT}        ${MODEL_NAME}

Login to Policy Handler docker    
    [Arguments]    ${MODEL_NAME}
    Open Connection    32.68.131.70
    Login With Public Key     ${USERNAME}    ${GLOBAL_publicKey}    ${passphrase}   
    write     docker ps | grep policy
    ${out1}  Read
    ${list}  Split String    ${out1}    
    ${dockerid}     Get From List     ${list}     0
    Log To Console    Policy handler docker id:${dockerid}
    write    docker exec -it ${dockerid} /bin/bash
    write    cd /opt/app/policy_handler/logs
    #write    ls -lrt
    write    grep -c -l ${MODEL_NAME} policy*
    ${grep}    read
    Log To Console    ${grep}
    [Return]     ${MODEL_NAME}
    # ${grep}    Get Line    ${grep}    0
    # #Should Contain    ${grep}    ${MODEL_NAME}   
    # Close Connection
    # Login to Hp Overland docker     ${MODEL_NAME}
    

    
    
Login to Hp Overland docker
    [Arguments]    ${MODEL_NAME}
    Open Connection    32.68.131.79
    Login With Public Key     ${USERNAME}    ${GLOBAL_publicKey}    ${passphrase}   
    write     docker ps | grep hp-sm
    sleep    4s
    ${out1}  Read
    ${list}  Split String    ${out1}    
    ${dockerid}     Get From List     ${list}     0
    Log To Console    Policy handler docker id :    ${dockerid}
    write    docker exec -it ${dockerid} /bin/bash
    write    cd /opt/app/dcaeap/highlandpark/policies_out/StringMatching
    Sleep    400
    #write    ls -lrt
    #sleep    20
    write    grep -A 13 'ABATED' smProcessing.json | grep -A 1 '${MODEL_NAME}' | tail -1 | cut -d'"' -f4
    ${ABATEDseverity}    read    delay=2s
    ${ABATEDseverity}    Get Line    ${ABATEDseverity}    0
    
    write    grep -A 13 'ONSET' smProcessing.json | grep -A 1 '${MODEL_NAME}' | tail -1 | cut -d'"' -f4
    ${ONSETseverity}    read    delay=2s
    ${ONSETseverity}    Get Line    ${ONSETseverity}    0
    write    grep -A 13 'ABATED' smProcessing.json | grep -B 5 '${MODEL_NAME}' | head -1 | cut -d'"' -f4
    ${ABATEDalarmcondition}    read    delay=2s
    ${ABATEDalarmcondition}    Get Line    ${ABATEDalarmcondition}    0
    write    grep -A 13 'ONSET' smProcessing.json | grep -B 5 '${MODEL_NAME}' | head -1 | cut -d'"' -f4
    ${ONSETalarmcondition}    read    delay=2s
    ${ONSETalarmcondition}    Get line    ${ONSETalarmcondition}    0
    write    grep -A 15 'ONSET' smProcessing.json | grep -A 8 '${MODEL_NAME}' | tail -1 | cut -d'"' -f4
    ${ONSETsourcelist}    read    delay=2s
    ${ONSETsourcelist}    Get Line      ${ONSETsourcelist}    0 
    Log To Console    ${ONSETsourcelist}
    Close Connection
    should be equal    ${ABATEDseverity}    NORMAL
    should be equal    ${ONSETseverity}    CRITICAL
    should be equal    ${ABATEDalarmcondition}    SYS_SNMPFailure    
    should be equal    ${ONSETalarmcondition}    SYS_SNMPFailure 
    should be equal    ${ONSETsourcelist}     ${sourceListVM}
 