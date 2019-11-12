*** Settings ***
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
Resource            ../resources/commonKeywords.robot
Resource            Driver_ASDC.robot
Resource            aai_testsuite.robot
Library             callReporter
Library             SeleniumLibrary

# Test Setup          Authentication
# Test Teardown       Copy Logs       ${EXECDIR}    ${SUITE NAME}



*** Variables ***

    
${EXCEL_NAME}    mgmt_vcom_net_95.xlsm
${NETWORK_NAME}    APP-C-24595-T-IST-05A-COM-TOAM0_net_99
@{Network_Excel_files}           mgmt_vcom_net_95.xlsm      #GRP-27529-T-SIL-13B_MGMT_VISBC0_net_11.xlsm   GRP-27529-T-SIL-13B_TRST_VISBC0_net_11.xlsm  GRP-27529-T-SIL-13B_UNTR_VISBC0_net_11.xlsm
@{Vnf_Excel_files}       GRP_27529_T_SIL_13B_MGMT_VISBC0_net_11.xlsm    GRP_27529_T_SIL_13B_TRST_VISBC0_net_11.xlsm   GRP_27529_T_SIL_13B_UNTR_VISBC0_net_11.xlsm
@{vf_preload_files}    updated_visbc_ssa_b_trial.xlsm      updated_visbc_ssa_a_trial.xlsm        updated_visbc_rtp_trial.xlsm
${NUMBER_OF_ADDON_VF_MODULE}    1
${NUMBER_OF_VOLUME_GROUPS}    1
${VNF_SERVICE_INSTANCE_ID}    18844774-d46e-42a9-abc0-0bd3e83c5c22
${PRELOAD_TYPE}    ManualPreload


*** Test Cases ***

  
     
TC#1_Network_Model_Creation
                               Log To Console       Setting VNF variable
                               Set VNF Variable     VISBC
                               Log To Console       VNF model is set for VISBC
                               ${NumModelsCount}    Evaluate                        ${NumModels}+1
                               :FOR                 ${netItr}                       IN RANGE                                        1            ${NumModelsCount}
                               \                    log to console                  netItr is ${netItr}
                               \                    change User Role                DESIGNER

                               \                    ${serviceNameNetwork}           Create New Service Network Test                 ${netItr}
                               \                    Wait Until Keyword Succeeds     5                                               5x           clear checkout items
                               \                    Change User Role for testing    TESTER
                               \                    log to console                  service name passed is ${serviceNameNetwork}
                               \                    Test The Service                ${netItr}                                       network      ${ServiceName}           ${serviceNameNetwork}
                               \                    Change User Role for testing    GOVERNOR
                               \                    Approve The Service             ${netItr}                                       network      ${ServiceName}           ${serviceNameNetwork}
                               \                    Change User Role for testing    OPS
                               \                    Distribute The Service          ${netItr}                                       network      ${ServiceName}           ${serviceNameNetwork}
                               \                    Change User Role for testing    DESIGNER
    
  

TC#2_Network_Preload_Upload
                               # @{file_names}                       OperatingSystem.List Files In Directory    ${PATH_TO_NETWORK_PRELOAD_EXCELS}

                               Login To Ecomp Portal
                               Log To Console                      Login Success
                               launch Application and Validate     SDNGC-Admin-Portal
                               Log To Console                      Application Launched
                               Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
                               Log To Console                      Updating the Preload details
                               Log To Console                      Updated the Preload
                               Log To Console                      Executing the Network Preload Upload
                               Network preload upload              @{Network_Excel_files}
                               
                             
TC#3_Network_Spinup
                       ${NumModelsCount}    Evaluate                                                                                                                     ${NumModels}+1
                       :FOR                 ${netItr}                                                                                                                    IN RANGE                                                 1                                 ${NumModelsCount}
                       \                    log to console                                                                                                               netItr is ${netItr}
                       \                    Log To Console                                                                                                               A&AI Validation
                       \                    Login To Ecomp Portal
                       \                    Launch Application and Validate                                                                                              VID
                       \                    #${CUSTOMER_NAME}                                                                                                            ${service_instance_id}                                   Create VID Service Instance       ServiceWith_CONTRIAL30_641972    #${SERVICE_NAME}
                       \                    #####passing service name currently in VID network creation. but originally UUID was supposed to be passed. But it works
                       \                    ${network_details}                                                                                                           VID Network Creation                                     ${serviceNameNetwork${netItr}}    ${NETWORK_NAME_SDNC${netItr}}    ${netItr}           #${SERVICE_NAME}    ${NETWORK_NAME}
                       \                    Log To Console                                                                                                               ******Executed keyword : VID Network Creation ******
                       \                    Log To Console                                                                                                               Network Details : ${network_details}
     
TC#4_VNF_Model_Creation
    [Documentation]
    ...                              in test the service, approve the service and distribute the service, two parameters are passed.
    ...                              first is ${netItr} which represents to the number of iterations to be run. secing one is either
    ...                              vnf or network depending upon the type of modal you are trying to create
    # ...                            for vnf enter type as vnf and for network enter network
    # delete checkout items
    Change User Role for testing     DESIGNER
    Create New License Model Test
    Create New VSP - HeatFile
    Import The VF
    ${service_name_Run}              Create New Service Test
    delete checkout items
    Change User Role for testing     TESTER
    Test The Service                 1                                                                                                   vnf    ${Service_Name}    ${service_name_Run}
    Change User Role for testing     GOVERNOR
    Approve The Service              1                                                                                                   vnf    ${Service_Name}    ${service_name_Run}
    Change User Role for testing     OPS
    Distribute The Service           1                                                                                                   vnf    ${Service_Name}    ${service_name_Run}
    Change User Role for testing     DESIGNER
          
TC#5_VNF_Preload_Upload
    set Global Variable                 ${GLOBAL_SELENIUM_BROWSER}              firefox
    Login To Ecomp Portal
    launch Application and Validate     SDNGC-Admin-Portal
    Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]
    log list                            ${Vnf_Excel_files}
    Set Global Variable                 ${vnf}                                  VISBC
    VF Preload upload                   ${vf_preload_files}    
    
    
TC#6_VNF_Spinup
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER }    firefox
    Set Global Variable    ${GLOBAL_VNF}                  VISBC
    VNF Creation           vnf
       
       
# TC#7_VNF_Add_Volume_Group
     # Login To Ecomp Portal
     # Launch Application and Validate    VID
     # ${VOLUME_GROUP_ID}     Add Volume Group VID    ${VNF_SERVICE_INSTANCE_ID}    ${NUMBER_OF_VOLUME_GROUPS}    ${PRELOAD_TYPE}    ${Vnf_Excel_files}
     # Log To Console    Name of {VOLUME_GROUP_ID} is ${VOLUME_GROUP_ID}  
    
TC#8_AddBase_and_Add-on_VF_Module
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER }     firefox
    Add Base VF Module     vnf
    Login To Ecomp Portal
    Launch Application and Validate    VID   
    ${VF_MODULE_ID}     Create VID AddOn VF module    ${VNF_SERVICE_INSTANCE_ID}      ${NUMBER_OF_ADDON_VF_MODULE}    ${Preload_Type}    ${Vnf_Excel_files}
    Log To Console    Name of {VF_MODULE_ID} is ${VF_MODULE_ID}  
    
    
TC#9_Delete_VF_VG_VNF_NW
    Login To Ecomp Portal







	
    
    
    
    
    
    
    
    