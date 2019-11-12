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
Resource            ../resources/commonKeywords.robot
Library    json_implementation    
Library    JSONUtils 
Library    Collections  
Library    HttpLibrary.HTTP
Library    OperatingSystem    
Test Teardown    Close All Browsers     


*** Variables ***

#NC Validation
${NC_LAB_NAME}    auk51b
${GENERIC_NC_URL}                             https://dashboard-nc.${NC_LAB_NAME}.cci.att.com/auth/login/   
${NC_NETWORK_NAME}        GRP-27529-T-IST-07A_int_eastwest_net_1
${NC_STACK_NAME}          GRP-27529-T-IST-07A_sgi_direct_net_1
${NC_DOMAIN}    nc


#OR
${txtNC_domain}    //input[@id='id_domain']
${txtNC_username}    //input[@id="id_username"]
${txtNC_password}    //input[@id="id_password"]
${btnNC_Connect}    //button[@id="loginBtn"]
${lnkNC_Projects}    //ul[@id="sidebar-accordion"]//a[@data-target='#sidebar-accordion-project']
${lnkNC_Network}    //ul[@id="sidebar-accordion"]//a[@data-target='#sidebar-accordion-project-network']
${lnkNC_Networks}    //ul[@id="sidebar-accordion"]//a[@data-target='#sidebar-accordion-project-network']/..//a[contains(text(),'Networks')]
${txtNC_SearchButton}    //input[@name="networks__filter_project_networks__q"]
${tblNC_activeNetwork}    //*[contains(text(),'${NC_NETWORK_NAME}')]/ancestor::tr[contains(@id,'networks__row__')]//td[contains(text(),'Active')]
${lnkNC_orchestration}    //ul[@id="sidebar-accordion"]//a[@data-target='#sidebar-accordion-project-orchestration']
${lnkNC_stacks}    //ul[@id="sidebar-accordion"]//a[@data-target='#sidebar-accordion-project-orchestration']/..//a[contains(text(),'Stacks')]
${tblNC_createCompleteStack}    //*[contains(text(),'${NC_STACK_NAME}')]/ancestor::tr[contains(@id,'stacks__row__')]//td[contains(text(),'Create Complete')]
*** Test Cases ***

NC Validation at UI - Network
    [Documentation]    NC Validation for Network
    #[Argument]    ${NC_NETWORK_NAME}
    Log To Console    Starting the execution for NC Validation for Network
   
        Open Browser    ${GENERIC_NC_URL}    ff
    Wait Until Page Contains Element    //input[@id="id_domain"]
    
    Common Input Text    Enter the Domain   ${txtNC_domain}     ${NC_DOMAIN}
    ${USERNAME}    common get username
    ${PASSWORD}    common get password 
    Common Input Text    Enter Username    ${txtNC_username}    ${USERNAME}
    Common Input Text    Enter Password    ${txtNC_password}    ${PASSWORD}
    

    Common Click Element    Click on the Connect Button    ${btnNC_Connect}
    
    Common Click Element    Click on the Projects sidebar menu to expand    ${lnkNC_Projects}
    Common Click Element    Click on the Network sidebar menu to expand    ${lnkNC_Network}
    Common Click Element    Click on the Networks    ${lnkNC_Networks}
    Wait Until Page Contains Element    ${txtNC_SearchButton}     100   
#    Common Input Text    Enter the Stack Name to Search    //input[@name="networks__filter_project_networks__q"]    ${NC_NETWORK_NAME}
    
    ${STATUS}    Run Keyword And Return Status        Wait Until Page Contains Element      ${tblNC_activeNetwork}  
    Run Keyword If    "${STATUS}"!="True"    Fail    msg=Status is not Active for the Network - ${NC_NETWORK_NAME}
    ...    ELSE    Pass Execution    Network found with Active status

    
NC Validation at UI - Stack
    [Documentation]    NC Validation for Stacks    
    #[Argument]    ${NC_STACK_NAME}
    Log To Console    Starting the execution for NC Validation for Stack

    Open Browser    ${GENERIC_NC_URL}    ff
    Wait Until Page Contains Element    //input[@id="id_domain"]
    
    Common Input Text    Enter the Domain   ${txtNC_domain}     ${NC_DOMAIN} 
     
    ${USERNAME}    common get username
    ${PASSWORD}    common get password 
    Common Input Text    Enter Username    ${txtNC_username}    ${USERNAME}
    Common Input Text    Enter Password    ${txtNC_password}    ${PASSWORD}
    
    
    Common Click Element    Click on the Connect Button    ${btnNC_Connect}
    
    Common Click Element    Click on the Projects sidebar menu to expand    ${lnkNC_Projects}
    Common Click Element    Click on the Orchestration sidebar menu to expand    ${lnkNC_orchestration}    
    Common Click Element    Click on the Stacks    ${lnkNC_stacks}
#    Common Input Text    Enter the Stack Name to Search    //input[@name="stacks__filter__q"]    ${NC_STACK_NAME}    
    
    ${STATUS}    Run Keyword And Return Status        Wait Until Page Contains Element    ${tblNC_createCompleteStack}
    Run Keyword If    "${STATUS}"!="True"    Fail    msg=Status is not Create Complete for the Stack - ${NC_STACK_NAME}
    ...    ELSE    Pass Execution    Stack found with Create Complete status
            
            




    
*** Keywords ***


NC Validation for Network
    [Documentation]    NC Validation for Network
    #[Argument]    ${NC_NETWORK_NAME}
    Log To Console    Starting the execution for NC Validation for Network

        Open Browser    ${GENERIC_NC_URL}    ff
    Wait Until Page Contains Element    //input[@id="id_domain"]
    
    Common Input Text    Enter the Domain   ${txtNC_domain}     ${NC_DOMAIN}
    ${USERNAME}    common get username
    ${PASSWORD}    common get password 
    Common Input Text    Enter Username    ${txtNC_username}    ${USERNAME}
    Common Input Text    Enter Password    ${txtNC_password}    ${PASSWORD}
    

    Common Click Element    Click on the Connect Button    ${btnNC_Connect}
    
    Common Click Element    Click on the Projects sidebar menu to expand    ${lnkNC_Projects}
    Common Click Element    Click on the Network sidebar menu to expand    ${lnkNC_Network}
    Common Click Element    Click on the Networks    ${lnkNC_Networks}
    Wait Until Page Contains Element    ${txtNC_SearchButton}     100   
#    Common Input Text    Enter the Stack Name to Search    //input[@name="networks__filter_project_networks__q"]    ${NC_NETWORK_NAME}
    
    ${STATUS}    Run Keyword And Return Status        Wait Until Page Contains Element      ${tblNC_activeNetwork}  
    Run Keyword If    "${STATUS}"!="True"    Fail    msg=Status is not Active for the Network - ${NC_NETWORK_NAME}
    ...    ELSE    Pass Execution    Network found with Active status

    
NC Validation for Stack
    [Documentation]    NC Validation for Stacks    
    #[Argument]    ${NC_STACK_NAME}
    Log To Console    Starting the execution for NC Validation for Stack

    Open Browser    ${GENERIC_NC_URL}    ff
    Wait Until Page Contains Element    //input[@id="id_domain"]
    
    Common Input Text    Enter the Domain   ${txtNC_domain}     ${NC_DOMAIN} 
     
    ${USERNAME}    common get username
    ${PASSWORD}    common get password 
    Common Input Text    Enter Username    ${txtNC_username}    ${USERNAME}
    Common Input Text    Enter Password    ${txtNC_password}    ${PASSWORD}
    

    Common Click Element    Click on the Connect Button    ${btnNC_Connect}
    
    Common Click Element    Click on the Projects sidebar menu to expand    ${lnkNC_Projects}
    Common Click Element    Click on the Orchestration sidebar menu to expand    ${lnkNC_orchestration}    
    Common Click Element    Click on the Stacks    ${lnkNC_stacks}
#    Common Input Text    Enter the Stack Name to Search    //input[@name="stacks__filter__q"]    ${NC_STACK_NAME}    
    
    ${STATUS}    Run Keyword And Return Status        Wait Until Page Contains Element    ${tblNC_createCompleteStack}
    Run Keyword If    "${STATUS}"!="True"    Fail    msg=Status is not Create Complete for the Stack - ${NC_STACK_NAME}
    ...    ELSE    Pass Execution    Stack found with Create Complete status
            
                    