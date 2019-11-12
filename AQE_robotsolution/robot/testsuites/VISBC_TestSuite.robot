*** Settings ***
Library 	        SeleniumLibrary
Library             OperatingSystem
Library             Collections
Library             String
Library 	        RequestsLibrary
Library	            UUID 
Library             XML    
# Library             Excel    
# Library             ExcelLibrary    
Library             Screenshot 
Library             Process  
Library             BuiltIn  
# Library             Replace      
#Library            ConvertCSV   
# Library             MultileFileUpload       
Library             testScreenshot  
Library            ConvertToCSV  
Resource            ../resources/vid/VID_RESOURCE.robot
Resource            ../resources/vid/vid_data.robot
Resource            ../resources/portal/PORTAL_RESOURCE.robot
Resource            ../resources/global_properties.robot
Resource            ../resources/browser_setup.robot

Resource             ${EXECDIR}${/}robot${/}resources${/}SDC${/}SDC_DATA.robot
Resource            ../resources/vid/VID_RESOURCE.robot
Resource            ../resources/portal/PORTAL_RESOURCE.robot
Resource            ../resources/aai/AAI_RESOURCE.robot
Resource            ../resources/sdnc_portal/SDNC_PORTAL_RESOURCE.robot
Resource            ../resources/CLAMP/CLAMP_RESOURCE.robot
Resource            Driver_Policy.robot
Resource            CLAMP_Regression.robot
Resource            ../resources/commonKeywords.robot
Resource            Driver_ASDC.robot
Resource            aai_testsuite.robot     

Library    restartModule


*** Variables *** 
@{files1}       GRP_27529_T_SIL_13B_MGMT_VISBC0_net_11.xlsm    GRP_27529_T_SIL_13B_TRST_VISBC0_net_11.xlsm   GRP_27529_T_SIL_13B_UNTR_VISBC0_net_11.xlsm
@{vf_preload_files}    updated_visbc_ssa_b_trial.xlsm      updated_visbc_ssa_a_trial.xlsm        updated_visbc_rtp_trial.xlsm
*** Test Cases ***
update variable
    restartModule.Find Replace    ${EXECDIR}\\robot\\resources\\vid\\VID_DATA.robot    GLOBAL_VNF}[${SPACE}a-zA-Z://0-9.//,-_]*    GLOBAL_VNF}${SPACE}${SPACE}${SPACE} VISBC 

Upload network preload
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    Login To Ecomp Portal
    launch Application and Validate   SDNGC-Admin-Portal
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
    log list  ${files1} 
    Set Global Variable    ${vnf}      VISBC    
    Network preload upload    ${files1}

Network Creation of VISBC net1
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER }     chrome  
    Set Global Variable  ${GLOBAL_VNF}        VISBC   
    # Network Creation    mgmt

Network Creation of VISBC net2
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER }     chrome  
    Set Global Variable   ${GLOBAL_VNF}        VISBC   
    # Network Creation    Trusted
    
Network Creation of VISBC net3
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER }     chrome  
    Set Global Variable  ${GLOBAL_VNF}        VISBC   
    # Network Creation    untrusted
VNF preload upload
    set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    Login To Ecomp Portal
    launch Application and Validate   SDNGC-Admin-Portal
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
    log list  ${files1} 
    Set Global Variable    ${vnf}      VISBC  
    VF Preload upload    ${vf_preload_files}

VNF Creation of VISBC
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER }     chrome  
    Set Global Variable   ${GLOBAL_VNF}        VISBC
    VNF Creation    vnf


VISBC Add Base VF Module
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER }     chrome
    Add Base VF Module     vnf
    