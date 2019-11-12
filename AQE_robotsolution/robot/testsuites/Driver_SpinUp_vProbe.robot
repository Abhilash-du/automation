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
Resource            Driver_ASDC.robot
Resource            ../resources/commonkeywords.robot
Resource            ../resources/AIC/AIC_RESOURCE.robot


*** Variables ***
           
${index}    0
*** Test Cases ***

TC#01_ASDC_Network_Model_Creation

   set global variable   ${SCN}   vPROBE
  ${NumModelsCount}    Evaluate    ${NumModels}+1    
  :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
  \    log to console  netItr is ${netItr}
  \    change User Role for testing    DESIGNER    
  \  ${serviceNameNetwork}   Wait Until Keyword Succeeds   3x   2s     Create New Service Network Test   ${netItr}
  \    Set Global Variable       ${serviceNameNetwork_${SCN}_${netItr}}      ${serviceNameNetwork}
  \   Wait Until Keyword Succeeds    5   5x        clear checkout items 
  \  Wait Until Keyword Succeeds   3x   2s    Change User Role for testing        TESTER
  \    log to console  service name passed is ${serviceNameNetwork}
  \  Wait Until Keyword Succeeds   3x   2s    Test The Service   ${serviceNameNetwork_${SCN}_${netItr}} 
  \  Wait Until Keyword Succeeds   3x   2s    Change User Role for testing    GOVERNOR
  \  Wait Until Keyword Succeeds   3x   2s    Approve The Service   ${serviceNameNetwork_${SCN}_${netItr}} 
  \  Wait Until Keyword Succeeds   3x   2s    Change User Role for testing    OPS
  \  Wait Until Keyword Succeeds   3x   2s    Distribute The Service   ${serviceNameNetwork_${SCN}_${netItr}} 
  \  Wait Until Keyword Succeeds   3x   2s    Change User Role for testing    DESIGNER

    
TC#02_Network_Preload_Upload
    @{file_names}                       OperatingSystem.List Files In Directory    ${PATH_TO_NETWORK_PRELOAD_EXCELS}
    Wait Until Keyword Succeeds   3x   2s   Login To Ecomp Portal
    Log To Console                      Login Success
    Wait Until Keyword Succeeds   3x   2s    Go to specific Application in Portal Grid     &{APPNames_${GLOBAL_ENVIRONMENT}}[SDNGC]
    Log To Console                      Application Launched
    Wait Until Keyword Succeeds   3x   2s   Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]   60s
    Log To Console                      Updating the Preload details
    Log To Console                      Updated the Preload
    Log To Console                      Executing the Network Preload Upload
    Wait Until Keyword Succeeds   3x   2s   Network preload upload              @{file_names}
    

TC#03_Network_Spinup 
    set global variable   ${SCN}   vPROBE
    set global variable   ${GLOBAL_VNF}   ${SCN}   
     ${NumModelsCount}    Evaluate    ${NumModels}+1    
     :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
     \                    log to console                                             netItr is ${netItr}
     \        Wait Until Keyword Succeeds   3x   2s  Login To Ecomp Portal 
     \   Wait Until Keyword Succeeds   3x   2s   Go to specific Application in Portal Grid     &{APPNames_${GLOBAL_ENVIRONMENT}}[VID]
     \   ${network_details}  Wait Until Keyword Succeeds   3x   2s    VID_RESOURCE.VID Network Creation    ${serviceNameNetwork_${SCN}_${netItr}}      ${NETWORK_NAME_SDNC_${SCN}${netItr}}    ${netItr}         #${SERVICE_NAME}    ${NETWORK_NAME} 
     \   Log To Console    ******Executed keyword : VID Network Creation ****** 
     \   Log To Console    Network Details : ${network_details}

TC#04_ASDC_VNF_Model_Creation
    
    set global variable   ${SCN}   vPROBE
    delete checkout items
    Wait Until Keyword Succeeds   3x   2s  Change User Role for testing     DESIGNER
    Wait Until Keyword Succeeds   3x   2s  Create New License Model test
    Wait Until Keyword Succeeds   3x   2s  Create New VSP - HeatFile
    Wait Until Keyword Succeeds   3x   2s  Import The VF
    ${service_name_Run2}  Wait Until Keyword Succeeds   3x   2s    Create New Service Test  
    Wait Until Keyword Succeeds   3x   2s    log to console   test value of service run is ${service_name_Run}  
    Wait Until Keyword Succeeds   3x   2s    Set Global Variable  ${service_name_${SCN}}  ${service_name_Run2} 
    Wait Until Keyword Succeeds   3x   2s    log to console   test value of service run2 is ${service_name_Run2}    
    Wait Until Keyword Succeeds   3x   2s    delete checkout items
    Wait Until Keyword Succeeds   3x   2s    Change User Role for testing     TESTER
    Wait Until Keyword Succeeds   3x   2s    Test The Service         ${service_name_${SCN}}
    Wait Until Keyword Succeeds   3x   2s    Change User Role for testing     GOVERNOR
    Wait Until Keyword Succeeds   3x   2s    Approve The Service         ${service_name_${SCN}}
    Wait Until Keyword Succeeds   3x   2s    Change User Role for testing     OPS
    Wait Until Keyword Succeeds   3x   2s     Distribute The Service        ${service_name_${SCN}}
    Wait Until Keyword Succeeds   3x   2s    Change User Role for testing     DESIGNER

    
TC#05_VNF_Preload_Upload     
    set global variable   ${SCN}   vPROBE 
     
     
    @{file_names}    OperatingSystem.List Files In Directory    ${PATH_TO_VF_PRELOAD_EXCELS}   
    Wait Until Keyword Succeeds   3x   2s  Login To Ecomp Portal 
    Log To Console    Login Success 
    Wait Until Keyword Succeeds   3x   2s  launch Application and Validate   SDNGC-Admin-Portal 
    Log To Console    Application Launched 
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')] 
    Log To Console    Updating the Preload details 
    Log To Console    Updated the Preload 
    Log To Console    Executing the VF Preload Upload 
    Wait Until Keyword Succeeds   3x   2s    SDNC Preload upload       @{file_names}

    
    
TC#06_VNF_SpinUp 
    set global variable   ${SCN}   vPROBE
    set global variable   ${GLOBAL_VNF}   ${SCN} 
   Wait Until Keyword Succeeds   3x   2s     Login To Ecomp Portal
   Wait Until Keyword Succeeds   3x   2s    Go to specific Application in Portal Grid     &{APPNames_${GLOBAL_ENVIRONMENT}}[VID]

    ${vnf_details}   Wait Until Keyword Succeeds   3x   2s     VID VNF Creation    ${UUIDVnf_${SCN}}  

    Log To Console    ******Executed keyword : VID VNF Creation ******
    Log To Console    Network Details : ${vnf_details}

TC#07_Add_VolumeGroup

    set global variable   ${SCN}   vPROBE
    set global variable   ${GLOBAL_VNF}   ${SCN} 
     Login To Ecomp Portal
     Go to specific Application in Portal Grid     &{APPNames_${GLOBAL_ENVIRONMENT}}[VID]

     ${VOLUME_GROUP_ID}     Add Volume Group VID    ${created_service_Instance_ID_${SCN}}     ${${SCN}_NUMBER_OF_VOLUME_GROUPS}    ${${SCN}_PRELOAD_TYPE}    ${PRELOAD_FILE_NAME}

     
TC_08_AddBase_AddonVFModule
    set global variable   ${GLOBAL_VNF}   vPROBE 
    Login To Ecomp Portal
    Go to specific Application in Portal Grid     &{APPNames_${GLOBAL_ENVIRONMENT}}[VID]
    ${VF_MODULE_ID}    Create VID BASE VF module    ${created_service_Instance_ID_${SCN}}       ${${SCN}_PRELOAD_TYPE}    ${PRELOAD_FILE_NAME}
    Log To Console    Name of {VF_MODULE_ID} is ${VF_MODULE_ID}

    
    Run Keyword If    "${PAR_VID_ADDON_VF_MODULE_${SCN}}"=="NA"   Pass Execution    Add Base VF Module Executed. Received the parameter for AddOn Module hence it will be skipped.    

    
    ${VF_MODULE_ID}     Create VID AddOn VF module    ${created_service_Instance_ID_${SCN}}     ${${SCN}_NUMBER_OF_ADDON_VF_MODULE}   ${${SCN}_PRELOAD_TYPE}     ${PRELOAD_FILE_NAME}
    Log To Console    Name of {VF_MODULE_ID} is ${VF_MODULE_ID} 

TC_09_AAIValidation
    
    Log to Console   Validating in AAI 
    
    ${NumModelsCount}    Evaluate    ${NumModels}+1    
    :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
    \    A&AI Network GET Request    ${NETWORK_ID_${SCN}_NETWORK_${netItr}}
    \    Log to Console   Validating Network-${NETWORK_NAME_SDNC_${SCN}${netItr}}
    
    A&AI Generic_Vnf GET Request     ${VNF_ID_${SCN}}
    Log To Console    VNF for ${SCN} Validated with ID ${VNF_ID_${SCN}}   

 
TC_10_AIC_Validation
    
    Log to Console  Started Network Stack Validation 
    
    AIC Validations for Network  
  
    Log to Console  Started VNF Stack Validation   
  
    AIC Validations for VNF
  
TC_11_Delete Network
   
    set global variable   ${SCN}   vPROBE
    set global variable   ${GLOBAL_VNF}   ${SCN}
     ${NumModelsCount}    Evaluate                                                   ${NETWORK_COUNT_${SCN}}+1
     :FOR                 ${netItr}                                                  IN RANGE        1            ${NumModelsCount}
      \    Wait Until Keyword Succeeds   3x   2s   Login To Ecomp Portal 
      \    Wait Until Keyword Succeeds   3x   2s   Go to specific Application in Portal Grid     &{APPNames_${GLOBAL_ENVIRONMENT}}[VID]
      \    Wait Until Keyword Succeeds   3x   2s   Delete Network     ${created_service_Instance_ID_${SCN}_NETWORK_${netItr}}
 


 

TC_12_Delete_VF_VolumeGroup_VNF
   set global variable   ${SCN}   vPROBE
   set global variable   ${GLOBAL_VNF}   vPROBE 
   Wait Until Keyword Succeeds   3x   2s   Login To Ecomp Portal 
   Wait Until Keyword Succeeds   3x   2s   Go to specific Application in Portal Grid     &{APPNames_${GLOBAL_ENVIRONMENT}}[VID]
   Wait Until Keyword Succeeds   3x   2s   Delete VNF Components    Delete    ${created_service_Instance_ID_${SCN}} 

# TC_13_Test
      
    # set global variable   ${GLOBAL_VNF}   vPROBE 
    # set global variable   ${service_instance_id}     6e04dd93-dad2-483f-8fe7-1c5a42e9acd6
    # Login To Ecomp Portal
    # Launch Application and Validate    VID  
       # :FOR   ${index}  IN RANGE   2
    # \    Log to Console    ${index}   
    # \    Common Click Element                 Click on Existing Service Instances Link       ${lnkVIDExistingServiceInstances}    Y
    # \    Set Selenium Implicit Wait           300
    # \    Page Should Contain Element          xpath=${lblVIDServiceInstances} 
    # \    Page Should Contain Element          xpath=${drpVIDServiceInstanceChoose} 
    # \    Wait Until Element is Visible        xpath=${drpVIDServiceInstanceChoose}     
    # \    Common Click Element                 Open Dropdown of Selecting Service Instance Choose Options       ${drpVIDServiceInstanceChoose}    Y 
    # \    Common Click Element                 Select Search By ID       ${slcVIDServiceInstanceSearchByID}    Y
    # \    Common Input Text                    Enter the Service instance Id to search       ${TXT_VID_SEARCH_EXISTING_SERVICE_INSTANCE}    ${service_instance_id}    Y
    # \    Common Click Element                 Click Search Btn       ${BTN_VID_SEARCH_EXISTING_SERVICE_INSTANCE}    Y
    # \    Wait Until Page Contains Element     xpath=${lnkVIDViewServiceInstance}     300s
    # \    Common Input Text                    Enter the Service instance Id       ${TXT_VID_SEARCH_MODEL}    ${service_instance_id}    Y
    # \    Common Click Element                 Click on View Service Instance       ${lnkVIDViewServiceInstance}    Y
    # \    Set Selenium Implicit Wait           300
    # \    Element Should Be Visible            xpath=${syncForInstacneCreationMainPage}       View Service Instance
    # \    Set Selenium Implicit Wait           300
    # \    Sleep                                10s
    # \    Wait Until Page Contains             ${service_instance_id}     
    # \    Sleep                                3s
    # \    #Add Volume Group
    # \    Common Click Element                 Click on Add Volume Group Btn       ${BTN_VID_ADD_VOLUME_GROUP}    Y   
    # \    Sleep                                1s                     
    # \    ${INDEX1}   Evaluate    ${index}+1
    # \    Common Click Element                 Click on Available Volume Group       //button[contains(.,'Add Volume Group')]/following::a[${INDEX1}]    Y 
    # \    Sleep     3s
    # \    ${VOLUMEGOUP_MODULE_NAME}    Common get Text    Get VG Module Name    //td[@data-tests-id='Model Name']
    # \    Log To Console    ${VOLUMEGOUP_MODULE_NAME}  
    # \    Common Click Element    Click Cancel     //button[@data-tests-id='cancelButton']   
    # \    common find replace    elementName    ${EXECDIR}\\robot\\resources\\VID\\vid_data.robot     VG_MODULENAME_${SCN}_${index}} [${SPACE}a-zA-Z://0-9.//,-_]*  VG_MODULENAME_${SCN}_${index}} ${SPACE}${SPACE}${SPACE} ${VOLUMEGOUP_MODULE_NAME}  
    # \    Set Global Variable    ${VG_MODULENAME_${SCN}_${index}}    ${VOLUMEGOUP_MODULE_NAME}    
    # \    #Add VF Module
    # \    Common Click Element                Clicking on Add VF Module Btn        ${BTN_VID_ADD_VF_MODULE}    Y  
    # \    Sleep                                1s                     
    # \    Common Click Element                Clicking on Available VF Module       ${LBL_VID_BASE_VF_MODULE_NAME}    Y  
    # \    ${VFMODULE_MODULE_NAME}    Common get Text    Get VG Module Name    //td[@data-tests-id='Model Name']
    # \    common find replace    elementName    ${EXECDIR}\\robot\\resources\\VID\\vid_data.robot     VFMODULE_${SCN}_${index}} [${SPACE}a-zA-Z://0-9.//,-_]*  VFMODULE_${SCN}_${index}} ${SPACE}${SPACE}${SPACE} ${VOLUMEGOUP_MODULE_NAME}  
    # \    Set Global Variable    ${VFMODULE_${SCN}_${index}}    ${VFMODULE_MODULE_NAME}   
    # \    Log To Console    ${VFMODULE_MODULE_NAME} 
    # \    Run Keyword If   "${VG_MODULENAME_${SCN}_${index}}"=="${VFMODULE_${SCN}_${index}}"    Log to Console     Use VolumeGroupName-${VOLUME_GROUP_NAME_${SCN}_${index}} 
    # \       #Set LCP Region
    # \    Run Keyword If   "${VG_MODULENAME_${SCN}_${index}}"=="${VFMODULE_${SCN}_${index}}"      Wait Until Element Is Visible        xpath=${drpVIDLcpRegion}    200s
    # \    Run Keyword If   "${VG_MODULENAME_${SCN}_${index}}"=="${VFMODULE_${SCN}_${index}}"      Common Click Element                 Open Dropdown for LCP Region       ${drpVIDLcpRegion}    Y
    # \    Run Keyword If   "${VG_MODULENAME_${SCN}_${index}}"=="${VFMODULE_${SCN}_${index}}"      Sleep                                1s
    # \    Run Keyword If   "${VG_MODULENAME_${SCN}_${index}}"=="${VFMODULE_${SCN}_${index}}"      Common Click Element                 Selecting LCP Region       ${SLC_VID_VF_MODULE_LCP_REGION}    Y
    # \    Run Keyword If   "${VG_MODULENAME_${SCN}_${index}}"=="${VFMODULE_${SCN}_${index}}"      Sleep                                1s
    # \   #Set Volume Group
    # \    Run Keyword If    "${VG_MODULENAME_${SCN}_${index}}"=="${VFMODULE_${SCN}_${index}}"    Wait Until Element Is Visible        xpath=//select[@data-tests-id='availableVolumeGroup']   200s
    # \    Run Keyword If    "${VG_MODULENAME_${SCN}_${index}}"=="${VFMODULE_${SCN}_${index}}"    Common Click Element                 Open Dropdown for Volume Group      //select[@data-tests-id='availableVolumeGroup']    Y
    # \    Run Keyword If    "${VG_MODULENAME_${SCN}_${index}}"=="${VFMODULE_${SCN}_${index}}"    Common Click Element                Selecting Volume Group    //select[@data-tests-id='availableVolumeGroup']//option[@value='${VOLUME_GROUP_NAME_${SCN}_0}']    Y
    # \    Run Keyword If    "${VG_MODULENAME_${SCN}_${index}}"=="${VFMODULE_${SCN}_${index}}"    Sleep    1s


    # \    Run Keyword If    "${VG_MODULENAME_${SCN}_${index}}"!="${VFMODULE_${SCN}_${index}}"     Log to Console    Selecting "NONE" for  volume group
     # #Set Volume Group
    # \    Run Keyword If    "${VG_MODULENAME_${SCN}_${index}}"!="${VFMODULE_${SCN}_${index}}"     Wait Until Element Is Visible        xpath=//select[@data-tests-id='availableVolumeGroup']   200s
    # \    Run Keyword If    "${VG_MODULENAME_${SCN}_${index}}"!="${VFMODULE_${SCN}_${index}}"     Common Click Element                 Open Dropdown for Volume Group      //select[@data-tests-id='availableVolumeGroup']    Y
    # \    Run Keyword If    "${VG_MODULENAME_${SCN}_${index}}"!="${VFMODULE_${SCN}_${index}}"     Common Click Element                Selecting Volume Group    //select[@data-tests-id='availableVolumeGroup']//option[@value="None"]    Y
    # \    Run Keyword If    "${VG_MODULENAME_${SCN}_${index}}"!="${VFMODULE_${SCN}_${index}}"     Sleep    1s   

