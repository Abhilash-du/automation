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
#Resource            CLAMP_Regression.robot
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
${service_name_Run2}  
${EXCEL_NAME}    mgmt_vcom_net_95.xlsm
${NETWORK_NAME}    APP-C-24595-T-IST-05A-COM-TOAM0_net_99
${files}           mgmt_vcom_net_95.xlsm      #GRP-27529-T-SIL-13B_MGMT_VISBC0_net_11.xlsm   GRP-27529-T-SIL-13B_TRST_VISBC0_net_11.xlsm  GRP-27529-T-SIL-13B_UNTR_VISBC0_net_11.xlsm

*** Test Cases ***
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
      
    
VNF Spinup
    
        Login To Ecomp Portal 
        Launch Application and Validate    VID 
         #${CUSTOMER_NAME}    ${service_instance_id}    Create VID Service Instance      ServiceWith_CONTRIAL30_641972     #${SERVICE_NAME}
        #####passing service name currently in VID network creation. but originally UUID was supposed to be passed. But it works 
       ${vnf_details}     VID VNF Creation    ${UUIDVnf}     #${SERVICE_NAME}    ${NETWORK_NAME} 
        Log To Console    ******Executed keyword : VID Network Creation ****** 
        Log To Console    Network Details : ${vnf_details} 
    #VID VNF Creation                                   
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


vnf model Creation
   [Documentation]
   ...    in test the service, approve the service and distribute the service, two parameters are passed.
   ...    first is ${netItr} which represents to the number of iterations to be run. secing one is either 
   ...    vnf or network depending upon the type of modal you are trying to create
   # ...    for vnf enter type as vnf and for network enter network
    delete checkout items
    Change User Role for testing     DESIGNER
    Create New License Model test
    Create New VSP - HeatFile
    Import The VF
    ${service_name_Run2}   Create New Service Test  
    log to console   test value of service run is ${service_name_Run}  
    Set Global Variable  ${service_name_${SCN}}  ${service_name_Run} 
    log to console   test value of service run2 is ${service_name_Run2}    
    delete checkout items
    Change User Role for testing     TESTER
    Test The Service         ${service_name_${SCN}}
    Change User Role for testing     GOVERNOR
    Approve The Service         ${service_name_${SCN}}
    Change User Role for testing     OPS
    Distribute The Service        ${service_name_${SCN}}
    Change User Role for testing     DESIGNER

Network Model creation
  ${NumModelsCount}    Evaluate    ${NumModels}+1    
  :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
  \    log to console  netItr is ${netItr}
  \    change User Role for testing    DESIGNER    
  \  ${serviceNameNetwork}  Create New Service Network Test   ${netItr}
  \    Set Global Variable       ${serviceNameNetwork_${SCN}_${netItr}}      ${serviceNameNetwork}
  \   Wait Until Keyword Succeeds    5   5x        clear checkout items 
  \  Change User Role for testing        TESTER
  \    log to console  service name passed is ${serviceNameNetwork}
  \  Test The Service   ${serviceNameNetwork_${SCN}_${netItr}} 
  \  Change User Role for testing    GOVERNOR
  \  Approve The Service   ${serviceNameNetwork_${SCN}_${netItr}} 
  \  Change User Role for testing    OPS
  \  Distribute The Service   ${serviceNameNetwork_${SCN}_${netItr}} 
  \  Change User Role for testing    DESIGNER


Flexware Modals creation

    Create New License Model Test
    Create New VSP - Flexware
    Import The VF - Flexware 
    ${service_name_flexware}   Create New Service Flexware
    Set Global Variable    ${service_name_flexware_${SCN}}      ${service_name_flexware} 
    delete checkout items
    Change User Role for testing     TESTER
    Test The Service            ${service_name_flexware_${SCN}} 
    Change User Role for testing     GOVERNOR
    Approve The Service        ${service_name_flexware_${SCN}} 
    Change User Role for testing     OPS
    Distribute The Service        ${service_name_flexware_${SCN}} 
    Change User Role for testing     DESIGNER
Drag and Drop
    Drag and Drop  


OAM model Creation and Distribution
         # Change User Role for testing    DESIGNER 
       ${service_name_OAM_Run}   Create New OAM Network model flow
        delete checkout items
        Set Global Variable    ${service_name_OAM}   ${service_name_OAM_Run} 
        Change User Role for testing        TESTER
        Test The Service   ${service_name_OAM}  
        Change User Role for testing        GOVERNOR
        Approve The Service   ${service_name_OAM}  
        Change User Role for testing    OPS
        Distribute The Service     ${service_name_OAM}  
        Change User Role for testing    DESIGNER  

SRIOV Model Creation
     Set Global Variable   ${SCN}   ${VNF}  
    ${NumModelsCount}    Evaluate    ${NumModels_SRIOV_${SCN}}+1 
  :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
   \    ${service_name_SRIOV_Run}   Create New Service Network model flow   ${netItr}
   \    Set Global Variable     ${service_name_SRIOV_${SCN}_${netItr}}     ${service_name_SRIOV_Run}
   \     delete checkout items
   \     Change User Role for testing        TESTER
   \     Test The Service SRIOV  ${service_name_SRIOV_${SCN}_${netItr}}
   \     Change User Role for testing        GOVERNOR
   \     Approve The Service SRIOV  ${service_name_SRIOV_${SCN}_${netItr}}
   \     Change User Role for testing    OPS
   \     Distribute The Service SRIOV   ${service_name_SRIOV_${SCN}_${netItr}}
   \     Change User Role for testing    DESIGNER 
OVS Model Creation 
       
       ${service_name_OVS_Run}   Create New Service OVS Network model flow    4  # ${netItr} 
        delete checkout items
        Change User Role for testing        TESTER
        Test The Service   ${service_name_OVS_Run} 
        Change User Role for testing        GOVERNOR
        Approve The Service   ${service_name_OVS_Run} 
        Change User Role for testing    OPS
        Distribute The Service    ${service_name_OVS_Run} 
        Change User Role for testing    DESIGNER 
Change role
    Change User Role for testing    DESIGNER          
 vnf model Creation Complex
   [Documentation]
   ...    in test the service, approve the service and distribute the service, two parameters are passed.
   ...    first is ${netItr} which represents to the number of iterations to be run. secing one is either 
   ...    vnf or network depending upon the type of modal you are trying to create
   # ...    for vnf enter type as vnf and for network enter network
       delete checkout items
       :FOR  ${VNFItr}  IN  LMSP    #PXTC     #
       \    set global variable   ${SCN}   ${VNFItr}
       \   log to console   VNFItr is ${VNFItr}    
	   \   Change User Role for testing     DESIGNER
	   \   Wait Until Keyword Succeeds   3x   2s     Create New License Model Complex    ${VNFItr}
	   \   Wait Until Keyword Succeeds   3x   2s  Create New VSP - HeatFile complex    ${VNFItr}
	   \   Wait Until Keyword Succeeds   3x   2s  Import The VF Complex  ${VNFItr}
	   \    ${service_name_complex}  Wait Until Keyword Succeeds   3x   2s    Create New Service Complex Driver   ${vf_name_Complex_${SCN}}      ${VNFItr}
	   \   log to console   test value of service run is  ${service_name_complex}   
	   \   Set Global Variable  ${service_name_Complex2}  ${service_name_complex}
	   \   log to console   test value of service run2 is ${service_name_Complex2}   
	   \   Wait Until Keyword Succeeds   3x   2s   delete checkout items
	   \   Wait Until Keyword Succeeds   3x   2s  Change User Role for testing     TESTER
	   \   Wait Until Keyword Succeeds   3x   2s  Test The Service complex  ${service_name_Complex2}            
	   \   Wait Until Keyword Succeeds   3x   2s  Change User Role for testing     GOVERNOR
	   \   Wait Until Keyword Succeeds   3x   2s  Approve The Service complex   ${service_name_Complex2}
	   \   Wait Until Keyword Succeeds   3x   2s  Change User Role for testing     OPS
	   \  Wait Until Keyword Succeeds   3x   2s   Distribute The Service complex     ${service_name_Complex2}  ${VNFItr}
	   \   Change User Role for testing     DESIGNER    
	   
	       ${service_name_linked}  Wait Until Keyword Succeeds   3x   2s   Create New Service Complex Linking Driver   LMSP   PXTC
	     Set Global Variable  ${service_name_complex_linked}   ${service_name_complex}
	     delete checkout items
	     Change User Role for testing     TESTER
	     Wait Until Keyword Succeeds   5x   2s  Test The Service complex   ${service_name_complex_linked}          
	     Change User Role for testing     GOVERNOR
	     Wait Until Keyword Succeeds   5x   2s  Approve The Service complex    ${service_name_complex_linked} 
	     Change User Role for testing     OPS
	     Wait Until Keyword Succeeds   5x   2s  Distribute The Service complex    ${service_name_complex_linked}   linked
	     Change User Role for testing     DESIGNER 
	     

 vnf model Creation Update
   [Documentation]
   ...    in test the service, approve the service and distribute the service, two parameters are passed.
   ...    first is ${netItr} which represents to the number of iterations to be run. secing one is either 
   ...    vnf or network depending upon the type of modal you are trying to create
   # ...    for vnf enter type as vnf and for network enter network
       delete checkout items
       :FOR  ${VNFItr}  IN   LMSP    #PXTC     #
       \    set global variable   ${SCN}   ${VNFItr}
       \   log to console   VNFItr is ${VNFItr}    
	   \   Change User Role for testing     DESIGNER
	   # # \   Wait Until Keyword Succeeds   3x   2s     Create New License Model Update    ${VNFItr}
	   \    Wait Until Keyword Succeeds   3x   2s  Create New VSP - HeatFile Update   ${VNFItr}
	   \   Wait Until Keyword Succeeds   3x   2s  Import The VF Update  ${VNFItr}
	   \   ${service_name_Update}   Create New Service Update Driver   ${vf_name_Update_${SCN}}      ${VNFItr}
	   \   log to console   test value of service run is  ${service_name_Update}   
	   \   Set Global Variable  ${service_name_Update2}  ${service_name_Update}
	   \   log to console   test value of service run2 is ${service_name_Update2}   
	   \   Wait Until Keyword Succeeds   3x   2s   delete checkout items
	   \   Wait Until Keyword Succeeds   3x   2s  Change User Role for testing     TESTER
	   \   Wait Until Keyword Succeeds   3x   2s  Test The Service Update  ${service_name_Update2}            
	   \   Wait Until Keyword Succeeds   3x   2s  Change User Role for testing     GOVERNOR
	   \   Wait Until Keyword Succeeds   3x   2s  Approve The Service Update  ${service_name_Update2}
	   \   Wait Until Keyword Succeeds   3x   2s  Change User Role for testing     OPS
	   \  Wait Until Keyword Succeeds   3x   2s   Distribute The Service Update     ${service_name_Update2}  ${VNFItr}
	   \   Change User Role for testing     DESIGNER  
	   \    
	   	   \    Wait Until Keyword Succeeds   3x   2s  Update VSP - HeatFile Update   ${VNFItr}
	   \   Wait Until Keyword Succeeds   3x   2s  Update The VF Update  ${VNFItr}
	   \   ${service_name_Update}   Create New Service Update Driver   ${vf_name_Update_${SCN}}      ${VNFItr}
	   \   log to console   test value of service run is  ${service_name_Update}   
	   \   Set Global Variable  ${service_name_Update2}  ${service_name_Update}
	   \   log to console   test value of service run2 is ${service_name_Update2}   
	   \   Wait Until Keyword Succeeds   3x   2s   delete checkout items
	   \   Wait Until Keyword Succeeds   3x   2s  Change User Role for testing     TESTER
	   \   Wait Until Keyword Succeeds   3x   2s  Test The Service Update  ${service_name_Update2}            
	   \   Wait Until Keyword Succeeds   3x   2s  Change User Role for testing     GOVERNOR
	   \   Wait Until Keyword Succeeds   3x   2s  Approve The Service Update  ${service_name_Update2}
	   \   Wait Until Keyword Succeeds   3x   2s  Change User Role for testing     OPS
	   \  Wait Until Keyword Succeeds   3x   2s   Distribute The Service Update     ${service_name_Update2}  ${VNFItr}
	   \   Change User Role for testing     DESIGNER     
	         
Test dict variable
    Test variable test
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
      Test The Service  ${service_name_Run_Preload}
      Change User Role for testing        GOVERNOR
      Approve The Service  ${service_name_Run_Preload}
      Change User Role for testing    OPS
      Distribute The Service    ${service_name_Run_Preload}
      Change User Role for testing    DESIGNER 	         
        
        
        
        
        
        
        
          

# TC#07_Add_Volume_Group
          # #New *********************************************************
    
    # Log To Console    ****** Execution Starting for TC - TC#07_Add_Volume_Group **********************
# #    ${VNF_SERVICE_INSTANCE_ID}    Set Variable    ${PAR_VNF_SERVICE_INSTANCE_ID}
  
    # Run Keyword If    "${PAR_VNF_SERVICE_INSTANCE_ID}"!="NA"   Run Keywords 
    # ...    Log to Console    Received Parameter for VNF_SERVICE_INSTANCE_ID
    # ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*VNF_SERVICE_INSTANCE_ID[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VNF_SERVICE_INSTANCE_ID\} ${SPACE}${SPACE}${SPACE} ${PAR_VNF_SERVICE_INSTANCE_ID}        
    # # ...    AND    Pass Execution    Parameters - VNF_SERVICE_DISTRIBUTION_DATA_01 - updated Successfully    
    # # Log To Console    Parameter was not received. Executing TC#06_VNF Spin up.
    
    # #New ***********************************************************************
    
     # Login To Ecomp Portal
     # Launch Application and Validate    VID
     # ${VOLUME_GROUP_ID}     Add Volume Group VID    ${VNF_SERVICE_INSTANCE_ID}    ${NUMBER_OF_VOLUME_GROUPS}    ${PRELOAD_TYPE}    ${PRELOAD_FILE_NAME}
     # Log To Console    Name of {VOLUME_GROUP_ID} is ${VOLUME_GROUP_ID}      
     
# TC_08_Add_Base_and_Add-on_VF_Module
          # #New *********************************************************
    
    # Log To Console    ****** Execution Starting for TC - TC_08_Add_Base_and_Add-on_VF_Module **********************
# #    ${VNF_SERVICE_INSTANCE_ID}    Set Variable    ${PAR_VNF_SERVICE_INSTANCE_ID}
  
    # Run Keyword If    "${PAR_VNF_SERVICE_INSTANCE_ID}"!="NA"   Run Keywords 
    # ...    Log to Console    Received Parameter for VNF_SERVICE_INSTANCE_ID
    # ...    AND    Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*VNF_SERVICE_INSTANCE_ID[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VNF_SERVICE_INSTANCE_ID\} ${SPACE}${SPACE}${SPACE} ${PAR_VNF_SERVICE_INSTANCE_ID}        
    # # ...    AND    Pass Execution    Parameters - VNF_SERVICE_DISTRIBUTION_DATA_01 - updated Successfully    
    # # Log To Console    Parameter was not received. Executing TC#06_VNF Spin up.
    
    # #New ***********************************************************************
    

    # Login To Ecomp Portal
    # Launch Application and Validate    VID
    # ${VF_MODULE_ID}    Create VID BASE VF module    ${VNF_SERVICE_INSTANCE_ID}    ${PRELOAD_TYPE}    ${PRELOAD_FILE_NAME}
    # Log To Console    Name of {VF_MODULE_ID} is ${VF_MODULE_ID}
    # Find Replace       ${EXECDIR}\\robot\\resources\\VNF_Spinup.robot     [\\$\\{]*VF_MODULE_ID[${SPACE}a-zA-Z://0-9.\\-\\_\\[\\]\\=\\;\\'\\$\\{\\}]*     \$\{VF_MODULE_ID\} ${SPACE}${SPACE}${SPACE} ${VF_MODULE_ID}
   
   
    # Run Keyword If    "${PAR_VID_ADDON_VF_MODULE}"!="NA"   Pass Execution    Add Base VF Module Executed. Received the parameter for AddOn Module hence it will be skipped.    
    
    # ${VF_MODULE_ID}     Create VID AddOn VF module    ${VNF_SERVICE_INSTANCE_ID}      ${NUMBER_OF_ADDON_VF_MODULE}    ${Preload_Type}    ${PRELOAD_FILE_NAME}
    # Log To Console    Name of {VF_MODULE_ID} is ${VF_MODULE_ID} 
    

	
    
    
    
    
    
    
    
    