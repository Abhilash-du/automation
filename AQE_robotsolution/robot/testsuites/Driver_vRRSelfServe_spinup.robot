*** Settings ***
   
Library    SeleniumLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library	      UUID      
Library	      Screenshot
Library       DateTime  
#Resource  ../resources/mso/MSO_OR.robot
#Resource  ../resources/mso/MSO.robot
Resource    ../resources/mso/MSO_RESOURCE.robot 
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
#${REQUEST_ID}                                           f6403496-ccfb-4426-b245-ba40f1c034bc 

*** Test Cases ***       
TC#01_ASDC_OAM_Network_Model_Creation
       ${service_name_OAM_Run}   Create New OAM Network model flow
        delete checkout items
        Change User Role for testing        TESTER
        Test The Service  1  vnf  ${service_name_OAM}   ${service_name_OAM_Run}
        Change User Role for testing        GOVERNOR
        Approve The Service  1  vnf   ${service_name_OAM}  ${service_name_OAM_Run}
        Change User Role for testing    OPS
        Distribute The Service    1  vnf   ${service_name_OAM}   ${service_name_OAM_Run}
        Change User Role for testing    DESIGNER  

TC#02_ASDC_SRIOV_Network_Model_Creation
        ${service_name_SRIOV_Run}   Create New Service Network model flow
        delete checkout items
        Change User Role for testing        TESTER
        Test The Service  1  vnf  ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing        GOVERNOR
        Approve The Service  1  vnf   ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing    OPS
        Distribute The Service    1  vnf   ${service_name_SRIOV}   ${service_name_SRIOV_Run}
        Change User Role for testing    DESIGNER     
  


TC#03_OAM_NW_Spin_Up
      Log To Console    ${MSO_VNF} Flow Started  
      Set Global Variable    ${GLOBAL_SELENIUM_BROWSER }     chrome  
      MSO Oam Network Creation
SDNC Validation for OAM
    SDNC Oam Network Validation

TC#04_SRIOV_NW_Spin_Up
       Set Global Variable    ${GLOBAL_SELENIUM_BROWSER }     chrome  
       MSO Sriov Network Creation
SDNC Validation for SRIOV
    SDNC Sriov Network Validation
TC#05_ASDC_VNF_Model_Creation
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
    common find replace   replacing uuid    ${EXECDIR}\\robot\\resources\\mso\\MSO_DATA.robot   ${MSO_VNF}_vnf_UUID}[${SPACE}}a-zA-Z://0-9.//,-_]*   ${MSO_VNF}_vnf_UUID}${SPACE}${SPACE}${SPACE} @{SERVICE_DISTRIBUTION_DETAILS}[0]
    common find replace   replacing iuuid  ${EXECDIR}\\robot\\resources\\mso\\MSO_DATA.robot   ${MSO_VNF}_vnf_INVARIANT_UUID}[${SPACE}a-zA-Z://0-9.//,-_]*   ${MSO_VNF}_vnf_INVARIANT_UUID}${SPACE}${SPACE}${SPACE} @{SERVICE_DISTRIBUTION_DETAILS}[1]  
#    Change User Role    ${USERNAME}    DESIGNER
     Log to Console    Change the role to DESIGNER. Waiting for 15sec
    Sleep    15
AIC Validation for Networks
    AIC Validations for network

TC#06_VNF_Spinup
         Set Global Variable    ${GLOBAL_SELENIUM_BROWSER }     chrome 
         ${REQUEST_ID}  VNF Spinup of VRR
         Set Global Variable       ${REQUEST_ID}

Camunda Validation
         Camunda validation for Macro flow     ${REQUEST_ID}
AIC Validation for VNF
    AIC Validations for VNF