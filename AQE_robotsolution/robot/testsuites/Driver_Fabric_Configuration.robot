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
##Resource            CLAMP_Regression.robot
Resource            ../resources/commonKeywords.robot
Resource            Driver_ASDC.robot
#Resource            aai_testsuite.robot
Library             callReporter
Library             testScreenshot
Library             testLib
#Library             ../../properties/global_properties.py

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


*** Test Cases ***


vnf model Creation Fabric
   [Documentation]
   ...    in test the service, approve the service and distribute the service, two parameters are passed.
   ...    first is ${netItr} which represents to the number of iterations to be run. secing one is either 
   ...    vnf or network depending upon the type of modal you are trying to create
   # ...    for vnf enter type as vnf and for network enter network
    # delete checkout items
    #Change User Role for testing     DESIGNER
      #Create New License Model Fabric    FNCR
    # Create New VSP - HeatFile Fabric   FNCR
    Import The VF Complex Fabric   FNCR
   ${service_name_Run2}    Create New Service Fabric   FNCR
    
    log to console   test value of service run is ${service_name_Run}
   
   Set Global Variable  ${service_name_Run2}  ${service_name_Run} 
    log to console   test value of service run2 is ${service_name_Run2}    
     delete checkout items
    Change User Role for testing     TESTER
    Test The Service                 1           vnf    ${Service_Name}  ${service_name_Run2} 
    Change User Role for testing     GOVERNOR
    Approve The Service              1           vnf    ${Service_Name}   ${service_name_Run2}
    Change User Role for testing     OPS
    Distribute The Service           1           vnf    ${Service_Name}   ${service_name_Run2} 
    Change User Role for testing     DESIGNER
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
