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
Resource            ../resources/VNF_Spinup_vVM.robot



*** Variables ***
#${NETWORK_SERVICE_NAME_N1}    
#${NETWORK_SERVICE_NAME_N2}  
#${NETWORK_SERVICE_NAME_N3}  
#${EXCEL_NAME}    mgmt_vmog_net_07.xlsm
#${NETWORK_NAME}    APP-C-24595-T-IST-05A_vcom_mngt_01
#${files}           mgmt_vmog_net_07.xlsm      #GRP-27529-T-SIL-13B_MGMT_VISBC0_net_11.xlsm   GRP-27529-T-SIL-13B_TRST_VISBC0_net_11.xlsm  GRP-27529-T-SIL-13B_UNTR_VISBC0_net_11.xlsm
#${test}    Default
@{NW_PRELOAD_FILES_1}         N1.xlsm      #GRP-27529-T-SIL-13B_TRST_VISBC0_net_11.xlsm   #GRP-27529-T-SIL-13B_UNTR_VISBC0_net_11.xlsm   #GRP-27529-T-SIL-13B_MGMT_VISBC0_net_11.xlsm   GRP-27529-T-SIL-13B_TRST_VISBC0_net_11.xlsm
@{NW_PRELOAD_FILES_2}         N1.xlsm   


@{VNF_PRELOAD_FILES_1}         N1.xlsm
@{VNF_PRELOAD_FILES_2}         N1.xlsm
@{VNF_PRELOAD_FILES_3}        N1
@{VNF_PRELOAD_FILES_4}    
@{VNF_PRELOAD_FILES_5}    
@{VNF_PRELOAD_FILES_6}    
@{VNF_PRELOAD_FILES_7}                            
@{VNF_PRELOAD_FILES_base}    

   

${PAR_SERVICE_NAME}    NA    #Default_Value_ServiceName    
${PAR_NETWORK_NAME}     NA   #Default_Value_NetworkName
${PAR_VNF_SERVICE_DISTRIBUTION_DATA_01}    NA        #Default_Value_VNF_SERVICE_DISTRIBUTION
${PAR_VNF_SERVICE_INSTANCE_ID}    NA    #Default_Value_VNF_SERVICE_DISTRUBUTION
${PAR_VID_ADDON_VF_MODULE}    NA    


*** Test Cases ***


TC#01_ASDC_Network_Model_Creation_vVM_01
    
    #New*********************************************
    # Log To Console    ****** Execution Starting for TC - TC#01_ASDC_Network Model Creation **********************
# #    ${NETWORK_SERVICE_NAME_N1}    Set Variable    ${PAR_SERVICE_NAME}
    # Run Keyword If    "${PAR_SERVICE_NAME}"!="NA"    Run Keywords 
    # ...    Log to Console    Received Parameter for SERVICE NAME
    # ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*NETWORK_SERVICE_NAME_N1[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_SERVICE_NAME_N1\} ${SPACE}${SPACE}${SPACE} ${PAR_SERVICE_NAME}   #${ASDC_vMog_SERVICE_NAME_SERVICE_NAME}${SPACE}${SPACE}${SPACE}${SPACE}SERVICE_NAME_001
    # ...    AND    Pass Execution    Parameter - SERVICE_NAME - updated Successfully    
    # Log To Console    Parameter was not received. Executing ASDC Service Create.
    #New*********************************************
    
#    ${USERNAME} =    Common Get Username
    Run Keyword And Return Status    Change User Role        DESIGNER
    clear checkout items
    Close Browser
    
    ${NETWORK_SERVICE_NAME_N1}=      Create New Service Network model - CONTRIAL_30_Basic     # Network Model - Component from Ginger
    Log To Console    *******Name of Service is : ${NETWORK_SERVICE_NAME_N1}
    
    Change User Role        TESTER

    Log to Console    Change the role to TESTER. Waiting for 15sec
    Sleep    15
    Test Service    ${NETWORK_SERVICE_NAME_N1}
    
    Change User Role        GOVERNOR
    Log to Console    Change the role to GOVERNER. Waiting for 15sec
    Sleep    15

    Approve Service    ${NETWORK_SERVICE_NAME_N1}
    Change User Role        OPS

    Log to Console    Change the role to OPS. Waiting for 15sec
    Sleep    15
    
    @{NETWORK_SERVICE_DISTRIBUTION_DETAILS_01}    Distribute Service    ${NETWORK_SERVICE_NAME_N1}
     Log To Console    First Param: @{NETWORK_SERVICE_DISTRIBUTION_DETAILS_01}[0]
     Log To Console     Second Param: @{NETWORK_SERVICE_DISTRIBUTION_DETAILS_01}[1]    
    
    Change User Role        DESIGNER
     Log to Console    Change the role to DESIGNER. Waiting for 15sec
    Sleep    15
     
     Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vVM.robot     [\\$\\{]*NETWORK_SERVICE_NAME_N1[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_SERVICE_NAME_N1\} ${SPACE}${SPACE}${SPACE} ${NETWORK_SERVICE_NAME_N1}
    
     Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vVM.robot     [\\$\\{]*NETWORK_SERVICE_DISTRIBUTION_DATA_01[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_SERVICE_DISTRIBUTION_DATA_01\} ${SPACE}${SPACE}${SPACE} @{NETWORK_SERVICE_DISTRIBUTION_DETAILS_01}[0]
    
#	 Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*NETWORK_SERVICE_DISTRIBUTION_DATA_02[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_SERVICE_DISTRIBUTION_DATA_02\} ${SPACE}${SPACE}${SPACE} @{NETWORK_SERVICE_DISTRIBUTION_DETAILS_01}[1]
     
   
TC#02_Network_Preload_Upload_vVM_01
    
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
    Set Global Variable    ${vnf}      vVM
    Log To Console    Executing the Network Preload Upload        
    Network preload upload    @{NW_PRELOAD_FILES_1}

TC#03_NW_Spin_Up_vVM_01
    
    #New *********************************************************
    
    Log To Console    ****** Execution Starting for TC - TC#03_NW Spin Up **********************
    # ${NETWORK_SERVICE_NAME}    Set Variable    ${PAR_SERVICE_NAME}
    # ${NETWORK_NAME}    Set Variable    ${PAR_NETWORK_NAME}
    Run Keyword If    "${PAR_SERVICE_NAME}"!="NA" or "${PAR_NETWORK_NAME}"!="NA"    Run Keywords 
    ...    Log to Console    Received Parameter for SERVICE NAME and NETWORK ROLE
    ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vVM.robot     [\\$\\{]*NETWORK_SERVICE_NAME_N1[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_SERVICE_NAME_N1\} ${SPACE}${SPACE}${SPACE} ${PAR_SERVICE_NAME}
    ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vVM.robot     [\\$\\{]*NETWORK_NAME_FIRST[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_NAME_FIRST\} ${SPACE}${SPACE}${SPACE} ${PAR_NETWORK_NAME}          
#    ...    AND    Pass Execution    Parameters - SERVICE_NAME and NETWORK_ROLE - updated Successfully    
#    Log To Console    Parameter was not received. Executing TC#03_NW Spin Up.
    
    #New ***********************************************************************
    
    
    Login To Ecomp Portal
    Launch Application and Validate    VID
    #${CUSTOMER_NAME}    ${service_instance_id}    Create VID Service Instance      ServiceWith_CONTRIAL30_641972     #${SERVICE_NAME} 
    ${NETWORK_DETAILS_01}    VID Network Creation    ${NETWORK_SERVICE_NAME_N1}    ${NETWORK_NAME_FIRST}
    Log To Console    ******Executed keyword : VID Network Creation ******
    
#    ${network_details}             Create VID Network     4bc9e467-cece-435e-a65f-bb4bfac3e075   ${NETWORK_NAME_FIRST} 

#    Log To Console    Customer Name : ${CUSTOMER_NAME}
#    Log To Console    Service Instance ID : ${service_instance_id}
    Log To Console    Network Details : ${NETWORK_DETAILS_01}
    
    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vVM.robot     [\\$\\{]*NETWORK_DETAILS_01[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_DETAILS_01\} ${SPACE}${SPACE}${SPACE} ${NETWORK_DETAILS_01}
    

TC#04_ASDC_Network_Model_Creation_vVM_02
    
    
#    ${USERNAME} =    Common Get Username
    Run Keyword And Return Status    Change User Role        DESIGNER
    clear checkout items
    Close Browser
    
    ${NETWORK_SERVICE_NAME_N2}=      Create New Service Network model - CONTRIAL_30_Basic     # Network Model - Component from Ginger
    Log To Console    *******Name of Service is : ${NETWORK_SERVICE_NAME_N2}
    
    Change User Role        TESTER

    Log to Console    Change the role to TESTER. Waiting for 15sec
    Sleep    15
    Test Service    ${NETWORK_SERVICE_NAME_N2}
    
    Change User Role        GOVERNOR
    Log to Console    Change the role to GOVERNER. Waiting for 15sec
    Sleep    15

    Approve Service    ${NETWORK_SERVICE_NAME_N2}
    Change User Role        OPS

    Log to Console    Change the role to OPS. Waiting for 15sec
    Sleep    15
    
    @{NETWORK_SERVICE_DISTRIBUTION_DETAILS_02}    Distribute Service    ${NETWORK_SERVICE_NAME_N2}
     Log To Console    First Param: @{NETWORK_SERVICE_DISTRIBUTION_DETAILS_02}[0]
     Log To Console     Second Param: @{NETWORK_SERVICE_DISTRIBUTION_DETAILS_02}[1]    
    
    Change User Role        DESIGNER
     Log to Console    Change the role to DESIGNER. Waiting for 15sec
    Sleep    15
     
     Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vVM.robot     [\\$\\{]*NETWORK_SERVICE_NAME_N2[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_SERVICE_NAME_N2\} ${SPACE}${SPACE}${SPACE} ${NETWORK_SERVICE_NAME_N2}
                                                                                                                         
	 Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vVM.robot     [\\$\\{]*NETWORK_SERVICE_DISTRIBUTION_DATA_03[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_SERVICE_DISTRIBUTION_DATA_03\} ${SPACE}${SPACE}${SPACE} @{NETWORK_SERVICE_DISTRIBUTION_DETAILS_02}[0]
     
#	 Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vMOG.robot     [\\$\\{]*NETWORK_SERVICE_DISTRIBUTION_DATA_04[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_SERVICE_DISTRIBUTION_DATA_04\} ${SPACE}${SPACE}${SPACE} @{NETWORK_SERVICE_DISTRIBUTION_DETAILS_02}[1]
     
   
TC#05_Network_Preload_Upload_vVM_02
    
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
    Set Global Variable    ${vnf}      vVM
        Log To Console    Executing the Network Preload Upload        
    Network preload upload    @{NW_PRELOAD_FILES_2}

TC#06_NW_Spin_Up_vVM_02
    
    #New *********************************************************
    
    Log To Console    ****** Execution Starting for TC - TC#06_NW Spin Up **********************
    # ${NETWORK_SERVICE_NAME}    Set Variable    ${PAR_SERVICE_NAME}
    # ${NETWORK_NAME}    Set Variable    ${PAR_NETWORK_NAME}
    Run Keyword If    "${PAR_SERVICE_NAME}"!="NA" or "${PAR_NETWORK_NAME}"!="NA"    Run Keywords 
    ...    Log to Console    Received Parameter for SERVICE NAME and NETWORK ROLE
    ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vVM.robot     [\\$\\{]*NETWORK_SERVICE_NAME_N2[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_SERVICE_NAME_N2\} ${SPACE}${SPACE}${SPACE} ${PAR_SERVICE_NAME}
    ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vVM.robot     [\\$\\{]*NETWORK_NAME_SECOND[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_NAME_SECOND\} ${SPACE}${SPACE}${SPACE} ${PAR_NETWORK_NAME}          
#    ...    AND    Pass Execution    Parameters - SERVICE_NAME and NETWORK_ROLE - updated Successfully    
#    Log To Console    Parameter was not received. Executing TC#03_NW Spin Up.
    
    #New ***********************************************************************
    
    
    Login To Ecomp Portal
    Launch Application and Validate    VID
  
  
  #${CUSTOMER_NAME}    ${service_instance_id}    Create VID Service Instance      ServiceWith_CONTRIAL30_641972     #${SERVICE_NAME} 
    ${NETWORK_DETAILS_02}    VID Network Creation    ${NETWORK_SERVICE_NAME_N2}    ${NETWORK_NAME_SECOND}
    Log To Console    ******Executed keyword : VID Network Creation ******
    

    Log To Console    Network Details : ${NETWORK_DETAILS_02}
    
    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vVM.robot     [\\$\\{]*NETWORK_DETAILS_02[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{NETWORK_DETAILS_02\} ${SPACE}${SPACE}${SPACE} ${NETWORK_DETAILS_02}
  
#END****************************************************************
   
    
#************************vnfmodelcreationstart*********************
    
TC#07_ASDC_VNF_Model_Creation_vVM
    
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
     Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vVM.robot     [\\$\\{]*VNF_SERVICE_DISTRIBUTION_DATA_01[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VNF_SERVICE_DISTRIBUTION_DATA_01\} ${SPACE}${SPACE}${SPACE} @{VNF_SERVICE_DISTRIBUTION_DETAILS}[0]    

TC#08_VNF_Preload_Upload_vVM_and_addON
    
     Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    Login To Ecomp Portal
    launch Application and Validate   SDNGC-Admin-Portal
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
#    log list  ${files1} 

#    Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type}
#        Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    SDC_RA_SVC_542141/RA_VSP_707679 0
#    Get the VNF Preload Details    ${ExcelName}     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type} 
    
    Set Global Variable    ${vnf}      vVM    
    ${TEST_STATUS}    SDNC Preload upload          ${VNF_PRELOAD_FILES_BASE}
    Run Keyword If    "${TEST_STATUS}"!="True"    Fail    Error while trying to upload the VNF Preload Upload. Please check.
    #Close Browser
	#END****************************************************************
	
    
       
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    Login To Ecomp Portal
    launch Application and Validate   SDNGC-Admin-Portal
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
#    log list  ${files1} 

#    Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type}
#        Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    SDC_RA_SVC_542141/RA_VSP_707679 0
#    Get the VNF Preload Details    ${ExcelName}     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type} 
    
    Set Global Variable    ${vnf}      vVM    
    ${TEST_STATUS}    SDNC Preload upload          ${VNF_PRELOAD_FILES_1}
    Run Keyword If    "${TEST_STATUS}"!="True"    Fail    Error while trying to upload the VNF Preload Upload. Please check.
    #Close Browser
	
	
	 Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    Login To Ecomp Portal
    launch Application and Validate   SDNGC-Admin-Portal
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
#    log list  ${files1} 

#    Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type}
#        Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    SDC_RA_SVC_542141/RA_VSP_707679 0
#    Get the VNF Preload Details    ${ExcelName}     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type} 
    
    Set Global Variable    ${vnf}      vVM    
    ${TEST_STATUS}    SDNC Preload upload          ${VNF_PRELOAD_FILES_2}
    Run Keyword If    "${TEST_STATUS}"!="True"    Fail    Error while trying to upload the VNF Preload Upload. Please check.
    #Close Browser
    
	
	 Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    Login To Ecomp Portal
    launch Application and Validate   SDNGC-Admin-Portal
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
#    log list  ${files1} 

#    Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type}
#        Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    SDC_RA_SVC_542141/RA_VSP_707679 0
#    Get the VNF Preload Details    ${ExcelName}     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type} 
    
    Set Global Variable    ${vnf}      vVM    
    ${TEST_STATUS}    SDNC Preload upload          ${VNF_PRELOAD_FILES_3}
    Run Keyword If    "${TEST_STATUS}"!="True"    Fail    Error while trying to upload the VNF Preload Upload. Please check.
    #Close Browser
	#END****************************************************************
	
	 Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    Login To Ecomp Portal
    launch Application and Validate   SDNGC-Admin-Portal
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
#    log list  ${files1} 

#    Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type}
#        Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    SDC_RA_SVC_542141/RA_VSP_707679 0
#    Get the VNF Preload Details    ${ExcelName}     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type} 
    
    Set Global Variable    ${vnf}      vVM    
    ${TEST_STATUS}    SDNC Preload upload          ${VNF_PRELOAD_FILES_4}
    Run Keyword If    "${TEST_STATUS}"!="True"    Fail    Error while trying to upload the VNF Preload Upload. Please check.
    #Close Browser
	#END****************************************************************
	
	 Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    Login To Ecomp Portal
    launch Application and Validate   SDNGC-Admin-Portal
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
#    log list  ${files1} 

#    Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type}
#        Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    SDC_RA_SVC_542141/RA_VSP_707679 0
#    Get the VNF Preload Details    ${ExcelName}     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type} 
    
    Set Global Variable    ${vnf}      vVM    
    ${TEST_STATUS}    SDNC Preload upload          ${VNF_PRELOAD_FILES_5}
    Run Keyword If    "${TEST_STATUS}"!="True"    Fail    Error while trying to upload the VNF Preload Upload. Please check.
    #Close Browser
	#END****************************************************************
	
	 Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    Login To Ecomp Portal
    launch Application and Validate   SDNGC-Admin-Portal
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
#    log list  ${files1} 

#    Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type}
#        Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    SDC_RA_SVC_542141/RA_VSP_707679 0
#    Get the VNF Preload Details    ${ExcelName}     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type} 
    
    Set Global Variable    ${vnf}      vVM    
    ${TEST_STATUS}    SDNC Preload upload          ${VNF_PRELOAD_FILES_6}
    Run Keyword If    "${TEST_STATUS}"!="True"    Fail    Error while trying to upload the VNF Preload Upload. Please check.
    #Close Browser
	#END****************************************************************
	
	 Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    Login To Ecomp Portal
    launch Application and Validate   SDNGC-Admin-Portal
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
#    log list  ${files1} 

#    Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type}
#        Update the VNF Preload Details    vCOM_vnf.xlsm     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    SDC_RA_SVC_542141/RA_VSP_707679 0
#    Get the VNF Preload Details    ${ExcelName}     ${vf-module-name}    ${vf-Module-model-name}    ${vnf-name}    ${vnf-type} 
    
    Set Global Variable    ${vnf}      vVM    
    ${TEST_STATUS}    SDNC Preload upload          ${VNF_PRELOAD_FILES_7}
    Run Keyword If    "${TEST_STATUS}"!="True"    Fail    Error while trying to upload the VNF Preload Upload. Please check.
    #Close Browser
	#END****************************************************************
	
	
	
	
TC#09_VNF_Spin_up_vVM
    
        #New *********************************************************
    
    Log To Console    ****** Execution Starting for TC - TC#15_VNF Spin up **********************
#    ${VNF_SERVICE_DISTRIBUTION_DATA_01}    Set Variable    ${PAR_VNF_SERVICE_DISTRIBUTION_DATA_01}
  
    Run Keyword If    "${PAR_VNF_SERVICE_DISTRIBUTION_DATA_01}"!="NA"   Run Keywords 
    ...    Log to Console    Received Parameter for VNF_SERVICE_DISTRIBUTION_DATA_01
    ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vVM.robot     [\\$\\{]*VNF_SERVICE_DISTRIBUTION_DATA_01[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VNF_SERVICE_DISTRIBUTION_DATA_01\} ${SPACE}${SPACE}${SPACE} ${PAR_VNF_SERVICE_DISTRIBUTION_DATA_01}        
    # ...    AND    Pass Execution    Parameters - VNF_SERVICE_DISTRIBUTION_DATA_01 - updated Successfully    
    # Log To Console    Parameter was not received. Executing TC#06_VNF Spin up.

       #END****************************************************************  
 
     Login To Ecomp Portal
     Launch Application and Validate    VID
    ${VNF_SERVICE_INSTANCE_ID}    ${VNF_ID}    ${VNF_NAME}    ${VNF_TYPE}    VID VNF Creation       ${VNF_SERVICE_DISTRIBUTION_DATA_01} 
#     ${VNF_DETAILS}    VID VNF Creation       b6e450b1-1911-4f39-bf44-ec2a156577c6
     Log To Console    ${VNF_SERVICE_INSTANCE_ID} - ${VNF_ID} - ${VNF_NAME} - ${VNF_TYPE}  
     Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vVM.robot     [\\$\\{]*VNF_DETAILS[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VNF_DETAILS\} ${SPACE}${SPACE}${SPACE} ${VNF_SERVICE_INSTANCE_ID}
     

     
TC_10_Add_Base_and_Add-on_VF_Module_vVM
          #New *********************************************************
    
    Log To Console    ****** Execution Starting for TC - TC_08_Add_Base_and_Add-on_VF_Module **********************
	
	
#    ${VNF_SERVICE_INSTANCE_ID}    Set Variable    ${PAR_VNF_SERVICE_INSTANCE_ID}
  
    Run Keyword If    "${PAR_VNF_SERVICE_INSTANCE_ID}"!="NA"   Run Keywords 
    ...    Log to Console    Received Parameter for VNF_SERVICE_INSTANCE_ID
    ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vVM.robot     [\\$\\{]*VNF_SERVICE_INSTANCE_ID[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VNF_SERVICE_INSTANCE_ID\} ${SPACE}${SPACE}${SPACE} ${PAR_VNF_SERVICE_INSTANCE_ID}        
    # ...    AND    Pass Execution    Parameters - VNF_SERVICE_DISTRIBUTION_DATA_01 - updated Successfully    
    # Log To Console    Parameter was not received. Executing TC#06_VNF Spin up.
    
    #New ***********************************************************************
    

    Login To Ecomp Portal
    Launch Application and Validate    VID
    ${VF_MODULE_ID_BASE}    Create VID BASE VF module    ${VNF_SERVICE_INSTANCE_ID}    ${PRELOAD_TYPE}    ${PRELOAD_FILE_NAME}
    Log To Console    Name of {VF_MODULE_ID_BASE} is ${VF_MODULE_ID_BASE}
    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup_vVM.robot     [\\$\\{]*VF_MODULE_ID_BASE[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VF_MODULE_ID\} ${SPACE}${SPACE}${SPACE} ${VF_MODULE_ID_BASE}
   
   
    Run Keyword If    "${PAR_VID_ADDON_VF_MODULE}"!="NA"   Pass Execution    Add Base VF Module Executed. Received the parameter for AddOn Module hence it will be skipped.    
    
    ${VF_MODULE_ID_1}     Create VID AddOn VF module    ${VNF_SERVICE_INSTANCE_ID}      ${NUMBER_OF_ADDON_VF_MODULE_1}    ${Preload_Type}    ${PRELOAD_FILE_NAME_1}
    Log To Console    Name of {VF_MODULE_ID} is ${VF_MODULE_ID_1}   
  
	    
  #   Run Keyword If    "${PAR_VID_ADDON_VF_MODULE}"!="NA"   Pass Execution    Add Base VF Module Executed. Received the parameter for AddOn Module hence it will be skipped.    
    
    ${VF_MODULE_ID_2}     Create VID AddOn VF module    ${VNF_SERVICE_INSTANCE_ID}      ${NUMBER_OF_ADDON_VF_MODULE_2}    ${Preload_Type}    ${PRELOAD_FILE_NAME_2}
    Log To Console    Name of {VF_MODULE_ID} is ${VF_MODULE_ID_2}     
    


  #   Run Keyword If    "${PAR_VID_ADDON_VF_MODULE}"!="NA"   Pass Execution    Add Base VF Module Executed. Received the parameter for AddOn Module hence it will be skipped.    
    
    ${VF_MODULE_ID_3}     Create VID AddOn VF module    ${VNF_SERVICE_INSTANCE_ID}      ${NUMBER_OF_ADDON_VF_MODULE_3}    ${Preload_Type}    ${PRELOAD_FILE_NAME_3}
    Log To Console    Name of {VF_MODULE_ID} is ${VF_MODULE_ID_3}     
    

  #   Run Keyword If    "${PAR_VID_ADDON_VF_MODULE}"!="NA"   Pass Execution    Add Base VF Module Executed. Received the parameter for AddOn Module hence it will be skipped.    
    
    ${VF_MODULE_ID_4}     Create VID AddOn VF module    ${VNF_SERVICE_INSTANCE_ID}      ${NUMBER_OF_ADDON_VF_MODULE_4}    ${Preload_Type}    ${PRELOAD_FILE_NAME_4}
    Log To Console    Name of {VF_MODULE_ID} is ${VF_MODULE_ID_4}     
    

  #   Run Keyword If    "${PAR_VID_ADDON_VF_MODULE}"!="NA"   Pass Execution    Add Base VF Module Executed. Received the parameter for AddOn Module hence it will be skipped.    
    
    ${VF_MODULE_ID_5}     Create VID AddOn VF module    ${VNF_SERVICE_INSTANCE_ID}      ${NUMBER_OF_ADDON_VF_MODULE_5}    ${Preload_Type}    ${PRELOAD_FILE_NAME_5}
    Log To Console    Name of {VF_MODULE_ID} is ${VF_MODULE_ID_5}     
    

  #   Run Keyword If    "${PAR_VID_ADDON_VF_MODULE}"!="NA"   Pass Execution    Add Base VF Module Executed. Received the parameter for AddOn Module hence it will be skipped.    
    
    ${VF_MODULE_ID_6}     Create VID AddOn VF module    ${VNF_SERVICE_INSTANCE_ID}      ${NUMBER_OF_ADDON_VF_MODULE_6}    ${Preload_Type}    ${PRELOAD_FILE_NAME_6}
    Log To Console    Name of {VF_MODULE_ID} is ${VF_MODULE_ID_6}     
    


  #   Run Keyword If    "${PAR_VID_ADDON_VF_MODULE}"!="NA"   Pass Execution    Add Base VF Module Executed. Received the parameter for AddOn Module hence it will be skipped.    
    
    ${VF_MODULE_ID_7}     Create VID AddOn VF module    ${VNF_SERVICE_INSTANCE_ID}      ${NUMBER_OF_ADDON_VF_MODULE_7}    ${Preload_Type}    ${PRELOAD_FILE_NAME_7}
    Log To Console    Name of {VF_MODULE_ID} is ${VF_MODULE_ID_7}     
    
	
	#END****************************************************************
	
   

TC_15_Delete_VF_VolumeGroup_VNF_Network_vVM
    
	Login To Ecomp Portal             

    