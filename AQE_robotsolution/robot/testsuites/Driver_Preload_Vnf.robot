*** settings ***
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
Resource            CLAMP_Regression.robot
Resource            ../resources/commonKeywords.robot
Resource            Driver_ASDC.robot
Resource            aai_testsuite.robot
Library             callReporter
Library             testScreenshot
Library             testLib
Library             ../../properties/global_properties.py

Library             SeleniumLibrary
Test Setup          Authentication
Test Teardown       Copy Logs       ${EXECDIR}    ${SUITE NAME}





*** Variables ***
${test}
#${service_name_Run}
${value2}   2

${service_name_Run2}  
${EXCEL_NAME}    mgmt_vcom_net_95.xlsm
${NETWORK_NAME}    APP-C-24595-T-IST-05A-COM-TOAM0_net_99
${files}           mgmt_vcom_net_95.xlsm      #GRP-27529-T-SIL-13B_MGMT_VISBC0_net_11.xlsm   GRP-27529-T-SIL-13B_TRST_VISBC0_net_11.xlsm  GRP-27529-T-SIL-13B_UNTR_VISBC0_net_11.xlsm


*** Test Cases ***
EIPAM DATA retrieve
    log to console   retrieve data
    #retrieve data from EIPAM

Network Model creation
  ${NumModelsCount}    Evaluate    ${NumModels}+1    
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
  \  Change User Role for testing    DESIGNER
Test Network Preload upload
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
Network Spinup

     ${NumModelsCount}    Evaluate                                                   ${NumModels}+1
     :FOR                 ${netItr}                                                  IN RANGE        1            ${NumModelsCount}
     \                    log to console                                             netItr is ${netItr}
     \                    Log To Console                                             A&AI Validation
     \        Login To Ecomp Portal 
     \   Launch Application and Validate    VID 
     \    #${CUSTOMER_NAME}    ${service_instance_id}    Create VID Service Instance      ServiceWith_CONTRIAL30_641972     #${SERVICE_NAME}
     \    #####passing service name currently in VID network creation. but originally UUID was supposed to be passed. But it works 
     \   ${network_details}    VID Network Creation    ${serviceNameNetwork${netItr}}    ${NETWORK_NAME_SDNC_${SDN_VNF}${netItr}}    ${netItr}     #${SERVICE_NAME}    ${NETWORK_NAME} 
     \   Log To Console    ******Executed keyword : VID Network Creation ****** 
     \     Log To Console    Network Details : ${network_details}

####################################################################################

      
Preload Automation Creation
      delete checkout items
      Change User Role for testing     DESIGNER
       Create New License Model Preload
       Create New VSP - HeatFile Preload
       ${VfPreload1}   Import The VF Preload
   ${service_name_RunPreload}   Create New Service Test Preload   ${VfPreload1}
    Set Global Variable    ${service_name_Run_Preload}   ${service_name_RunPreload}
       log to console   test value of service run is ${service_name_Run_Preload}
        Change User Role for testing        TESTER
        Test The Service  1  vnf  ${service_name_Preload}   ${service_name_Run_Preload}
        Change User Role for testing        GOVERNOR
        Approve The Service  1  vnf   ${service_name_Preload}   ${service_name_Run_Preload}
        Change User Role for testing    OPS
        Distribute The Service    1  vnf   ${service_name_Preload}   ${service_name_Run_Preload}
        Change User Role for testing    DESIGNER 	         
            
VNF Spinup
    
             Login To Ecomp Portal 
        Launch Application and Validate    VID 
        #####passing service name currently in VID network creation. but originally UUID was supposed to be passed. But it works 
       ${vnf_details}     VID VNF Creation    ${UUIDVnf}     #${SERVICE_NAME}    ${NETWORK_NAME} 
        Log To Console    ******Executed keyword : VID Network Creation ****** 
          Log To Console    Network Details : ${vnf_details}     #VID VNF Creation
          Set Global Variable    ${vnf_detailsFinal_${GLOBAL_VNF}}  ${vnf_details}    
VNF base module 
    @{file_names}  OperatingSystem.List Files In Directory  ${PATH_TO_VF_PRELOAD_EXCELS} 
    Create VID BASE VF module   ${vnf_detailsFinal_${GLOBAL_VNF}}  manual  @{file_names}
    Create VID AddOn VF module   ${vnf_detailsFinal_${GLOBAL_VNF}}  3  manual   @{file_names} 
   Fetch VID AddOn VF module Details     ${vnf_detailsFinal_${GLOBAL_VNF}}   3
                                       
