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
Resource         ../resources/NC/NC_Development.robot
Resource         Driver_Policy.robot
#Resource        CLAMP_Regression.robot
Resource         ../resources/commonKeywords.robot
Resource         Driver_ASDC.robot
Resource         aai_testsuite.robot
# Resource         ../resources/AAI/AAI_RESOURCE.robot
Library          callReporter
Library          testScreenshot
Library              testLib

Library          SeleniumLibrary
Library          RequestsLibrary
Resource    ../resources/vid/vid_interface.robot
Test Setup       Authentication
Test Teardown    Copy Logs    ${EXECDIR}    ${SUITE NAME}
*** Variables ***
@{files1}   #file name needs to be updated
# ${SIID}     #THis needs to be updated
# ${NW_NameFromPreload}    # Network name from preload
# ${NETWORK_NAME_FROM_PRELOAD}    GRP-27529-T-IST-13G_LDSA_FE_oam_protected_network_by
# ${NET_ITR}                      1
# @{NETWORK_PRELOAD_FILE_NAME}    oam_protected_LDSA_FE1_Initialbase1_module_FirstNet_Network_preload.xlsm
# ${VNF_PRELOAD_FILE}             ***Enter the FileName here***
# ${SERVICE_NAME}    LDSA_OAM_by5924_03

${NETWORK_COUNT_LOGS}    2
${NETWORK_COUNT_LDSA}    1
${NETWORK_COUNT_MOBTCLI}    1
${VNF_TYPE}    MOBTCLI    #LOGS

${VNF_PRELOAD_FILE}
${PRELOAD_TYPE}      Manual  
${PRELOAD_FILE_NAME}    
${NUMBER_OF_ADDON_VF_MODULE}    1
@{AIC_NETWORK_NAME}    GRP-27529-T-IST-13G_LDSA_FE_oam_protected_network_by


*** Test Cases ***
    
Network Cloud NW model Creation for Control Plane - LDSA_LTM
        ${SERVICE_NAME}    Create New Service Network Test - Contrial 30 Basic
         Network_Preload_Upload    @{NETWORK_PRELOAD_FILE_NAME}     
             
         VID_RESOURCE.VID Network Creation    ${SERVICE_NAME}  ${NETWORK_NAME_FROM_PRELOAD}    ${NET_ITR}
       
        AIC Validations for network    @{AIC_NETWORK_NAME}    #Testing pending for this keyword
        
        ${VNF_SERVICE_NAME}    ASDC_VNF_Model_Creation
        
         VNF_Preload_Upload    ${VNF_PRELOAD_FILE}
        
         VNF_Spin_up   ${VNF_SERVICE_NAME} 
         
      
        
Cleanup
        
        Delete VNF and Service Instance    SERVICE_INSTANCE_ID
        Delete Network and Service Instance    SERVICE_INSTANCE_ID  
        
TC#01_Network Model creation
  ${NumModelsCount}    Evaluate    ${NETWORK_COUNT_${VNF_TYPE}}+1    
  :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
  \    log to console  netItr is ${netItr}
  \    change User Role for testing    DESIGNER
     
  \  ${serviceNameNetwork}  Create New Service Network Test   ${netItr}
  \   Wait Until Keyword Succeeds    5   5x        clear checkout items 
  \  Change User Role for testing        TESTER
  \    log to console  service name passed is ${serviceNameNetwork}
  \  Test The Service  ${netItr}  network   ${ServiceName}   ${serviceNameNetwork}
  \  Change User Role for testing    GOVERNOR
  \  Approve The Service  ${netItr}  network    ${ServiceName}   ${serviceNameNetwork}
  \  Change User Role for testing    OPS
  \  Distribute The Service  ${netItr}  network   ${ServiceName}   ${serviceNameNetwork}
  \    
  
TC#02_Test Network Preload upload
    @{file_names}  OperatingSystem.List Files In Directory  ${PATH_TO_NETWORK_PRELOAD_EXCELS}  
    
    Login To Ecomp Portal 
    Log To Console    Login Success 
    launch Application and Validate   SDNGC-Admin-Portal 
    Log To Console    Application Launched 
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')] 
    Log To Console    Updating the Preload details 
    Log To Console    Updated the Preload 
    Log To Console    Executing the Network Preload Upload 
    Network preload upload    @{file_names}
    

# #    [Arguments]    @{NETWORK_PRELOAD_FILE_NAME}
    # Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    # Login To Ecomp Portal
    # Log To Console    Login Success    
    # launch Application and Validate   SDNGC-Admin-Portal
    # Log To Console    Application Launched    
    # Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
# #    log list  ${files1}
    # Log To Console    Updating the Preload details     
# #    Update the Network Preload Details    mgmt_net.xlsm    ${NETWORK_NAME}
# #    Get the Network Preload Details    mgmt_net.xlsm    ${NETWORK_NAME}
    # Log To Console    Updated the Preload    
# #    Set Global Variable    ${vnf}      vCOM
    # Log To Console    Executing the Network Preload Upload        
    # Network preload upload    @{NETWORK_PRELOAD_FILE_NAME}
    
TC#03_Network Spinup

     ${NumModelsCount}    Evaluate                                                   ${NETWORK_COUNT_${VNF_TYPE}}+1
     :FOR                 ${netItr}                                                  IN RANGE        1            ${NumModelsCount}
     \                    log to console                                             netItr is ${netItr}
#     \                    Log To Console                                             A&AI Validation
     \        Login To Ecomp Portal 
     \   Launch Application and Validate    VID 
     \    #${CUSTOMER_NAME}    ${service_instance_id}    Create VID Service Instance      ServiceWith_CONTRIAL30_641972     #${SERVICE_NAME}
     \    #####passing service name currently in VID network creation. but originally UUID was supposed to be passed. But it works 
     \   ${network_details}   VID_RESOURCE.VID Network Creation    ${serviceNameNetwork${netItr}}    ${NETWORK_NAME_SDNC_${SDN_VNF}${netItr}}    ${netItr}         #${SERVICE_NAME}    ${NETWORK_NAME} 
     \   Log To Console    ******Executed keyword : VID Network Creation ****** 
     \     Log To Console    Network Details : ${network_details}

    
     # ${Instance Details}    VID_RESOURCE.Create VID Service Instance    ${SERVICE_NAME}
     # ${Service Instance Name}       Get from List    ${Instance Details}    0
     # ${Service Instance ID}         Get from List    ${Instance Details}    1 
     # ${network_details}             VID_RESOURCE.Create VID Network     ${Service Instance ID}   ${NETWORK_NAME_FROM_PRELOAD} 
     # common find replace    replacing network details     ${EXECDIR}\\robot\\testsuites\\NC_Driver_LOGS.robot    ${network_details${netItr}} [${SPACE}a-zA-Z://0-9.//,-_]*   ${network_details${netItr}}${SPACE}${SPACE}${SPACE} ${network_details} 
    
     AIC Validations for network    @{AIC_NETWORK_NAME}    #Testing pending for this keyword
    
TC#04_ASDC_VNF_Model_Creation
    
    ${vlm_name}    ${la_name}        ${fg_name}        Create New License Model              
    log to console    value of vlm is ${vlm_name}
    log to console    value of la is ${la_name}
    Set suite variable    ${vlm_name}    ${vlm_name}
    Set suite variable    ${la_name}    ${la_name}
    Set suite variable    ${fg_name}    ${fg_name}
    log to console    value of vlm_name is ${vlm_name}
    
    
    ${vsp_name}           Create New Vendor Software Product - Heatfile     ${vlm_name}    ${la_name}     ${fg_name}
#    ${vsp_name}           Create New Vendor Software Product - Heatfile     RA_VLM_11f6d5    RA_LA_11f6d5     RA_FG_11f6d5
    Log To Console    *******Executed the keyword : Create New Vendor Software Product - Heatfile*****    
    Log To Console        VSP Name: ${vsp_name}
    Set Suite Variable    	${vsp_name}        ${vsp_name}
     
      
    ${vf_name}    Import VF    ${vsp_name}
   

    Log To Console    ******Executed the keyword : Import VF*****    
    Log To Console    ${vf_name}
    
#    Import VF    <<{vsp_name}>>
    
    
    ${VNF_SERVICE_NAME}=    Create New Service    ${vf_name}
    Log To Console    ******Executed the keyword : Create New Service*****    
    Log To Console    ${VNF_SERVICE_NAME}    
    
	Change User Role        TESTER

    Log to Console    Change the role to TESTER. Waiting for 15sec
    Sleep    15
    Test Service    ${VNF_SERVICE_NAME}
    
    Change User Role        GOVERNOR
    Log to Console    Change the role to GOVERNOR. Waiting for 15sec
    Sleep    15

    Approve Service    ${VNF_SERVICE_NAME}
    Change User Role        OPS

    Log to Console    Change the role to OPS. Waiting for 15sec
    Sleep    15
    
     @{VNF_SERVICE_DISTRIBUTION_DETAILS}    Distribute Service    ${VNF_SERVICE_NAME}
     Log To Console    First Param: @{VNF_SERVICE_DISTRIBUTION_DETAILS}[0]
     Log To Console     Second Param: @{VNF_SERVICE_DISTRIBUTION_DETAILS}[1]    
    
    Change User Role      DESIGNER
     Log to Console    Change the role to DESIGNER. Waiting for 15sec
    Sleep    15
     Find Replace       ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     [\\$\\{]*VNF_SERVICE_DISTRIBUTION_DATA_01[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VNF_SERVICE_DISTRIBUTION_DATA_01\} ${SPACE}${SPACE}${SPACE} @{VNF_SERVICE_DISTRIBUTION_DETAILS}[0]    

TC#05_VNF_Preload_Upload
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

TC#06_VNF_Spin_up
        #New *********************************************************
#    [Arguments]    ${SERVICE_NAME} 
    Log To Console    ****** Execution Starting for TC - TC#06_VNF Spin up **********************
#    ${VNF_SERVICE_DISTRIBUTION_DATA_01}    Set Variable    ${PAR_VNF_SERVICE_DISTRIBUTION_DATA_01}
  
    # Run Keyword If    "${PAR_VNF_SERVICE_DISTRIBUTION_DATA_01}"!="NA"   Run Keywords 
    # ...    Log to Console    Received Parameter for VNF_SERVICE_DISTRIBUTION_DATA_01
    # ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*VNF_SERVICE_DISTRIBUTION_DATA_01[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VNF_SERVICE_DISTRIBUTION_DATA_01\} ${SPACE}${SPACE}${SPACE} ${PAR_VNF_SERVICE_DISTRIBUTION_DATA_01}        
    # ...    AND    Pass Execution    Parameters - VNF_SERVICE_DISTRIBUTION_DATA_01 - updated Successfully    
    # Log To Console    Parameter was not received. Executing TC#06_VNF Spin up.
    
    #New ***********************************************************************
     
     Login To Ecomp Portal
     Launch Application and Validate    VID
    ${VNF_SERVICE_INSTANCE_ID}    ${VNF_ID}    ${VNF_NAME}    ${VNF_TYPE}    VID_RESOURCE.VID VNF Creation       ${SERVICE_NAME}  
#     ${VNF_DETAILS}    VID VNF Creation       b6e450b1-1911-4f39-bf44-ec2a156577c6
     Log To Console    ${VNF_SERVICE_INSTANCE_ID} - ${VNF_ID} - ${VNF_NAME} - ${VNF_TYPE}  
     Find Replace       ${EXECDIR}\\robot\\testsuites\\resources\\NC\\NC_Driver_MOBTADM.robot      [\\$\\{]*VNF_SERVICE_INSTANCE_ID[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VNF_SERVICE_INSTANCE_ID\} ${SPACE}${SPACE}${SPACE} ${VNF_SERVICE_INSTANCE_ID}
     #
TC_07_Add_Base_and_Add-on_VF_Module
          #New *********************************************************
    
#    Log To Console    ****** Execution Starting for TC - TC_08_Add_Base_and_Add-on_VF_Module **********************
#    ${VNF_SERVICE_INSTANCE_ID}    Set Variable    ${PAR_VNF_SERVICE_INSTANCE_ID}
  
#    Run Keyword If    "${PAR_VNF_SERVICE_INSTANCE_ID}"!="NA"   Run Keywords 
#    ...    Log to Console    Received Parameter for VNF_SERVICE_INSTANCE_ID
#    ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*VNF_SERVICE_INSTANCE_ID[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VNF_SERVICE_INSTANCE_ID\} ${SPACE}${SPACE}${SPACE} ${PAR_VNF_SERVICE_INSTANCE_ID}        
    # ...    AND    Pass Execution    Parameters - VNF_SERVICE_DISTRIBUTION_DATA_01 - updated Successfully    
    # Log To Console    Parameter was not received. Executing TC#06_VNF Spin up.
    
    #New ***********************************************************************
    

    Login To Ecomp Portal
    Launch Application and Validate    VID
    ${VF_MODULE_ID}    VID_RESOURCE.Create VID BASE VF module    ${VNF_SERVICE_INSTANCE_ID}    ${PRELOAD_TYPE}    ${PRELOAD_FILE_NAME}
    Log To Console    Name of {VF_MODULE_ID} is ${VF_MODULE_ID}
#    Find Replace        ${EXECDIR}\\robot\\testsuites\\resources\\NC\\NC_Driver_MOBTADM.robot      [\\$\\{]*VF_MODULE_ID[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VF_MODULE_ID\} ${SPACE}${SPACE}${SPACE} ${VF_MODULE_ID}
    Close Browser
   
    # Run Keyword If    "${PAR_VID_ADDON_VF_MODULE}"!="NA"   Pass Execution    Add Base VF Module Executed. Received the parameter for AddOn Module hence it will be skipped.    
     Login To Ecomp Portal
     Launch Application and Validate    VID
     ${VF_MODULE_ID}     VID_RESOURCE.Create VID AddOn VF module    ${VNF_SERVICE_INSTANCE_ID}      ${NUMBER_OF_ADDON_VF_MODULE}    ${PRELOAD_TYPE}    ${PRELOAD_FILE_NAME}
     Log To Console    Name of {VF_MODULE_ID} is ${VF_MODULE_ID} 
    

*** Keywords ***
Create New Service Network Test - Contrial 30 Basic
        ${service_name_SRIOV_Run}   Create New Service Network Test    ${NETWORK_COUNT_${VNF_TYPE}}
        delete checkout items
        Change User Role for testing        TESTER
        Test Service    ${service_name_SRIOV_Run}    
        #Test The Service  1  vnf  ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing        GOVERNOR
        Approve Service    ${service_name_SRIOV_Run}
        #Approve The Service  1  vnf   ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing    OPS
        Distribute Service    ${service_name_SRIOV_Run}
        #Distribute The Service    1  vnf   ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing    DESIGNER 
        [Return]    ${service_name_SRIOV_Run}
        
SRIOV Model Creation
       ${service_name_SRIOV_Run}   Create New Service Network model flow
        delete checkout items
        Change User Role for testing        TESTER
        Test Service    ${service_name_SRIOV_Run}    
        #Test The Service  1  vnf  ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing        GOVERNOR
        Approve Service    ${service_name_SRIOV_Run}
        #Approve The Service  1  vnf   ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing    OPS
        Distribute Service    ${service_name_SRIOV_Run}
        #Distribute The Service    1  vnf   ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing    DESIGNER 
        [Return]    ${service_name_SRIOV_Run}
OVS Model Creation 
       ${service_name_OVS_Run}   Create New OAM Network model flow
        delete checkout items
        Change User Role for testing        TESTER
        Test Service    ${service_name_OVS_Run}    
        #Test The Service  1  vnf  ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing        GOVERNOR
        Approve Service    ${service_name_OVS_Run}
        #Approve The Service  1  vnf   ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing    OPS
        Distribute Service    ${service_name_OVS_Run}
        #Distribute The Service    1  vnf   ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing    DESIGNER 
        [Return]    ${service_name_OVS_Run}        
        
L3 NW Model Creation
       ${service_name_SRIOV_Run}   Create L3 Service Network model flow
        delete checkout items
        Change User Role for testing        TESTER
        Test The Service  1  vnf  ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing        GOVERNOR
        Approve The Service  1  vnf   ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing    OPS
        Distribute The Service    1  vnf   ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing    DESIGNER 
         [Return]   ${service_name_SRIOV_Run} 

AAI Tenant Validations
    Run A&AI Get Request    AAI_RESOURCE_ENDPOINT_PATH    AAI_RESOURCE_ID

Network_Preload_Upload_keyword
    [Arguments]    @{NETWORK_FILENAME}
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
#    Set Global Variable    ${vnf}      vCOM
    Log To Console    Executing the Network Preload Upload        
    Network preload upload    @{NETWORK_FILENAME}


ASDC_VNF_Model_Creation
    
    ${vlm_name}    ${la_name}        ${fg_name}        Create New License Model              
    log to console    value of vlm is ${vlm_name}
    log to console    value of la is ${la_name}
    Set suite variable    ${vlm_name}    ${vlm_name}
    Set suite variable    ${la_name}    ${la_name}
    Set suite variable    ${fg_name}    ${fg_name}
    log to console    value of vlm_name is ${vlm_name}
    
    
    ${vsp_name}           Create New Vendor Software Product - Heatfile     ${vlm_name}    ${la_name}     ${fg_name}
#    ${vsp_name}           Create New Vendor Software Product - Heatfile     RA_VLM_11f6d5    RA_LA_11f6d5     RA_FG_11f6d5
    Log To Console    *******Executed the keyword : Create New Vendor Software Product - Heatfile*****    
    Log To Console        VSP Name: ${vsp_name}
    Set Suite Variable    	${vsp_name}        ${vsp_name}
     
      
    ${vf_name}    Import VF    ${vsp_name}
   

    Log To Console    ******Executed the keyword : Import VF*****    
    Log To Console    ${vf_name}
    
#    Import VF    <<{vsp_name}>>
    
    
    ${VNF_SERVICE_NAME}=    Create New Service    ${vf_name}
    Log To Console    ******Executed the keyword : Create New Service*****    
    Log To Console    ${VNF_SERVICE_NAME}    
    
	Change User Role        TESTER

    Log to Console    Change the role to TESTER. Waiting for 15sec
    Sleep    15
    Test Service    ${VNF_SERVICE_NAME}
    
    Change User Role        GOVERNOR
    Log to Console    Change the role to GOVERNOR. Waiting for 15sec
    Sleep    15

    Approve Service    ${VNF_SERVICE_NAME}
    Change User Role        OPS

    Log to Console    Change the role to OPS. Waiting for 15sec
    Sleep    15
    
     @{VNF_SERVICE_DISTRIBUTION_DETAILS}    Distribute Service    ${VNF_SERVICE_NAME}
     Log To Console    First Param: @{VNF_SERVICE_DISTRIBUTION_DETAILS}[0]
     Log To Console     Second Param: @{VNF_SERVICE_DISTRIBUTION_DETAILS}[1]    
    
    Change User Role      DESIGNER
     Log to Console    Change the role to DESIGNER. Waiting for 15sec
    Sleep    15
     Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*VNF_SERVICE_DISTRIBUTION_DATA_01[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VNF_SERVICE_DISTRIBUTION_DATA_01\} ${SPACE}${SPACE}${SPACE} @{VNF_SERVICE_DISTRIBUTION_DETAILS}[0]    
    [Return]    ${VNF_SERVICE_NAME}

VNF_Preload_Upload
    [Arguments]    ${VNF_PRELOAD_FILE}
       
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    Login To Ecomp Portal
    launch Application and Validate   SDNGC-Admin-Portal
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
   
    ${TEST_STATUS}    SDNC Preload upload       ${VNF_PRELOAD_FILE}
    Run Keyword If    "${TEST_STATUS}"!="True"    Fail    Error while trying to upload the VNF Preload Upload. Please check.
    

VNF_Spin_up
        #New *********************************************************
    [Arguments]    ${SERVICE_NAME} 
    Log To Console    ****** Execution Starting for TC - TC#06_VNF Spin up **********************
#    ${VNF_SERVICE_DISTRIBUTION_DATA_01}    Set Variable    ${PAR_VNF_SERVICE_DISTRIBUTION_DATA_01}
  
    # Run Keyword If    "${PAR_VNF_SERVICE_DISTRIBUTION_DATA_01}"!="NA"   Run Keywords 
    # ...    Log to Console    Received Parameter for VNF_SERVICE_DISTRIBUTION_DATA_01
    # ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*VNF_SERVICE_DISTRIBUTION_DATA_01[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VNF_SERVICE_DISTRIBUTION_DATA_01\} ${SPACE}${SPACE}${SPACE} ${PAR_VNF_SERVICE_DISTRIBUTION_DATA_01}        
    # ...    AND    Pass Execution    Parameters - VNF_SERVICE_DISTRIBUTION_DATA_01 - updated Successfully    
    # Log To Console    Parameter was not received. Executing TC#06_VNF Spin up.
    
    #New ***********************************************************************
     
     Login To Ecomp Portal
     Launch Application and Validate    VID
    ${VNF_SERVICE_INSTANCE_ID}    ${VNF_ID}    ${VNF_NAME}    ${VNF_TYPE}    VID_RESOURCE.VID VNF Creation       ${SERVICE_NAME}  
#     ${VNF_DETAILS}    VID VNF Creation       b6e450b1-1911-4f39-bf44-ec2a156577c6
     Log To Console    ${VNF_SERVICE_INSTANCE_ID} - ${VNF_ID} - ${VNF_NAME} - ${VNF_TYPE}  
#     Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*VNF_SERVICE_INSTANCE_ID[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VNF_SERVICE_INSTANCE_ID\} ${SPACE}${SPACE}${SPACE} ${VNF_SERVICE_INSTANCE_ID}
     [Return]    ${VNF_SERVICE_INSTANCE_ID}  ${VNF_ID}   ${VNF_NAME}  ${VNF_TYPE}


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

Delete Network and Service Instance
    [Arguments]    ${SERVICE_INSTANCE_ID}
    Delete Network    ${SERVICE_INSTANCE_ID}
    Delete Service Instance    ${SERVICE_INSTANCE_ID}
    Close Browser

Delete VNF and Service Instance
    [Arguments]    ${SERVICE_INSTANCE_ID}
    Delete VNF    ${SERVICE_INSTANCE_ID}
    Delete Service Instance    ${SERVICE_INSTANCE_ID}
    Close Browser

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

NC SRIOV_L3
    [Documentation]    Adding parameters to support integration
    [Arguments]    ${ServiceInstanceID}
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
