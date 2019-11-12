@author: ad622b
*** Settings ***
Resource         ../resources/vid/VID_RESOURCE.robot
Resource    ../resources/NC/input_keywords.robot
Resource    ../resources/NC/input_keywords.robot
Resource         ../resources/vid/vid_data.robot
Resource         ../resources/portal/PORTAL_RESOURCE.robot
Resource         ../resources/global_properties.robot
Resource         ../resources/browser_setup.robot
Resource         ../resources/SDC/SDC_RESOURCE.robot
#Resource        ../resources/SDC/SDC_DATA.robot
Resource         ../resources/vid/VID_RESOURCE.robot
Resource    ../resources/Network_VID/NetworkCloud_Execution.robot
Resource         ../resources/portal/PORTAL_RESOURCE.robot
Resource         ../resources/aai/AAI_RESOURCE.robot
Resource         ../resources/sdnc_portal/SDNC_PORTAL_RESOURCE.robot
Resource         ../resources/CLAMP/CLAMP_RESOURCE.robot
Resource         Driver_Policy.robot
Resource         CLAMP_Regression.robot
Resource         ../resources/commonKeywords.robot
Resource         Driver_ASDC.robot
Resource         aai_testsuite.robot
# Resource         ../resources/AAI/AAI_RESOURCE.robot
Library          callReporter
Library          testScreenshot
Library          testLib
Library          ../../properties/global_properties.py
Library          SeleniumLibrary
Library          RequestsLibrary

Test Setup       Authentication
Test Teardown    Copy Logs    ${EXECDIR}    ${SUITE NAME}
*** Variables ***
@{files1}    

*** Test Cases ***
Network Cloud NW model Creation for User Pane SRIOV
    SRIOV Model Creation     #ASDC
    AAI Tenant Validations    #AAI
    TC#02_Network_Preload_Upload    #SDN- Upload Preload Sheet
    NC SRIOV    #VID- Deploy Model

Network Cloud NW model Creation for User Pane OVS
       OVS Model Creation
       AAI Tenant Validations    #AAI
      # TC#02_Network_Preload_Upload          --> In Progress(Sudansu)
        NC Network Spinup OVS
*** Keywords ***
SRIOV Model Creation
       ${service_name_SRIOV_Run}   Create New Service Network model flow
        delete checkout items
        Change User Role for testing        TESTER
        Test The Service  1  vnf  ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing        GOVERNOR
        Approve The Service  1  vnf   ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing    OPS
        Distribute The Service    1  vnf   ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing    DESIGNER 

AAI Tenant Validations
    Run A&AI Get Request    AAI_RESOURCE_ENDPOINT_PATH    AAI_RESOURCE_ID

TC#02_Network_Preload_Upload
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    Login To Ecomp Portal
    Log To Console    Login Success    
    launch Application and Validate   SDNGC-Admin-Portal
    Log To Console    Application Launched    
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
#    log list  ${files1}
    Log To Console    Updating the Preload details     
#    Update the Network Preload Details    mgmt_net.xlsm    ${NETWORK_NAME}
#    Get the Network Preload Details    mgmt_net.xlsm    ${NETWORK_NAME}
    Log To Console    Updated the Preload    
    Set Global Variable    ${vnf}      vCOM
    Log To Console    Executing the Network Preload Upload        
    Network preload upload    @{files1}

Run A&AI Get Request
    [Documentation]    Basic Get Request   
    [Arguments]    ${AAI_RESOURCE_ENDPOINT_PATH}     ${AAI_RESOURCE_ID}
    #Create the Session 
    ${session} =  Create Session    aai    ${${GLOBAL_ENVIRONMENT}_AAI_FRONTEND_ENDPOINT}      proxies=${GLOBAL_ATT_PROXY}	verify=${AAI_CERT}
    ${headers}=  Create Dictionary     X-FromAppId=${X_FromAppId}     X-TransactionId=${X_TransactionId}    Accept=${Accept}    Content-Type=${Content_Type}
    #Make the call(and capture the response in a varibale) 
    ${response} =   Get Request  aai      aai/v${VERSIONED_INDEX_PATH}${AAI_RESOURCE_ENDPOINT_PATH}${AAI_RESOURCE_ID}?depth=all       headers=${headers} 
    #Check the response status 
    #Should Be Equal As Strings     ${response.status_code}    200
    #Saving Response
    Save Response    ${response}
    Log    ${response.status_code} 
    #Check the response body 
    ${json} =  Set Variable   ${response.json()} 
    #Log    Received response from aai ${response.json()}
    Log to Console    Response Recieved with Status Code:${response.status_code} for GET Request.
    [Return]    ${response}

NC SRIOV
    Set Selenium Implicit Wait      380s
    input_keywords.login to portal
    input_keywords.Goto VID
    input_keywords.Browse ASDC Model And Deploy
    input_keywords.select input frame
    Wait Until Page Contains Element    //span[@data-tests-id="create-modal-title"]
    ${random}  Generate Random String    8     
    set instance name  ${instanceName}_${random}
    input_keywords.select subscriber name
    set instance name  ${instanceName}_${random}
    input_keywords.select service type
    input_keywords.select owining entity
    input_keywords.select project
    input_keywords.click on set button
    input_keywords.select vid frame
    input_keywords.select input vnf
    click on SRIOV NET_1
    Wait Until Page Contains Element                  //sdc-loader[@ng-reflect-active="false"]
    set instance name   ${SRIOV_net1_instance_name}
    input_keywords.select product family
    input_keywords.select LCP region
    select tenat 
    input_keywords.select platform
    input_keywords.click on set button   
    click on SRIOV NET_2
    Wait Until Page Contains Element                  //sdc-loader[@ng-reflect-active="false"]
    set instance name   ${SRIOV_net2_instance_name}
    input_keywords.select product family
    input_keywords.select LCP region
    select tenat 
    input_keywords.select platform
    input_keywords.click on set button   
    Wait Until Page Contains Element                  //sdc-loader[@ng-reflect-active="false"]
    input_keywords.Click on Deploy