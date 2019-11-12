*** Settings ***
Library     SeleniumLibrary

Resource    ../resources/commonKeywords.robot
Resource    ../resources/global_properties.robot
Resource    ../resources/browser_setup.robot
Resource    ../resources/commonKeywords.robot
Resource    ../resources/SDC/SDC_RESOURCE.robot
Resource    ../resources/SDC/SDC_DATA.robot

***Variables***
${vlm_name1}
${la_name1}
 ${fg_name1}
 ${vsp_name1}
 ${flag}   0
#Test Setup          callCreateFile                                                           C:\\SourceCloud\\Robot Automation\\testsuite\\robot\\library\\myLibraries

#Test Teardown    Close All Browsers


*** Keywords ***
Create New License Model test
    #[TAGS]                SMoke
    log to console   starting test Create New License Model test
    ${vlm_name}           ${la_name}                          ${fg_name}     Create New License Model
    log to console        value of vlm is ${vlm_name}
    log to console        value of la is ${la_name}
    
    Set suite variable    ${vlm_name}                         ${vlm_name}
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     vlm_name_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   vlm_name_${SCN}}${SPACE}${SPACE}${SPACE} ${vlm_name}
    Set suite variable    ${la_name}                          ${la_name}
     common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     la_name_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   la_name_${SCN}}${SPACE}${SPACE}${SPACE} ${la_name}
    Set suite variable    ${fg_name}                          ${fg_name}
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     fg_name_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   fg_name_${SCN}}${SPACE}${SPACE}${SPACE} ${fg_name}
    log to console        value of vlm_name is ${vlm_name}
Create New License Model Preload
    #[TAGS]                SMoke
    log to console   starting test Create New License Model test
    ${vlm_name}           ${la_name}                          ${fg_name}     Create New License Model
    log to console        value of vlm is ${vlm_name}
    log to console        value of la is ${la_name}
    
    Set global variable    ${vlm_namePreload}                         ${vlm_name}
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot      vlm_namePreload}[${SPACE}a-zA-Z://0-9.-_]*   vlm_namePreload}${SPACE}${SPACE}${SPACE} ${vlm_namePreload} 
    Set global variable    ${la_namePreload}                          ${la_name}
     common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     la_namePreload}[${SPACE}a-zA-Z://0-9.-_]*   la_namePreload}${SPACE}${SPACE}${SPACE} ${la_namePreload}  
    Set global variable    ${fg_namePreload}                          ${fg_name}
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     fg_namePreload}[${SPACE}a-zA-Z://0-9.-_]*   fg_namePreload}${SPACE}${SPACE}${SPACE} ${fg_namePreload}
    log to console        value of vlm_name is ${vlm_namePreload} 
Create New License Model Complex
    #[TAGS]                SMoke
    [Arguments]     ${SCN}
    log to console   starting test Create New License Model test
    ${vlm_name1}          ${la_name1}                          ${fg_name1}     Create New License Model    
    Set global variable     ${vlm_name_complex_${SCN}}                       ${vlm_name1}
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     vlm_name_complex_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   vlm_name_complex_${SCN}}${SPACE}${SPACE}${SPACE} ${vlm_name1}
    Set Global variable    ${la_name_complex_${SCN}}                          ${la_name1}
     common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     la_name_complex_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   la_name_complex_${SCN}}${SPACE}${SPACE}${SPACE} ${la_name1}
    Set Global variable    ${fg_name_complex_${SCN}}                          ${fg_name1}
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot      fg_name_complex_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   fg_name_complex_${SCN}}${SPACE}${SPACE}${SPACE} ${fg_name1}
    log to console        value of vlm_name is  ${vlm_name_complex_${SCN}}  
    
 Create New License Model Update
    #[TAGS]                SMoke
    [Arguments]     ${SCN}
    log to console   starting test Create New License Model test
    ${vlm_name1}          ${la_name1}                          ${fg_name1}     Create New License Model    
    Set global variable     ${vlm_name_Update_${SCN}}                       ${vlm_name1}
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     vlm_name_Update_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   vlm_name_Update_${SCN}}${SPACE}${SPACE}${SPACE} ${vlm_name_Update_${SCN}}   
    Set Global variable    ${la_name_Update_${SCN}}                          ${la_name1}
     common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     la_name_Update_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   la_name_Update_${SCN}}${SPACE}${SPACE}${SPACE} ${la_name_Update_${SCN}} 
    Set Global variable    ${fg_name_Update_${SCN}}                          ${fg_name1}
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot      fg_name_Update_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   fg_name_Update_${SCN}}${SPACE}${SPACE}${SPACE} ${fg_name_Update_${SCN}} 
    log to console        value of vlm_name is  ${vlm_name_Update_${SCN}}  
 Create New License Model Fabric
    #[TAGS]                SMoke
    [Arguments]     ${SCN}
    log to console   starting test Create New License Model test
    ${vlm_name1}          ${la_name1}                          ${fg_name1}     Create New License Model
    log to console        value of vlm is ${vlm_name1}
    log to console        value of la is ${la_name1}
     log to console        value of vlm_name is ${vlm_name1}  
    
    Set global variable    ${vlm_name_Fabric_${SCN}}                         ${vlm_name1}
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     vlm_name_Fabric_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   vlm_name_Fabric_${SCN}}${SPACE}${SPACE}${SPACE} ${vlm_name_Fabric_${SCN}} 
    Set global variable    ${la_name_Fabric_${SCN}}                         ${la_name1}
     common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     la_name_Fabric_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   la_name_Fabric_${SCN}}${SPACE}${SPACE}${SPACE} ${la_name_Fabric_${SCN}}  
    Set global variable    ${fg_name_Fabric_${SCN}}                         ${fg_name1}
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot      fg_name_Fabric_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   fg_name_Fabric_${SCN}}${SPACE}${SPACE}${SPACE} ${fg_name_Fabric_${SCN}} 
     
 Printy heat file
 
    log to console  heastfiel is &{Dict_${SCN}}[heatfile]       
 Create New VSP - HeatFile
    log to console   starting test Create New VSP - HeatFile
     
    log to console        value of vlm_name is  ${vlm_name}
    ${vsp_name1}           Create New Vendor Software Product - Heatfile    ${vlm_name_${SCN}}    ${la_name_${SCN}}    ${fg_name_${SCN}}
    Log To Console        ${vsp_name}
    Set Suite Variable    ${vsp_name}                                      ${vsp_name1}
     common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     vsp_name_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   vsp_name_${SCN}}${SPACE}${SPACE}${SPACE} ${vsp_name}
 Create New VSP - HeatFile Preload
    log to console   starting test Create New VSP - HeatFile Preload
     
    log to console        value of vlm_name is ${vlm_name}
    ${vsp_name}           Create New Vendor Software Product - Heatfile    ${vlm_namePreload}    ${la_namePreload}    ${fg_namePreload}
    Log To Console        ${vsp_name}
    Set global Variable    ${vsp_namePreload}        ${vsp_name}
     common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     vsp_namePreload} [${SPACE}a-zA-Z://0-9.-_]*   vsp_namePreload} ${SPACE}${SPACE}${SPACE} ${vsp_namePreload}    
 Create New VSP - HeatFile complex
   [Arguments]   ${SCN}
    log to console   starting test Create New VSP - HeatFile
     
    log to console        value of vlm_name is ${vlm_name}
    ${vsp_name_Complex1}           Create New Vendor Software Product - Heatfile Complex    ${vlm_name_complex_${SCN}}     ${la_name_complex_${SCN}}     ${fg_name_complex_${SCN}}   ${SCN}
    Log To Console        vsp name in driverASDC is ${vsp_name_Complex1}  
    Set global Variable    ${vsp_name_complex_${SCN}}                                      ${vsp_name_Complex1}  
     common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     vsp_name_complex_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   vsp_name_complex_${SCN}}${SPACE}${SPACE}${SPACE} ${vsp_name_Complex1}
     
Create New VSP - HeatFile Update
   [Arguments]   ${SCN}    
    log to console   starting test Create New VSP - HeatFile
     
    log to console        value of vlm_name is ${vlm_name}
    ${vsp_name_Update1}           Create New Vendor Software Product - Heatfile Complex    ${vlm_name_Update_${SCN}}     ${la_name_Update_${SCN}}     ${fg_name_Update_${SCN}}   ${SCN}
    Log To Console        vsp name in driverASDC is ${vsp_name_Update1}  
    Set global Variable    ${vsp_name_Update_${SCN}}                                      ${vsp_name_Update1}  
     common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     vsp_name_Update_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   vsp_name_Update_${SCN}}${SPACE}${SPACE}${SPACE} ${vsp_name_Update_${SCN}}  
Update VSP - HeatFile Update
   [Arguments]   ${SCN}    
    log to console   starting test Create New VSP - HeatFile
     
    log to console        value of vlm_name is ${vlm_name}
    ${vsp_name_Update1}           Update Vendor Software Product - Heatfile Update    ${vlm_name_Update_${SCN}}     ${la_name_Update_${SCN}}     ${fg_name_Update_${SCN}}   ${SCN}
    Log To Console        vsp name in driverASDC is ${vsp_name_Update1}  
    Set global Variable    ${vsp_name_Update_${SCN}}                                      ${vsp_name_Update1}  
     common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     vsp_name_Update_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   vsp_name_Update_${SCN}}${SPACE}${SPACE}${SPACE} ${vsp_name_Update_${SCN}}          
    
 Create New VSP - HeatFile Fabric
   [Arguments]   ${SCN}
    log to console   starting test Create New VSP - HeatFile
     
    log to console        value of vlm_name is ${vlm_name}
    ${vsp_name_Fabric1}           Create New Vendor Software Product - Heatfile Complex    ${vlm_name_Fabric_${SCN}}     ${la_name_Fabric_${SCN}}     ${fg_name_Fabric_${SCN}}   ${SCN}
    Log To Console        vsp name in driverASDC is${vsp_name_Fabric1} 
    Set global Variable    ${vsp_name_Fabric_${SCN}}                                     ${vsp_name_Fabric1} 
     common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     vsp_name_Fabric_${SCN}}[${SPACE}a-zA-Z://0-9.-_]*   vsp_name_Fabric_${SCN}}${SPACE}${SPACE}${SPACE} ${vsp_name_Fabric1}  
     [return]    ${vsp_name_Fabric1} 
 Create New VSP - Flexware
     
    log to console        value of vlm_name is ${vlm_name}
    ${vsp_name_flexware}           Create New Vendor Software Product - Flexware    ${vlm_name}    ${la_name}    ${fg_name}
    Log To Console        ${vsp_name_flexware} 
    Set Suite Variable    ${vsp_name_flexware}                                      ${vsp_name_flexware} 
    common find replace    replacing flexware vsp    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     vsp_name_flexware}[${SPACE}a-zA-Z://0-9.-_]*   vsp_name_flexware}${SPACE}${SPACE}${SPACE} ${vsp_name_flexware} 
 
 Import The VF - Flexware  
    log to console  starting test Import The VF 
    ${vf_name}        Import VF     ${vsp_name_flexware}
    Set Suite Variable    ${vf_name}    ${vf_name} 
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     vf_name}[${SPACE}a-zA-Z://0-9.//-_]*   vf_name}${SPACE}${SPACE}${SPACE} ${vf_name}   
    Log To Console    ${vf_name}   
 Import The VF   
    log to console  starting test Import The VF 
    ${vf_name1}        Import VF     ${vsp_name_${SCN}}
    Set global Variable    ${vf_name}    ${vf_name1} 
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     vf_name_${SCN}}[${SPACE}a-zA-Z://0-9.//-_]*   vf_name_${SCN}}${SPACE}${SPACE}${SPACE} ${vf_name}   
    Log To Console    ${vf_name}
 Import The VF Preload  
	log to console  starting test Import The VF 
	${vf_name}        Import VF Preload     ${vsp_namePreload}
	Set global Variable    ${vf_namePreload}    ${vf_name} 
	common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     vf_namePreload}[${SPACE}a-zA-Z://0-9.//-_]*   vf_namePreload}${SPACE}${SPACE}${SPACE} ${vf_namePreload} 
	Log To Console    ${vf_namePreload}
	[return]  ${vf_namePreload}
 Test variable test
     test var test  
 Import The VF Complex 
    [arguments]    ${SCN}
    log to console  starting test Import The VF 
    ${vf_name_Complex}        Import VF   ${vsp_name_Complex_${SCN}}
    Set Global Variable    ${vf_name_Complex_${SCN}}     ${vf_name_Complex} 
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot    vf_name_complex_${SCN}}[${SPACE}a-zA-Z://0-9.//-_]*   vf_name_complex_${SCN}}${SPACE}${SPACE}${SPACE} ${vf_name_Complex}   
    Log To Console    ${vf_name_Complex_${SCN}} 
 Import The VF Update
    [arguments]    ${SCN}
    log to console  starting test Import The VF 
    ${vf_name_Update}        Import VF  ${vsp_name_Update_${SCN}}
    Set Global Variable    ${vf_name_Update_${SCN}}     ${vf_name_Update} 
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot    vf_name_Update_${SCN}}[${SPACE}a-zA-Z://0-9.//-_]*   vf_name_Update_${SCN}}${SPACE}${SPACE}${SPACE} ${vf_name_Update}   
    Log To Console    ${vf_name_Update_${SCN}} 
Update The VF Update
    [arguments]    ${SCN}
    log to console  starting test Import The VF 
    ${vf_name_Update}        Update VF   ${vsp_name_Update_${SCN}}
    Set Global Variable    ${vf_name_Update_${SCN}}     ${vf_name_Update} 
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot    vf_name_Update_${SCN}}[${SPACE}a-zA-Z://0-9.//-_]*   vf_name_Update_${SCN}}${SPACE}${SPACE}${SPACE} ${vf_name_Update}   
    Log To Console    ${vf_name_Update_${SCN}} 
 Import The VF Complex Fabric
    [arguments]    ${SCN}
    log to console  starting test Import The VF 
    #Set Global Variable     ${vsp_name_Fabric_${SCN}}   ${vsp_name_Fabric_${SCN}}   
    ${vf_name_Fabric1}        Import VF Fabric     ${vsp_name_Fabric_${SCN}}
    Set Global Variable    ${vf_name_Fabric_${SCN}}     ${vf_name_Fabric1} 
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot    vf_name_Fabric_${SCN}}[${SPACE}a-zA-Z://0-9.//-_]*   vf_name_Fabric_${SCN}}${SPACE}${SPACE}${SPACE} ${vf_name_Fabric1}   
    Log To Console    ${vf_name_Fabric_${SCN}} 
Create New Service Fabric
    [Arguments]  ${SCN}
    log to console  starting test create new service test
    Log To Console     vf name first is ${vf_name}
   ${service_name_Fabric}  Create New Service Complex Fabric configuration
   Set Global Variable    ${service_name_Fabric1}    ${service_name_Fabric}    
   log to console  servive name for vnf is${service_name_Fabric1}
   ${flag}  set variable  1
   Set Global Variable    ${flag} 
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_Fabric_${SCN}}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_Fabric_${SCN}}${SPACE}${SPACE}${SPACE}${service_name_Fabric} 
   log to console  service name run value now is${service_name_Fabric}
  # common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_Run}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_Run}${SPACE}${SPACE}${SPACE} ${service_name_Run} 
    [return]    ${service_name_Fabric}
# check canvas element link service creation
     # Create New Service Complex Fabric configuration
Create New Service Network model flow 
      [arguments]   ${netItr}
     ${service_name_SRIOV1}  Create New Service Network model SRIOV New  ${netItr}
      Set global Variable   ${xCount}     0
      Set global Variable     ${yCount}    40
     Set Global Variable  ${service_name_SRIOV_${SCN}_${netItr}}    ${service_name_SRIOV1}
     ${flag}  set variable  1
     Set Global Variable    ${flag} 
     common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_SRIOV_${SCN}_${netItr}}[${SPACE}a-zA-Z://0-9.-_]*   service_name_SRIOV_${SCN}_${netItr}}${SPACE}${SPACE}${SPACE} ${service_name_SRIOV} 
     [return]   ${service_name_SRIOV_${SCN}_${netItr}} 
Create New Service OVS Network model flow
    [arguments]  ${netItr}
     ${service_name_OVS1}   Create New Service ovs model   ${netItr}
      Set Global Variable    ${service_name_OVS}    ${service_name_OVS1} 
     ${flag}  set variable  1
     Set Global Variable    ${flag} 
     common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_OVS_${SCN}_${netItr}}[${SPACE}a-zA-Z://0-9.-_]*  service_name_OVS_${SCN}_${netItr}}${SPACE}${SPACE}${SPACE} ${service_name_OVS1} 
     [return]   ${service_name_OVS1} 
Create New OAM Network model flow
      ${service_name_OAM}  Create New Service OAM Network model
     ${service_name_OAM}=  Set Global Variable    ${service_name_OAM}
     ${flag}  set variable  1
     Set Global Variable    ${flag} 
     common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_OAM}[${SPACE}a-zA-Z://0-9.-_]*   service_name_OAM}${SPACE}${SPACE}${SPACE} ${service_name_OAM}    
     [return]      ${service_name_OAM}     
delete checkout items
    log to console  starting test delete checkout items
    Wait Until Keyword Succeeds   10x  5s       clear checkout items
    clear checkout items     

 Create New Service Network Test
   [arguments]   ${netItr}
   ${serviceNameNetwork}  Create New Service Network   ${netItr}
    #${serviceNameNetwork}=  Set global Variable  ${serviceNameNetwork} 
    log to console   serviceNameNetwork is ${serviceNameNetwork}
     ${flag}  set variable  1
     Set Global Variable    ${flag} 
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     serviceNameNetwork_${SCN}_${netItr}}[${SPACE}a-zA-Z://0-9.//,-_]*   serviceNameNetwork_${SCN}_${netItr}}${SPACE}${SPACE}${SPACE} ${serviceNameNetwork}
    [return]  ${serviceNameNetwork}
     
Create New Service Complex Linking Driver
    [Arguments]  ${vnf1}  ${vnf2}
    log to console  starting test create new service test
    Log To Console     vf name first is ${vf_name}
   ${service_name_complex}  Create New Service Complex      ${vnf1}      ${vnf2}
   Set Global Variable    ${service_name_complex}  ${service_name_complex}  
   log to console  servive name for vnf is${service_name_complex}
   ${flag}  set variable  1
   Set Global Variable    ${flag} 
    #common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_complex_${SCN}}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_complex_${SCN}}${SPACE}${SPACE}${SPACE} ${service_name_complex} 
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_complex_linked}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_complex_linked}${SPACE}${SPACE}${SPACE} ${service_name_complex} 
   log to console  service name run value now is ${service_name_complex} 
  # common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_Run}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_Run}${SPACE}${SPACE}${SPACE} ${service_name_Run} 
    [return]    ${service_name_complex} 

 Create New Service Preload
    #[Arguments]  ${SCN}
    log to console  starting test create new service test
    Log To Console     vf name first is ${vf_namePreload}
   ${service_name1}  Create New Service    ${vf_namePreload}
   Set Global Variable    ${service_name1}    ${service_name}  
   log to console  servive name for vnf is ${service_name} 
  # ${serviceNameNetwork}=  Set global Variable    ${service_name}  
   ${flag}  set variable  1
   Set Global Variable    ${flag} 
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_Preload}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_Preload}${SPACE}${SPACE}${SPACE} ${service_name1}
   Set global Variable  ${service_name2}  ${service_name1}  
   Set global Variable  ${service_name_Run}  ${service_name1} 
   log to console  service name run value now is ${service_name_Run} 
   Set Global Variable    ${service_name_Run_Preload}    ${service_name1}   
   common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_Run_Preload}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_Run_Preload}${SPACE}${SPACE}${SPACE} ${service_name_Run} 
    [return]    ${service_name2}     
Create New Service Test
    log to console  starting test create new service test
    Log To Console     vf name first is ${vf_name_${SCN}}
   ${service_name1}  Create New Service     ${vf_name_${SCN}}
   ${flag}  set variable  1
   Set Global Variable    ${flag} 
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_${SCN}}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_${SCN}}${SPACE}${SPACE}${SPACE} ${service_name1}
   Set global Variable  ${service_name2}  ${service_name1}  
   Set global Variable  ${service_name_Run}  ${service_name1} 
   log to console  service name run value now is ${service_name_Run} 
   common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_Run_${SCN}}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_Run_${SCN}}${SPACE}${SPACE}${SPACE} ${service_name_Run} 
    [return]    ${service_name2} 
Create New Service Complex Driver
    [Arguments]  ${vf_complex_name}  ${vnf1}
    log to console  starting test create new service test
    Log To Console     vf name first is ${vf_name}
   ${service_name1}  Create New Service    ${vf_complex_name}
   ${flag}  set variable  1
   Set Global Variable    ${flag} 
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_complex_${vnf1}}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_complex_${vnf1}}${SPACE}${SPACE}${SPACE} ${service_name1}
   # Set global Variable  ${service_name2}  ${service_name1}  
   # Set global Variable  ${service_name_Run}  ${service_name1} 
   # log to console  service name run value now is ${service_name_Run} 
   # common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_Run_complex_${complex_Vnf}}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_Run_complex_${complex_Vnf}}${SPACE}${SPACE}${SPACE} ${service_name_Run} 
    [return]    ${service_name1}
Create New Service Update Driver
    [Arguments]  ${vf_Update_name}  ${vnf1}
    log to console  starting test create new service test
    Log To Console     vf name first is ${vf_name}
   ${service_name1}  Create New Service    ${vf_Update_name}
   ${flag}  set variable  1
   Set Global Variable    ${flag} 
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_Update_${vnf1}}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_Update_${vnf1}}${SPACE}${SPACE}${SPACE} ${service_name1}
   # Set global Variable  ${service_name2}  ${service_name1}  
   # Set global Variable  ${service_name_Run}  ${service_name1} 
   # log to console  service name run value now is ${service_name_Run} 
   # common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_Run_complex_${complex_Vnf}}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_Run_complex_${complex_Vnf}}${SPACE}${SPACE}${SPACE} ${service_name_Run} 
    [return]    ${service_name1}
        
Create New Service Test Preload
    [Arguments]  ${vf_namePreload}
    Set Global Variable    ${vf_name}   ${vf_namePreload} 
    log to console  starting test create new service test
    Log To Console     vf name first is ${vf_name}
   ${flag}  set variable  1
   Set Global Variable    ${flag} 
    common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot    service_name_Preload}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_Preload}${SPACE}${SPACE}${SPACE} ${service_namePreload} 
   Set global Variable  ${service_name2}  ${service_namePreload}  
   Set global Variable  ${service_name_Run_Preload}  ${service_namePreload} 
   log to console  service name run value now is ${service_name_Run} 
   common find replace    elementName    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_Run_Preload}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_Run_Preload}${SPACE}${SPACE}${SPACE} ${service_name_Run_Preload} 
    [return]    ${service_namePreload} 
Create New Service Flexware
    log to console  starting test create new service test
    Log To Console     vf name first is  ${vf_name}
   ${service_name_flexware}  Create New Service    ${vf_name}
   ${serviceNameNetwork}=  Set Variable    ${service_name_flexware}  
   ${flag}  set variable  1
   Set Global Variable    ${flag}    
    common find replace    replacing service_name_flexware    ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot     service_name_flexware_${SCN}}[${SPACE}a-zA-Z://0-9.//,-_]*   service_name_flexware_${SCN}}${SPACE}${SPACE}${SPACE} ${service_name_flexware} 
    [return]       ${service_name_flexware}  
Change User Role for testing
    [Arguments]   ${asdc_userrole}
 
    Change User Role  ${asdc_userrole} 
    #sleep  5s
Test The Service
    [arguments]    ${ServiceNameArgument}
    Test Service    ${ServiceNameArgument}
    # [arguments]   ${netItr}  ${type}   ${ServiceName}  ${serviceNameNetwork}
    # log to console  starting test test the service
    # Log To Console    service name for vnf network is ${service_name} 
    # log to console   serviceNameNetwork for network is ${serviceNameNetwork}
    # log to console   flag is ${flag}
    # log to console   value of service network iteration is ${serviceNameNetwork_${SCN}_${netItr}}
    # Run Keyword If    '${type}'=='vnf'    Test Service    ${service_name}   
    # ...  ELSE IF  '${type}'=='network' and '${flag}'=='0'   Test Service    ${serviceNameNetwork${netItr}}  #value is ${serviceNameNetwork${netItr}}
    # ...  ELSE    Test Service   ${serviceNameNetwork}  #value now is ${serviceNameNetwork}    #

Approve The Service
          [arguments]   ${ServiceNameArgument} 
          Approve service    ${ServiceNameArgument} 
      # [arguments]   ${netItr}  ${type}    ${ServiceName}  ${serviceNameNetwork}
      # log to console   starting test approve the service
      # Run Keyword If    '${type}'=='vnf'     Approve service    ${service_name}   
       # ...  ELSE IF  '${type}'=='network' and '${flag}'=='0'     Approve service   ${serviceNameNetwork${netItr}} 
       # ...    ELSE  Approve service   ${serviceNameNetwork}  

    
Distribute The Service
       [arguments]     ${ServiceNameArgument} 
        Get and update model values   ${ServiceNameArgument} 
      # [arguments]  ${netItr}   ${type}    ${ServiceName}   ${serviceNameNetwork}
    # log to console  starting test distribute the service
       # Run Keyword If    '${type}'=='vnf'     Get and update model values     ${service_name}   
       # ...  ELSE IF  '${type}'=='network' and '${flag}'=='0'      Get and update model values    ${serviceNameNetwork${netItr}} 
       # ...    ELSE   Get and update model values    ${serviceNameNetwork}

   # Log To Console     ${model_UUID}   
   # Log To Console    ${model_IUUID}     
  # #  set global variable    ${ASDC_MODEL}
Test The Service OVS
        [arguments]    ${ServiceNameArgument}
       Test Service    ${ServiceNameArgument}
    # [arguments]   ${netItr}  ${type}   ${ServiceName}  ${serviceNameNetwork}
    # log to console  starting test test the service
    # Log To Console    service name for vnf network is ${service_name} 
    # log to console   serviceNameNetwork for network is ${serviceNameNetwork}
      # log to console   value of service network iteration is ${service_name_OVS_${SCN}_${netItr}}
    # Run Keyword If    '${type}'=='vnf'    Test Service    ${service_name}   
    # ...  ELSE IF  '${type}'=='network' and '${flag}'=='0'   Test Service    ${service_name_OVS_${SCN}_${netItr}}  #value is ${serviceNameNetwork${netItr}}
    # ...  ELSE    Test Service   ${serviceNameNetwork}  #value now is ${serviceNameNetwork}    #

Approve The Service OVS  
    [arguments]    ${ServiceNameArgument}
    Approve Service     ${ServiceNameArgument}
      # [arguments]   ${netItr}  ${type}    ${ServiceName}  ${serviceNameNetwork}
      # log to console   starting test approve the service
      # Run Keyword If    '${type}'=='vnf'     Approve service    ${service_name}   
       # ...  ELSE IF  '${type}'=='network' and '${flag}'=='0'     Approve service  ${service_name_OVS_${SCN}_${netItr}}
       # ...    ELSE  Approve service   ${serviceNameNetwork}  

    
Distribute The Service oVS
        [arguments]    ${ServiceNameArgument}
    Distribute Service    ${ServiceNameArgument}
    # [arguments]  ${netItr}   ${type}    ${ServiceName}   ${serviceNameNetwork}
    # log to console  starting test distribute the service
       # Run Keyword If    '${type}'=='vnf'     Get and update model values     ${service_name}   
       # ...  ELSE IF  '${type}'=='network' and '${flag}'=='0'      Get and update model values    ${service_name_OVS_${SCN}_${netItr}}
       # ...    ELSE   Get and update model values    ${serviceNameNetwork}

   # Log To Console     ${model_UUID}   
   # Log To Console    ${model_IUUID}     
  # #  set global variable    ${ASDC_MODEL}
Test The Service SRIOV
    
    [arguments]    ${ServiceNameArgument}
    Approve Service     ${ServiceNameArgument}
    # [arguments]   ${netItr}  ${type}   ${ServiceName}  ${serviceNameNetwork}
    # log to console  starting test test the service
    # Log To Console    service name for vnf network is ${service_name} 
    # log to console   serviceNameNetwork for network is ${serviceNameNetwork}
    # log to console   flag is ${flag}
    # log to console   value of service network iteration is ${service_name_SRIOV_${SCN}_${netItr}}
    # Run Keyword If    '${type}'=='vnf'    Test Service    ${service_name}   
    # ...  ELSE IF  '${type}'=='network' and '${flag}'=='0'   Test Service    ${service_name_SRIOV_${SCN}_${netItr}}  #value is ${serviceNameNetwork${netItr}}
    # ...  ELSE    Test Service   ${serviceNameNetwork}  #value now is ${serviceNameNetwork}    #

Approve The Service SRIOV
        [arguments]    ${ServiceNameArgument}
        Approve Service     ${ServiceNameArgument}
      # [arguments]   ${netItr}  ${type}    ${ServiceName}  ${serviceNameNetwork}
      # log to console   starting test approve the service
      # Run Keyword If    '${type}'=='vnf'     Approve service    ${service_name}   
       # ...  ELSE IF  '${type}'=='network' and '${flag}'=='0'     Approve service  ${service_name_SRIOV_${SCN}_${netItr}}
       # ...    ELSE  Approve service   ${serviceNameNetwork}  

    
Distribute The Service SRIOV
            [arguments]    ${ServiceNameArgument}
            Distribute Service    ${ServiceNameArgument}
    # [arguments]  ${netItr}   ${type}    ${ServiceName}   ${serviceNameNetwork}
    # log to console  starting test distribute the service
    # Run Keyword If    '${type}'=='vnf'     Get and update model values     ${service_name}   
       # ...  ELSE IF  '${type}'=='network' and '${flag}'=='0'      Get and update model values    ${service_name_SRIOV_${SCN}_${netItr}}
       # ...    ELSE   Get and update model values    ${serviceNameNetwork}

   # Log To Console     ${model_UUID}   
   # Log To Console    ${model_IUUID}     
  #  set global variable    ${ASDC_MODEL}
  
  
Test The Service Complex
    [arguments]  ${ServiceNameComplex}
    log to console  starting test test the service
    log to console   serviceNameNetwork for network is  ${ServiceNameComplex}
    Test Service     ${ServiceNameComplex}
    
Test The Service Update
    [arguments]  ${ServiceNameUpdate}
    log to console  starting test test the service
    log to console   serviceNameNetwork for network is  ${ServiceNameUpdate}
    Test Service     ${ServiceNameUpdate}
Approve The Service complex
      [arguments]    ${ServiceNameComplex}
      log to console   starting test approve the service
      Approve service     ${ServiceNameComplex}  
Approve The Service Update
      [arguments]    ${ServiceNameUpdate}
      log to console   starting test approve the service
      Approve service     ${ServiceNameUpdate}   

    
Distribute The Service complex
      [arguments]  ${ServiceNameComplex}  ${SCN}
    log to console  starting test distribute the service
    Get and update model values complex    ${ServiceNameComplex}   ${SCN} 
 Distribute The Service Update
      [arguments]  ${ServiceNameUpdate}  ${SCN}
    log to console  starting test distribute the service
    Get and update model values Update   ${ServiceNameUpdate}   ${SCN}  
  #  set global variable    ${ASDC_MODEL}
Get and update model values complex
    [arguments]   ${serviceName}   ${SCN}
  
     ${model_UUID1}    ${model_IUUID1}   Distribute service     ${serviceName}
     Set Global Variable   ${model_UUID_Final}   ${model_UUID1}
     Set Global Variable    ${model_IUUID_Final}  ${model_IUUID1}        
   Log To Console     UUID is ${model_UUID_Final}  
   Log To Console    IUUID is ${model_IUUID_Final}
        common find replace          updating modal UUID         ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot              model_UUID_complex_${SCN}}[${SPACE}a-zA-Z://0-9.-//'-_]*                  model_UUID_complex_${SCN}}${SPACE}${SPACE}${SPACE} ${model_UUID_Final} 
    common find replace                    updating modal IUUID        ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot       model_IUUID_complex_${SCN}}[${SPACE}a-zA-Z://0-9.-//'-_]*               model_IUUID_complex_${SCN}}${SPACE}${SPACE}${SPACE} ${model_IUUID_Final}
Get and update model values Update
    [arguments]   ${serviceName2}   ${SCN}
  
     ${model_UUID1}    ${model_IUUID1}   Distribute service     ${serviceName2}
     Set Global Variable   ${model_UUID_Final}   ${model_UUID1}
     Set Global Variable    ${model_IUUID_Final}  ${model_IUUID1}        
   Log To Console     UUID is ${model_UUID_Final}  
   Log To Console    IUUID is ${model_IUUID_Final}
        common find replace          updating modal UUID         ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot              model_UUID_Update_${SCN}}[${SPACE}a-zA-Z://0-9.-//'-_]*                  model_UUID_Update_${SCN}}${SPACE}${SPACE}${SPACE} ${model_UUID_Final} 
    common find replace                    updating modal IUUID        ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot       model_IUUID_Update_${SCN}}[${SPACE}a-zA-Z://0-9.-//'-_]*               model_IUUID_Update_${SCN}}${SPACE}${SPACE}${SPACE} ${model_UUID_Final} 
Get and update model values
    [arguments]   ${serviceName}
     ${model_UUID1}    ${model_IUUID1}   Distribute service     ${serviceName}
     Set Global Variable   ${model_UUID_Final}  ${model_UUID1}
     Set Global Variable    ${model_IUUID_Final}  ${model_IUUID1}        
   Log To Console     UUID is ${model_UUID1}   
   Log To Console    IUUID is ${model_IUUID1}
        common find replace          updating modal UUID         ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot              model_UUID}[${SPACE}a-zA-Z://0-9.-//'-_]*                  model_UUID}${SPACE}${SPACE}${SPACE} ${model_UUID_Final}  
    common find replace            updating modal IUUID        ${EXECDIR}\\robot\\resources\\SDC\\SDC_DATA.robot       model_IUUID}[${SPACE}a-zA-Z://0-9.-//'-_]*               model_IUUID}${SPACE}${SPACE}${SPACE} ${model_IUUID_Final}
Drag and Drop
    Multiple Drag and Drop  ${EXECDIR}${/}robot${/}assets${/}triggerDragandDrop.js  [data-tests-id='test1']   [data-tests-id='test2']  [data-tests-id='test3']   [data-tests-id='test4']
  
