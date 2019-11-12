*** Settings ***
Resource         ../resources/vid/VID_RESOURCE.robot
Resource         ../resources/vid/vid_data.robot
Resource         ../resources/portal/PORTAL_RESOURCE.robot
Resource         ../resources/global_properties.robot
Resource         ../resources/browser_setup.robot
Resource         ../resources/SDC/SDC_RESOURCE.robot
Resource         ../resources/aai/AAI_RESOURCE.robot
Resource         ../resources/sdnc_portal/SDNC_PORTAL_RESOURCE.robot
Resource         ../resources/CLAMP/CLAMP_RESOURCE.robot
Resource         ../resources/NC/NC_RESOURCE.robot
Resource         ../resources/commonKeywords.robot
Resource         Driver_ASDC.robot
Resource        ../resources/POLO/POLO_RESOURCE.robot
Resource        ../resources/POLO/POLO_DATA.robot  
Resource        ../resources/POLO/POLO_OR.robot 
Library          callReporter
Library          testScreenshot
Library          testLib
Library          SeleniumLibrary
Library          RequestsLibrary
Library           Process


*** Variables ***
${VNF}  MCCD




*** Test Cases ***

   
TC#01_POLO_TNP_Flow
     [Documentation]    POLO Tenant Security , Tenant VRF and Tenant Network Addition 
    
     #POLO Assign Activate remains
     
    Login To Ecomp Portal
    Log To Console    Login Success 
    Go to specific Application in Portal Grid     &{APPNames_${GLOBAL_ENVIRONMENT}}[POLO]
    
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
       \   ${service_name_OVS_Run}  Wait Until Keyword Succeeds   3x   2s   Create New Service OVS Network model flow  ${netItr} 
       \    Set Global Variable    ${service_name_OVS_${SCN}_${netItr}}  ${service_name_OVS_Run}    
       \   Wait Until Keyword Succeeds   3x   2s  delete checkout items
       \   Wait Until Keyword Succeeds   3x   2s  Change User Role for testing        TESTER
       \   Wait Until Keyword Succeeds   3x   2s  Test The Service OVS   ${service_name_OVS_${SCN}_${netItr}}
       \   Wait Until Keyword Succeeds   3x   2s  Change User Role for testing        GOVERNOR
       \   Wait Until Keyword Succeeds   3x   2s  Approve The Service OVS   ${service_name_OVS_${SCN}_${netItr}}
       \   Wait Until Keyword Succeeds   3x   2s   Change User Role for testing    OPS
       \   Wait Until Keyword Succeeds   3x   2s   Distribute The Service oVS   ${service_name_OVS_${SCN}_${netItr}}
       \   Wait Until Keyword Succeeds   3x   2s    Change User Role for testing    DESIGNER 
    
TC#03_SRIOV_Network_Model_Creation
        
    Log To Console    Creating SRIOV Model  
    Set Global Variable   ${SCN}   ${VNF}  
    ${NumModelsCount}    Evaluate    ${NumModels_SRIOV_${SCN}}+1 
   :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
    \       ${service_name_SRIOV_Run}    Wait Until Keyword Succeeds   3x   2s  Create New Service Network model SRIOV A La Carte  ${netItr}
    \       Set Global Variable     ${service_name_SRIOV_${SCN}_${netItr}}     ${service_name_SRIOV_Run}
    \        Wait Until Keyword Succeeds   4x   2s   delete checkout items
    \   #     Wait Until Keyword Succeeds   4x   2s   Change User Role for testing        TESTER
   \    Wait Until Keyword Succeeds   4x   2s   Test The Service SRIOV  ${service_name_SRIOV_${SCN}_${netItr}} 
   \     Wait Until Keyword Succeeds   4x   2s  Change User Role for testing        GOVERNOR
   \     Wait Until Keyword Succeeds   4x   2s  Approve The Service SRIOV  ${service_name_SRIOV_${SCN}_${netItr}} 
   \     Wait Until Keyword Succeeds   4x   2s  Change User Role for testing    OPS
   \     Wait Until Keyword Succeeds   4x   2s  Distribute The Service SRIOV    ${service_name_SRIOV_${SCN}_${netItr}} 
   \     Wait Until Keyword Succeeds   4x   2s  Change User Role for testing    DESIGNER 
    
    
TC#04_Network_Preload_upload
    
    # Below command would read the file names from the files kept under Folder assets->sdncportal->ManualPreloadFiles->PreloadExcels->VNFName
    @{file_names}  OperatingSystem.List Files In Directory  ${PATH_TO_NETWORK_PRELOAD_EXCELS}
    
    Login To Ecomp Portal
    Log To Console    Login Success 
    Go to specific Application in Portal Grid     &{APPNames_${GLOBAL_ENVIRONMENT}}[SDNGC]
    Log To Console    Application Launched 
    #Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
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
  
    Log To Console    Creating SRIOV Network 
        ${NumModelsCount}    Evaluate    ${NumModels_SRIOV_${SCN}}+1 
        :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
    
     \    Sriov Network Spinup     ${UUIDFinal_SRIOV_${SCN}_${netItr}} 
    
TC#07_AAI_NCValidation-Network-Stack_NCValidation
  
    Log To Console    Network Validation
    
   
    Network Validations OVS
    Network Validations SRIOV

        

    

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
    Test The Service                  ${Service_Name}  
    Change User Role for testing     GOVERNOR
    Approve The Service               ${Service_Name}  
    Change User Role for testing     OPS
    Distribute The Service            ${Service_Name}  
    Change User Role for testing     DESIGNER
   

TC#09_VNF_Preload_Upload
    set global variable   ${SCN}   MCCD 
     
     
    @{file_names}    OperatingSystem.List Files In Directory    ${PATH_TO_VF_PRELOAD_EXCELS}   
    Wait Until Keyword Succeeds   3x   2s  Login To Ecomp Portal 
    Log To Console    Login Success 
    Wait Until Keyword Succeeds   3x   2s  launch Application and Validate   &{APPNames_${GLOBAL_ENVIRONMENT}}[SDNGC]
    Log To Console    Application Launched 
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')] 
    Log To Console    Updating the Preload details 
    Log To Console    Updated the Preload 
    Log To Console    Executing the VF Preload Upload 

    Wait Until Keyword Succeeds   3x   2s    SDNC Preload upload      @{file_names}

   
TC#10_VNF_Spinup
             Log To Console    VNF SpinUp  
   
             Login To Ecomp Portal
             Go to specific Application in Portal Grid       &{APPNames_${GLOBAL_ENVIRONMENT}}[VID]            
             Create NC Service Instance  ${model_UUID_Fabric_${SCN}}
             Create NC VNF
             Check for Modules
             Click on Deploy button
             Checking Instantiation Status and getting data for Validation
             
TC#11_AAI_VNF-VF_Validation_NARAD_StackNCValidation
    
   Log To Console    VF and VNF Validation AAI , NARAD and Stack 
    
TC#12_Deletion of OVS Network 
   
    
     Log To Console    Deletion of Network OVS
     set global variable   ${SCN}   MCCD
     ${NumModelsCount}    Evaluate    ${NumModels_OVS_${SCN}}+1 
     :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
       \    Wait Until Keyword Succeeds   3x   2s   Login To Ecomp Portal 
       \    Wait Until Keyword Succeeds   3x   2s   Go to specific Application in Portal Grid       &{APPNames_${GLOBAL_ENVIRONMENT}}[VID] 
       \    Wait Until Keyword Succeeds   3x   2s   Delete Network NC OVS   ${created_service_Instance_ID_${SCN}_NETWORK_${netItr}}    ${netitr}
TC#13_Deletion of SRIOV Network 
   
     #To be Enhanced
     Log To Console    Deletion of Network SRIOV
     set global variable   ${SCN}   MCCD
     ${NumModelsCount}    Evaluate    ${NumModels_SRIOV_${SCN}}+1 
     :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
       \    Wait Until Keyword Succeeds   3x   2s   Login To Ecomp Portal 
       \    Wait Until Keyword Succeeds   3x   2s   Go to specific Application in Portal Grid       &{APPNames_${GLOBAL_ENVIRONMENT}}[VID] 

    
TC#14_Deletionof_VNFComponents
    
   Log To Console    Deletion of VNF Components 
   set global variable   ${SCN}   MCCD
   Wait Until Keyword Succeeds   3x   2s   Login To Ecomp Portal 
   Wait Until Keyword Succeeds   3x   2s   Go to specific Application in Portal Grid       &{APPNames_${GLOBAL_ENVIRONMENT}}[VID] 
   Wait Until Keyword Succeeds   3x   2s   Delete NC VNF Components    Delete    ${created_service_Instance_ID_${SCN}} 

***Keywords***

AAI Network Validation for SRIOV
    [ARGUMENTS]    ${netItr}
    Log To Console   SRIOV Network Validation 
        
     
    :FOR   ${Itr}   IN RANGE        1       3 
    \    Log To Console   &{${NCVnfName}_NetworkId_SRIOV}[${NCVnfName}_NetworkId_${netItr}_${Itr}]
    \    ${response}    A&AI Network GET Request   &{${NCVnfName}_NetworkId_SRIOV}[${NCVnfName}_NetworkId_${netItr}_${Itr}]
    \    Log to Console    ${response.status_code}
    \    Run Keyword If    ${response.status_code}==200   Log To Console    Network Validation Passed
    \    Run Keyword If    ${response.status_code}!=200   FAIL    msg=Network Validation Failed.Error Code =${response.status_code}

AAI Network Validation for OVS
    [ARGUMENTS]    ${netItr}
    Log To Console   OVS Network Validation 
        
        Log To Console   &{MCCD_NetworkId_OVS}[${NCVnfName}_NetworkId_${netItr}]
        ${response}    A&AI Network GET Request   &{${NCVnfName}_NetworkId_OVS}[${NCVnfName}_NetworkId_${netItr}]
        Log to Console    ${response.status_code}
        Run Keyword If    ${response.status_code}==200   Log To Console    Network Validation Passed
        Run Keyword If    ${response.status_code}!=200   FAIL    msg=Network Validation Failed.Error Code =${response.status_code}
      

Network Validations OVS
    Log To Console    Network Validation on Stack and AAI for OVS 
     ${NumModelsCount}    Evaluate    ${NumModels_OVS_${SCN}}+1 
        :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
         \    AAI Network Validation for OVS  ${netItr}
         \    NC Validation for OVS Network  ${netItr}    
            
         
Network Validations SRIOV

    Log To Console    Network Validation on Stack and AAI for SRIOV 
     ${NumModelsCount}    Evaluate    ${NumModels_SRIOV_${SCN}}+1 
        :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
         
        \    AAI Network Validation for SRIOV     ${netItr}
        \    NC Validation for SRIOV Network   ${netItr}