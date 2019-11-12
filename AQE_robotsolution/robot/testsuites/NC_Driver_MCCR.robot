*** Settings ***
Resource         ../resources/vid/VID_RESOURCE.robot
Resource         ../resources/NC/input_keywords.robot
Resource         ../resources/NC/input_keywords.robot
Resource         ../resources/vid/vid_data.robot
Resource         ../resources/portal/PORTAL_RESOURCE.robot
Resource         ../resources/global_properties.robot
Resource         ../resources/browser_setup.robot
Resource         ../resources/SDC/SDC_RESOURCE.robot
#Resource        ../resources/SDC/SDC_DATA.robot
Resource         ../resources/vid/VID_RESOURCE.robot
Resource         ../resources/Network_VID/NetworkCloud_Execution.robot
Resource         ../resources/portal/PORTAL_RESOURCE.robot
Resource         ../resources/aai/AAI_RESOURCE.robot
Resource         ../resources/sdnc_portal/SDNC_PORTAL_RESOURCE.robot
Resource         ../resources/CLAMP/CLAMP_RESOURCE.robot
Resource         ../resources/NC/NC_RESOURCE.robot
Resource         Driver_Policy.robot
Resource         ../resources/commonKeywords.robot
Resource         Driver_ASDC.robot
Resource         aai_testsuite.robot

Library          callReporter
Library          testScreenshot
Library          testLib
#Library          ../../properties/global_properties.py
Library          SeleniumLibrary
Library          RequestsLibrary
Resource        ../resources/vid/vid_interface.robot
Resource        ../resources/POLO/POLO_RESOURCE.robot
Resource        ../resources/POLO/POLO_DATA.robot  
Resource        ../resources/POLO/POLO_OR.robot 
Library         Process
Resource        Driver_ASDC.robot


#Test Setup       Authentication
Test Teardown    Copy Logs    ${EXECDIR}    ${SUITE NAME}

*** Variables ***
${VNF}  FRWL




*** Test Cases ***




   # TC#01_Tenant_Network Model creation
 
	# Log To Console    Creation of Tenant Network Model as  Prerequiste and its data upload in Narad 
 Test
     
   Test1
   Test2 
     
    #File Test  


TC#01_POLO_TNP_Flow 
     [Documentation]    POLO Tenant Security , Tenant VRF and Tenant Network Addition 
    
     #POLO Assign Activate remains
     
     Login to POLO
    
    #Update Complex Id , Region Id , Zone Id In POLO_DATA Sheet 
     1-Search Location
     
     #Update Group Addon Before Running
     Log To Console    In Service Update Tenant Security 
     ADD Tenant Security
     
     #Update Group Addon, Region Id and VRF Name Before Running
     Log To Console    In Service Update Tenant VRF
     ADD Tenant VRF
    
     #Update Group Addon Network Instance Name in POLO_DATA
     Log To Console    In Service Update Tenant Network
     Add Tenant Network
     
TC#02_OVS_Network_Model_Creation
    
    Log To Console    Creating OVS Model     
    Change User Role for testing     DESIGNER
     Set Global Variable   ${SCN}   ${VNF}  
  ${NumModelsCount}    Evaluate    ${NumModels_OVS_${SCN}}+1 
  :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
       \   ${service_name_OVS_Run}   Create New Service OVS Network model flow  ${netItr} 
       \    Set Global Variable    ${service_name_OVS}  ${service_name_OVS_Run}    
       \   delete checkout items
       \   Change User Role for testing        TESTER
       \   Test The Service OVS  ${netItr}  network  ${service_name_OVS}  ${service_name_OVS_Run}
       \   Change User Role for testing        GOVERNOR
       \  Approve The Service OVS  ${netItr}  network   ${service_name_OVS}  ${service_name_OVS_Run}
       \   Change User Role for testing    OPS
       \   Distribute The Service oVS  ${netItr}  network   ${service_name_OVS}  ${service_name_OVS_Run}
       \  Change User Role for testing    DESIGNER 
    
    
TC#03_SRIOV_Network_Model_Creation     
        
    Log To Console    Creating SRIOV Model    
         Set Global Variable   ${SCN}   ${VNF}  
    ${NumModelsCount}    Evaluate    ${NumModels_SRIOV_${SCN}}+1 
  :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
   \    ${service_name_SRIOV_Run}   Create New Service Network model flow   ${netItr}
   \     delete checkout items
   \     Change User Role for testing        TESTER
   \     Test The Service SRIOV  ${netItr}  network  ${service_name_SRIOV}   ${service_name_SRIOV_Run}
   \     Change User Role for testing        GOVERNOR
   \     Approve The Service SRIOV  ${netItr}  network   ${service_name_SRIOV}   ${service_name_SRIOV_Run}
   \     Change User Role for testing    OPS
   \     Distribute The Service SRIOV    ${netItr}  network   ${service_name_SRIOV}   ${service_name_SRIOV_Run}
   \     Change User Role for testing    DESIGNER 
    
    
TC#04_Network_Preload_upload 
    
    # Below command would read the file names from the files kept under Folder assets->sdncportal->ManualPreloadFiles->PreloadExcels->VNFName
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
	      
TC#05_OVS_Network_SpinUp
  
    Log To Console    Creating OVS Network  
    
     ${NumModelsCount}    Evaluate    ${NumModels_OVS_${SCN}}+1 
     :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
       
   \     Ovs Network Spinup     ${UUIDFinal_OVS_${SCN}_${netItr}}   


TC#06_SRIOV_Network_SpinUp
  
    Log To Console    Creating OVS Network 
        ${NumModelsCount}    Evaluate    ${NumModels_SRIOV_${SCN}}+1 
        :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
    
     \    Sriov Network Spinup     ${UUIDFinal_SRIOV_${SCN}_${netItr}} 
    
TC#07_AAI_NCValidation-Network-Stack_NCValidation
  
    Log To Console    Network Validation
    
    #Need to add in loop for all network Validation 
   ${STATUS_1}    ${RESPONSE_1}    A&AI Common GET Request - For NC   <<Enter Network ID ; get from VID>>
    Run Keyword If    "${STATUS_1}"=="True"    Log To Console    Network Validation Passed
    Run Keyword If    "${STATUS_1}"!="True"    Log To Console    Network Validation Failed. - Error Code = ${RESPONSE_1.status_code     
        

    
    Log To Console    Network Validation on Stack  
    AIC Validations for network    
    
     
    
TC#08_VNF_Model_Creation
    
   Log To Console    VNF Model Creation 
   
   
    [Documentation]
   ...    in test the service, approve the service and distribute the service, two parameters are passed.
   ...    first is ${netItr} which represents to the number of iterations to be run. secing one is either 
   ...    vnf or network depending upon the type of modal you are trying to create
   # ...    for vnf enter type as vnf and for network enter network
      Set Global Variable   ${SCN}   ${VNF}     
     delete checkout items
     Change User Role for testing     DESIGNER
      Create New License Model Fabric    ${VNF} 
     Create New VSP - HeatFile Fabric   ${VNF} 
    Import The VF Complex Fabric   ${VNF} 
   ${service_name_Run2}    Create New Service Fabric   ${VNF} 
    
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
   

TC#09_VNF_Preload_Upload
    
  
    @{file_names}  OperatingSystem.List Files In Directory  ${PATH_TO_VF_PRELOAD_EXCELS} 
    
    Log To Console    VNF Preload Upload  
    
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
   
TC#10_VNF_Spinup-CamundaValidation-VLAN_ID_ValidationinNARAD 
    
   Log To Console    VNF Model Creation   
    

TC#11_AAI_VNF-VF_Validation_StackNCValidation    
    
   Log To Console    VF and VNF Validation AAI and Stack 
     
 
TC#12_Deletionof_VNFComponents  
    
    Log To Console    Deletion of VNF Components   
