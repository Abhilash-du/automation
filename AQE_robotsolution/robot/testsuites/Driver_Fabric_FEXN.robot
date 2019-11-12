*** Settings ***
Resource            ../resources/vid/VID_RESOURCE.robot
Resource            ../resources/vid/vid_data.robot
Resource            ../resources/portal/PORTAL_RESOURCE.robot
Resource            ../resources/global_properties.robot
Resource            ../resources/browser_setup.robot
Resource            ../resources/SDC/SDC_RESOURCE.robot
#Resource            ../resources/SDC/SDC_DATA.robot
Resource            ../resources/vid/VID_RESOURCE.robot
Resource            ../resources/portal/PORTAL_RESOURCE.robot
Resource            ../resources/aai/AAI_RESOURCE.robot

Resource            ../resources/sdnc_portal/SDNC_PORTAL_RESOURCE.robot
Resource            ../resources/CLAMP/CLAMP_RESOURCE.robot
Resource            Driver_Policy.robot

Resource            ../resources/commonKeywords.robot
Resource            Driver_ASDC.robot

Library             callReporter
Library             testScreenshot
Library             testLib


Library             SeleniumLibrary
Test Setup          Authentication
Test Teardown       Copy Logs       ${EXECDIR}    ${SUITE NAME}





*** Variables ***
${test}
#${service_name_Run}
${value2}   2
${roleTag}  cor_direct1

${service_name_Run2}  
${EXCEL_NAME}    mgmt_vcom_net_95.xlsm
${NETWORK_NAME}    APP-C-24595-T-IST-05A-COM-TOAM0_net_99
${files}           mgmt_vcom_net_95.xlsm      #GRP-27529-T-SIL-13B_MGMT_VISBC0_net_11.xlsm   GRP-27529-T-SIL-13B_TRST_VISBC0_net_11.xlsm  GRP-27529-T-SIL-13B_UNTR_VISBC0_net_11.xlsm
${VNF}  FEXN

*** Test Cases ***
Delete checkout items
    delete checkout items
Test Case Change User Role 
    Change User Role for testing     DESIGNER
    



Network OVS Model creation
     Change User Role for testing     DESIGNER
     Set Global Variable   ${SCN}   ${VNF}  
  ${NumModelsCount}    Evaluate    ${NumModels_OVS_${SCN}}+1 
  :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
       \   ${service_name_OVS_Run}  Wait Until Keyword Succeeds   3x   2s   Create New Service OVS Network model flow  ${netItr} 
       \    Set Global Variable    ${service_name_OVS_${SCN}_${netItr}}  ${service_name_OVS_Run}    
       \   Wait Until Keyword Succeeds   3x   2s  delete checkout items
       \   Wait Until Keyword Succeeds   3x   2s  Change User Role for testing        TESTER
       \   Wait Until Keyword Succeeds   3x   2s  Test The Service OVS   ${service_name_OVS_${SCN}_${netItr}}
       \   Wait Until Keyword Succeeds   3x   2s  Change User Role for testing        GOVERNOR
       \  Wait Until Keyword Succeeds   3x   2s  Approve The Service OVS   ${service_name_OVS_${SCN}_${netItr}}
       \   Wait Until Keyword Succeeds   3x   2s   Change User Role for testing    OPS
       \   Wait Until Keyword Succeeds   3x   2s   Distribute The Service oVS   ${service_name_OVS_${SCN}_${netItr}}
       \  Wait Until Keyword Succeeds   3x   2s    Change User Role for testing    DESIGNER 
SRIOV Model Creation
     Set Global Variable   ${SCN}   ${VNF}  
    ${NumModelsCount}    Evaluate    ${NumModels_SRIOV_${SCN}}+1 
  :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
   \    ${service_name_SRIOV_Run}    Wait Until Keyword Succeeds   3x   2s   Create New Service Network model flow   ${netItr}
   \    Set Global Variable     ${service_name_SRIOV_${SCN}_${netItr}}     ${service_name_SRIOV_Run}
   \     Wait Until Keyword Succeeds   3x   2s   delete checkout items
   \     Wait Until Keyword Succeeds   3x   2s   Change User Role for testing        TESTER
   \    Wait Until Keyword Succeeds   3x   2s   Test The Service SRIOV  ${service_name_SRIOV_${SCN}_${netItr}} 
   \     Wait Until Keyword Succeeds   3x   2s  Change User Role for testing        GOVERNOR
   \     Wait Until Keyword Succeeds   3x   2s  Approve The Service SRIOV  ${service_name_SRIOV_${SCN}_${netItr}} 
   \     Wait Until Keyword Succeeds   3x   2s  Change User Role for testing    OPS
   \     Wait Until Keyword Succeeds   3x   2s  Distribute The Service SRIOV    ${service_name_SRIOV_${SCN}_${netItr}} 
   \     Wait Until Keyword Succeeds   3x   2s  Change User Role for testing    DESIGNER 
Test Network Preload upload
    @{file_names}  OperatingSystem.List Files In Directory   ${PATH_TO_NETWORK_PRELOAD_EXCELS}    
    Login To Ecomp Portal 
    Log To Console    Login Success 
    launch Application and Validate   SDNGC-Admin-Portal 
    Log To Console    Application Launched 
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')] 
    Log To Console    Updating the Preload details 
    Log To Console    Updated the Preload 
    Log To Console    Executing the Network Preload Upload 
    Network preload upload    @{file_names}  
NC Network Spinup flow
    NC Network Spinup
AAI Tenant Validations
    Run A&AI Get Request    AAI_RESOURCE_ENDPOINT_PATH    AAI_RESOURCE_ID
vnf model Creation Fabric
   [Documentation]
   ...    in test the service, approve the service and distribute the service, two parameters are passed.
   ...    first is ${netItr} which represents to the number of iterations to be run. secing one is either 
   ...    vnf or network depending upon the type of modal you are trying to create
   # ...    for vnf enter type as vnf and for network enter network
      Set Global Variable   ${SCN}   ${VNF}     
     Wait Until Keyword Succeeds    3x   2s  delete checkout items
     Change User Role for testing     DESIGNER
        Wait Until Keyword Succeeds    3x   2s   Create New License Model Fabric    ${VNF} 
      Wait Until Keyword Succeeds    3x   2s   Create New VSP - HeatFile Fabric   ${VNF} 
    Wait Until Keyword Succeeds    3x   2s  Import The VF Complex Fabric   ${VNF} 
   ${service_name_Run2}    Create New Service Fabric   ${VNF} 
   Set Global Variable     ${service_name_Fabric_${SCN}}       ${service_name_Run2} 
    log to console   test value of service run2 is ${service_name_Run2}    
      Wait Until Keyword Succeeds    3x   2s  delete checkout items
    Wait Until Keyword Succeeds    3x   2s   Change User Role for testing     TESTER
   Wait Until Keyword Succeeds    3x   2s   Test The Service         ${service_name_Fabric_${SCN}}
     Wait Until Keyword Succeeds    3x   2s  Change User Role for testing     GOVERNOR
    Wait Until Keyword Succeeds    3x   2s  Approve The Service         ${service_name_Fabric_${SCN}}
     Wait Until Keyword Succeeds    3x   2s  Change User Role for testing     OPS
    Wait Until Keyword Succeeds    3x   2s  Distribute The Service         ${service_name_Fabric_${SCN}}
    Wait Until Keyword Succeeds    3x   2s   Change User Role for testing     DESIGNER
 





   
VNF Preload Upload

#    [Arguments]    ${VNF_PRELOAD_FILE}
       
     @{file_names}  OperatingSystem.List Files In Directory  ${PATH_TO_VF_PRELOAD_EXCELS}  
    
    Login To Ecomp Portal 
    Log To Console    Login Success 
    launch Application and Validate   SDNGC-Admin-Portal 
    Log To Console    Application Launched 
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')] 
    Log To Console    Updating the Preload details 
    Log To Console    Updated the Preload 
    Log To Console    Executing the Network Preload Upload 
    ${TEST_STATUS}    SDNC Preload upload       @{file_names}
       
    # Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    # Login To Ecomp Portal
    # launch Application and Validate   SDNGC-Admin-Portal
    # Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
   
    # ${TEST_STATUS}    SDNC Preload upload       ${VNF_PRELOAD_FILE}
    Run Keyword If    "${TEST_STATUS}"!="True"    Fail    Error while trying to upload the VNF Preload Upload. Please check.#  
    
NC VNF Spinup
    log to console    add NC vnf spinup here
    #Add VNF spinup code here   
AAI Tenant Validations VNF NC
    Run A&AI Get Request    AAI_RESOURCE_ENDPOINT_PATH    AAI_RESOURCE_ID 
NC Stack Validation for VNF
    log to console   enter code for NC stack validation here         
   
