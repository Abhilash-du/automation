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
Resource            ../resources/VNF_Spinup.robot
Resource            Driver_ASDC.robot
Resource            ../resources/vid/VID_RESOURCE.robot

Library  callReporter    
Library    SeleniumLibrary 
Library    restartModule    

*** Variables ***
#${NETWORK_SERVICE_NAME}    
${EXCEL_NAME}    mgmt_vrar_net_95.xlsm
#${NETWORK_NAME}    APP-C-24595-T-IST-05A_vcom_mngt_01
${files}           mgmt_vrar_net_95.xlsm      #GRP-27529-T-SIL-13B_MGMT_VISBC0_net_11.xlsm   GRP-27529-T-SIL-13B_TRST_VISBC0_net_11.xlsm  GRP-27529-T-SIL-13B_UNTR_VISBC0_net_11.xlsm
#${test}    Default
@{files1}         mgmt_net.xlsm      #GRP-27529-T-SIL-13B_TRST_VISBC0_net_11.xlsm   #GRP-27529-T-SIL-13B_UNTR_VISBC0_net_11.xlsm   #GRP-27529-T-SIL-13B_MGMT_VISBC0_net_11.xlsm   GRP-27529-T-SIL-13B_TRST_VISBC0_net_11.xlsm

   

${PAR_SERVICE_NAME}    NA    #Default_Value_ServiceName    
${PAR_NETWORK_NAME}     NA   #Default_Value_NetworkName
${PAR_VNF_SERVICE_DISTRIBUTION_DATA_01}    NA        #Default_Value_VNF_SERVICE_DISTRIBUTION
${PAR_VNF_SERVICE_INSTANCE_ID}    NA    #Default_Value_VNF_SERVICE_DISTRUBUTION
${PAR_VID_ADDON_VF_MODULE}    NA    


*** Test Cases ***
TC_00_01
    [Tags]    TP1
   
    #   Log To Console    TC1: Value of Variable - ${test}
    ${test}=    Set Variable    updated
    Log To Console    TC1:updated Value of Variable - ${test}
    #    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*SERVICE_NAME[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{SERVICE_NAME\} ${SPACE}${SPACE}${SPACE}YES
     Log To Console    ${EXECDIR}${/}robot${/}assets${/}SDC${/}heatfiles${/}HeatTemplate.zip        
   
TC_00_02
    [Tags]    TP
    Log To Console    TC2
    ${SERVICE_NAME}    Set Variable    ${PAR_SERVICE_NAME}
    Run Keyword If    "${PAR_SERVICE_NAME}"!="NA"    Run Keywords 
    ...    Log to Console    Received Parameter for SERVICE NAME
    ...    AND    Find Replace       ${EXECDIR}\\..\\resources\\VNF_Spinup.robot     [\\$\\{]*SERVICE_NAME[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{SERVICE_NAME\} ${SPACE}${SPACE}${SPACE} ${PAR_SERVICE_NAME}   #${ASDC_VCOM_SERVICE_NAME}${SPACE}${SPACE}${SPACE}${SPACE}SERVICE_NAME_001
    ...    AND    Pass Execution    Parameter - SERVICE_NAME - updated Successfully    
    Log To Console    Parameter was not received. Executing ASDC Service Create.    
   #   "${EXECDIR}\\robot\\resources\\VNF_Spinup.robot"

TC#01_ASDC_Network_Model_Creation
    
    #New*********************************************
    # Log To Console    ****** Execution Starting for TC - TC#01_ASDC_Network Model Creation **********************
    # #    ${NETWORK_SERVICE_NAME}    Set Variable    ${PAR_SERVICE_NAME}
    # Run Keyword If    "${PAR_SERVICE_NAME}"!="NA"    Run Keywords
    # ...    Log to Console    Received Parameter for SERVICE NAME
    # ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*NETWORK_SERVICE_NAME[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_SERVICE_NAME\} ${SPACE}${SPACE}${SPACE} ${PAR_SERVICE_NAME}   #${ASDC_VCOM_SERVICE_NAME}${SPACE}${SPACE}${SPACE}${SPACE}SERVICE_NAME_001
    # ...    AND    Pass Execution    Parameter - SERVICE_NAME - updated Successfully
    # Log To Console    Parameter was not received. Executing ASDC Service Create.
    #New*********************************************
    
    #    ${USERNAME} =    Common Get Username
    # Run Keyword And Return Status    Change User Role        DESIGNER
    # clear checkout items
    # Close Browser
    
    # ${NETWORK_SERVICE_NAME}=      Create New Service Network model - CONTRIAL_30_Basic     # Network Model - Component from Ginger
    # Log To Console    *******Name of Service is : ${NETWORK_SERVICE_NAME}
    
    # Change User Role        TESTER

    # Log to Console    Change the role to TESTER. Waiting for 15sec
    # Sleep    15
    # Test Service    ${NETWORK_SERVICE_NAME}
    
    # Change User Role        GOVERNOR
    # Log to Console    Change the role to GOVERNER. Waiting for 15sec
    # Sleep    15

    # Approve Service    ${NETWORK_SERVICE_NAME}
    # Change User Role        OPS

    # Log to Console    Change the role to OPS. Waiting for 15sec
    # Sleep    15
    
    # @{NETWORK_SERVICE_DISTRIBUTION_DETAILS}    Distribute Service    ${NETWORK_SERVICE_NAME}
     # Log To Console    First Param: @{NETWORK_SERVICE_DISTRIBUTION_DETAILS}[0]
     # Log To Console     Second Param: @{NETWORK_SERVICE_DISTRIBUTION_DETAILS}[1]
    
    # Change User Role        DESIGNER
     # Log to Console    Change the role to DESIGNER. Waiting for 15sec
    # Sleep    15
     
     # Find Replace       ${EXECDIR}\\robot\\resources\\vid\\VID_DATA.robot    [\\$\\{]*vRAR_net_1_UUID[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{vRAR_net_1_UUID\} ${SPACE}${SPACE}${SPACE} ${NETWORK_SERVICE_NAME}
     # Find Replace       ${EXECDIR}\\robot\\resources\\vid\\VID_DATA.robot      [\\$\\{]*vRAR_net_1_UUID[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{vRAR_net_1_UUID\} ${SPACE}${SPACE}${SPACE} @{NETWORK_SERVICE_DISTRIBUTION_DETAILS}[0]
     # Find Replace       ${EXECDIR}\\robot\\resources\\vid\\VID_DATA.robot      [\\$\\{]*vRAR_net_1_INVARIANT_UUID[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{vRAR_net_1_INVARIANT_UUID\} ${SPACE}${SPACE}${SPACE} @{NETWORK_SERVICE_DISTRIBUTION_DETAILS}[1]
     
     
      common find replace    replacing flexware vfc    ${EXECDIR}\\robot\\resources\\vid\\VID_DATA.robot     GLOBAL_VNF}[${SPACE}a-zA-Z://0-9.-_]*   GLOBAL_VNF}${SPACE}${SPACE}${SPACE} vRAR
      common find replace    replacing flexware vfc    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     SCN}[${SPACE}a-zA-Z://0-9.-_]*   SCN}${SPACE}${SPACE}${SPACE} vRAR
    common find replace    replacing flexware vfc    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     NumModels}[${SPACE}a-zA-Z://0-9.-_]*   NumModels}${SPACE}${SPACE}${SPACE} 1
     
     ${NumModelsCount}    Evaluate    ${NumModels}+1    
  :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
  \    log to console  netItr is ${netItr}
  \    change User Role for testing    DESIGNER
     
  \  ${serviceNameNetwork}  Create New Service Network Test   ${netItr}
  \   Wait Until Keyword Succeeds    5  5x        clear checkout items 
  \  Change User Role for testing        TESTER
  \    log to console  service name passed is ${serviceNameNetwork}
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
    
    #New *********************************************************
    
    Log To Console    ****** Execution Starting for TC - TC#03_NW Spin Up **********************
    # ${NETWORK_SERVICE_NAME}    Set Variable    ${PAR_SERVICE_NAME}
    # ${NETWORK_NAME}    Set Variable    ${PAR_NETWORK_NAME}
   # Run Keyword If    "${PAR_SERVICE_NAME}"!="NA" or "${PAR_NETWORK_NAME}"!="NA"    Run Keywords
    # ...    Log to Console    Received Parameter for SERVICE NAME and NETWORK ROLE
    # ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*NETWORK_SERVICE_NAME[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_SERVICE_NAME\} ${SPACE}${SPACE}${SPACE} ${PAR_SERVICE_NAME}
    # ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*NETWORK_NAME[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_NAME\} ${SPACE}${SPACE}${SPACE} ${PAR_NETWORK_NAME}
    #    ...    AND    Pass Execution    Parameters - SERVICE_NAME and NETWORK_ROLE - updated Successfully
    #    Log To Console    Parameter was not received. Executing TC#03_NW Spin Up.
    
    #New ***********************************************************************
    
    
    # Login To Ecomp Portal
    # Launch Application and Validate    VID
    # #${CUSTOMER_NAME}    ${service_instance_id}    Create VID Service Instance      ServiceWith_CONTRIAL30_641972     #${SERVICE_NAME}
    # ${NETWORK_DETAILS}    VID Network Creation    ${NETWORK_SERVICE_NAME}    ${NETWORK_NAME}
    # Log To Console    ******Executed keyword : VID Network Creation ******
    
    # #    ${network_details}             Create VID Network     4bc9e467-cece-435e-a65f-bb4bfac3e075   ${NETWORK_NAME}

    # #    Log To Console    Customer Name : ${CUSTOMER_NAME}
    # #    Log To Console    Service Instance ID : ${service_instance_id}
    # Log To Console    Network Details : ${NETWORK_DETAILS}
    
    # Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*NETWORK_DETAILS[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*    \$\{NETWORK_DETAILS\} ${SPACE}${SPACE}${SPACE} ${NETWORK_DETAILS}
     common find replace    replacing flexware vfc    ${EXECDIR}\\robot\\resources\\vid\\VID_DATA.robot     GLOBAL_VNF}[${SPACE}a-zA-Z://0-9.-_]*   GLOBAL_VNF}${SPACE}${SPACE}${SPACE} vRAR
    Network Creation    Net_1
    
    
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
    
	Change User Role        TESTER

    Log to Console    Change the role to TESTER. Waiting for 15sec
    Sleep    15
    Test Service    ${VNF_SERVICE_NAME}
    
    Change User Role        GOVERNOR
    Log to Console    Change the role to GOVERNER. Waiting for 15sec
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
    common find replace       replacing uuid       ${EXECDIR}\\robot\\resources\\vid\\VID_DATA.robot      ${GLOBAL_VNF}_vnf_UUID}[${SPACE}a-zA-Z://0-9.//,-_]*      ${GLOBAL_VNF}_vnf_UUID}${SPACE}${SPACE}${SPACE} @{VNF_SERVICE_DISTRIBUTION_DETAILS}[0]
    common find replace   replacing iuuid     ${EXECDIR}\\robot\\resources\\vid\\VID_DATA.robot    ${GLOBAL_VNF}_vnf_INVARIANT_UUID}[${SPACE}a-zA-Z://0-9.//,-_]*         ${GLOBAL_VNF}_vnfINVARIANT_UUID}${SPACE}${SPACE}${SPACE} @{VNF_SERVICE_DISTRIBUTION_DETAILS}[0]
    #sleep                                20s
TC#05_VNF_Preload_Upload
    
       
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    Login To Ecomp Portal
    launch Application and Validate   SDNGC-Admin-Portal
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
    #    log list  ${files1}

    #    Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type}
    #        Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    SDC_RA_SVC_542141/RA_VSP_707679 0
    #    Get the VNF Preload Details    ${ExcelName}     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type}
    
    Set Global Variable    ${vnf}      vRAR    
    ${TEST_STATUS}    SDNC Preload upload       vRARnf.xlsm     #${files1}
    Run Keyword If    "${TEST_STATUS}"!="True"    Fail    Error while trying to upload the VNF Preload Upload. Please check.
    #Close Browser
TC#06_VNF_Spin_up
        #New *********************************************************
    
    Log To Console    ****** Execution Starting for TC - TC_08_Add_Base_and_Add-on_VF_Module **********************
    #    ${VNF_SERVICE_INSTANCE_ID}    Set Variable    ${PAR_VNF_SERVICE_INSTANCE_ID}
  
    Run Keyword If    "${PAR_VNF_SERVICE_INSTANCE_ID}"!="NA"   Run Keywords 
    ...    Log to Console    Received Parameter for VNF_SERVICE_INSTANCE_ID
    ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*VNF_SERVICE_INSTANCE_ID[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VNF_SERVICE_INSTANCE_ID\} ${SPACE}${SPACE}${SPACE} ${PAR_VNF_SERVICE_INSTANCE_ID}        
    # ...    AND    Pass Execution    Parameters - VNF_SERVICE_DISTRIBUTION_DATA_01 - updated Successfully
    # Log To Console    Parameter was not received. Executing TC#06_VNF Spin up.
    
    #New ***********************************************************************
    

    Login To Ecomp Portal
    Launch Application and Validate    VID
    Create VID VNF    vnf

TC_08_Add_Base_and_Add-on_VF_Module
          #New *********************************************************
    
    Log To Console    ****** Execution Starting for TC - TC_08_Add_Base_and_Add-on_VF_Module **********************
    #    ${VNF_SERVICE_INSTANCE_ID}    Set Variable    ${PAR_VNF_SERVICE_INSTANCE_ID}
  
    Run Keyword If    "${PAR_VNF_SERVICE_INSTANCE_ID}"!="NA"   Run Keywords 
    ...    Log to Console    Received Parameter for VNF_SERVICE_INSTANCE_ID
    ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*VNF_SERVICE_INSTANCE_ID[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VNF_SERVICE_INSTANCE_ID\} ${SPACE}${SPACE}${SPACE} ${PAR_VNF_SERVICE_INSTANCE_ID}        
    # ...    AND    Pass Execution    Parameters - VNF_SERVICE_DISTRIBUTION_DATA_01 - updated Successfully
    # Log To Console    Parameter was not received. Executing TC#06_VNF Spin up.
    
    #New ***********************************************************************
    

    Login To Ecomp Portal
    Launch Application and Validate    VID
    Create VID VNF    vnf
    