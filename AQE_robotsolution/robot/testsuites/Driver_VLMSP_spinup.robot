*** Settings ***
Resource            ../resources/vid/VID_RESOURCE.robot
Resource            ../resources/vid/vid_data.robot
Resource            ../resources/portal/PORTAL_RESOURCE.robot
Resource            ../resources/global_properties.robot
Resource            ../resources/browser_setup.robot
Resource            ../resources/SDC/SDC_RESOURCE.robot
Resource            ../resources/vid/VID_RESOURCE.robot
Resource            ../resources/portal/PORTAL_RESOURCE.robot
Resource            ../resources/aai/AAI_RESOURCE.robot
Resource            ../resources/sdnc_portal/SDNC_PORTAL_RESOURCE.robot
Resource            Driver_ASDC.robot

*** Variables ***
@{files1}   
${current_net_no}           

*** Test Cases ***

TC#01_ASDC_Network_Model_Creation
    common find replace    replacing flexware vfc    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     SCN}[${SPACE}a-zA-Z://0-9.-_]*   SCN}${SPACE}${SPACE}${SPACE} VLMSP
    common find replace    replacing flexware vfc    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     NumModels}[${SPACE}a-zA-Z://0-9.-_]*   NumModels}${SPACE}${SPACE}${SPACE} 2
       ${NumModelsCount}    Evaluate    ${NumModels}+1    
  :FOR  ${netItr}  IN RANGE   2    ${NumModelsCount}
  \    log to console  netItr is ${netItr}
  \    change User Role    DESIGNER
     
  \  ${serviceNameNetwork}  Create New Service Network test  ${netItr}
  \   Wait Until Keyword Succeeds    5  5x        clear checkout items 
  \  Change User Role        TESTER
  \   log to console  service name passed is ${serviceNameNetwork}
  \  Test The Service  ${netItr}  network   ${ServiceName}   ${serviceNameNetwork}
  \  Change User Role for testing    GOVERNOR
  \  Approve The Service  ${netItr}  network    ${ServiceName}   ${serviceNameNetwork}
  \  Change User Role for testing    OPS
  \  Distribute The Service  ${netItr}  network   ${ServiceName}   ${serviceNameNetwork}
  \  Change User Role for testing    DESIGNER


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
    
TC#03_NW_Spin_Up
  common find replace    replacing flexware vfc    ${EXECDIR}\\robot\\resources\\vid\\VID_DATA.robot     GLOBAL_VNF}[${SPACE}a-zA-Z://0-9.-_]*   GLOBAL_VNF}${SPACE}${SPACE}${SPACE} VLMSP
   ${NumModelsCount}    Evaluate    ${NumModels}+1
    :FOR    ${current_net_no}  IN RANGE   1    ${NumModelsCount}
    \    Network Creation    net_${current_net_no} 


TC#04_ASDC_VNF_Model_Creation
    [Tags]    TC#03
     ${vlm_name}    ${la_name}        ${fg_name}        Create New License Model              
    log to console    value of vlm is ${vlm_name}
    log to console    value of la is ${la_name}
    Set suite variable    ${vlm_name}    ${vlm_name}
    Set suite variable    ${la_name}    ${la_name}
    Set suite variable    ${fg_name}    ${fg_name}
    log to console    value of vlm_name is ${vlm_name}
    
    
    ${vsp_name}           Create New Vendor Software Product - Heatfile     ${vlm_name}    ${la_name}     ${fg_name}
    Log To Console    *******Executed the keyword : Create New Vendor Software Product - Heatfile*****    
    Log To Console        VSP Name: ${vsp_name}
    Set Suite Variable    	${vsp_name}        ${vsp_name}
      
      
    ${vf_name}    Import VF    ${vsp_name}

    Log To Console    ******Executed the keyword : Import VF*****    
    Log To Console    ${vf_name}
    
#    Import VF    <<{vsp_name}>>
    
    
    ${SERVICE_NAME}=    Create New Service    ${vf_name}
    
        
#    Change User Role    ${USERNAME}    TESTER

    Log to Console    Change the role to TESTER. Waiting for 15sec
    Sleep    15
    Test Service    ${SERVICE_NAME}
    
#    Change User Role    ${USERNAME}    GOVERNER
    Log to Console    Change the role to GOVERNER. Waiting for 15sec
    Sleep    15

    Approve Service    ${SERVICE_NAME}
#    Change User Role    ${USERNAME}    OPS

    Log to Console    Change the role to OPS. Waiting for 15sec
    Sleep    15
    
     @{SERVICE_DISTRIBUTION_DETAILS}    Distribute Service    ${SERVICE_NAME}
     Log To Console    First Param: @{SERVICE_DISTRIBUTION_DETAILS}[0]
     Log To Console     Second Param: @{SERVICE_DISTRIBUTION_DETAILS}[1]    
    common find replace   replacing uuid    ${EXECDIR}\\robot\\resources\\vid\\VID_DATA.robot   ${GLOBAL_VNF}_vnf_UUID}[${SPACE}}a-zA-Z://0-9.//,-_]*   ${GLOBAL_VNF}_vnf_UUID}${SPACE}${SPACE}${SPACE} @{SERVICE_DISTRIBUTION_DETAILS}[0]
    common find replace   replacing iuuid  ${EXECDIR}\\robot\\resources\\vid\\VID_DATA.robot   ${GLOBAL_VNF}_vnf_INVARIANT_UUID}[${SPACE}a-zA-Z://0-9.//,-_]*   ${GLOBAL_VNF}_vnf_INVARIANT_UUID}${SPACE}${SPACE}${SPACE} @{SERVICE_DISTRIBUTION_DETAILS}[1]  
#    Change User Role    ${USERNAME}    DESIGNER
     Log to Console    Change the role to DESIGNER. Waiting for 15sec
    Sleep    15
TC#05_VNF_Preload_Upload
    
       
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    Login To Ecomp Portal
    launch Application and Validate   SDNGC-Admin-Portal
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
    ${TEST_STATUS}    VF Preload upload       vCOM_vnf.xlsm     
    Run Keyword If    "${TEST_STATUS}"!="True"    Fail    Error while trying to upload the VNF Preload Upload. Please check.
    
TC#06_VNF_Spinup
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER }     chrome  
    Set Global Variable   ${GLOBAL_VNF}        VISBC
    VNF Creation    vnf
TC#07_Add Volume Group
    [Tags]    TC#05
     Login To Ecomp Portal
     
TC_08_Add Base and Add-on VF Module
    [Tags]    TC#06
    Login To Ecomp Portal
    Add Base VF Module     vnf
    
    
TC_09_Delete VF, Volume Group, VNF, Network
    [Tags]    TC#07
    Login To Ecomp Portal             
    
    
    