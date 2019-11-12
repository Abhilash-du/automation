*** Settings ***
Library 	        SeleniumLibrary
Library             OperatingSystem
Library             Collections
Library             String
Library 	        RequestsLibrary
Library	            UUID 
# Library             XML    
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
Resource      ../resources/mso/MSO_RESOURCE.robot  
Resource    ../resources/sdnc_portal/SDNC_PORTAL_RESOURCE.robot
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

*** Variables *** 
@{files1}       GRP_27529_T_SIL_13B_MGMT_VISBC0_net_11.xlsm    GRP_27529_T_SIL_13B_TRST_VISBC0_net_11.xlsm   GRP_27529_T_SIL_13B_UNTR_VISBC0_net_11.xlsm
#@${net_current_no}        1
*** Test Cases ***

Upload network preload
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER}      firefox
    Login To Ecomp Portal
    launch Application and Validate   SDNGC-Admin-Portal
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
    log list  ${files1} 
    Set Global Variable    ${vnf}      VLMSP    
    Network preload upload    ${files1}

Network Creation of VLMSP net1
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER }     firefox
    Set Global Variable    ${net_current_no}       1     
    # :FOR    ${net_current_no}  IN RANGE  ${No_of_networks}
    # \    Network Creation    net_${net_current_no} 
    
VNF Creation of VLMSP
     Set Global Variable    ${GLOBAL_SELENIUM_BROWSER }     firefox  
     Set Global Variable   ${GLOBAL_VNF}        VLMSP
     VNF Creation    vnf