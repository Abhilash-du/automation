*** Settings ***
Resource    ../resources/NC/input_keywords.robot
Library     SeleniumLibrary    
Library    String    
*** Test Cases ***

NC SRIOV
    NC SRIOV

*** Keywords ***
NC SRIOV
    Set Selenium Implicit Wait      380s
    login to portal
    Goto VID
    Browse ASDC Model And Deploy
    select input frame
    Wait Until Page Contains Element    //span[@data-tests-id="create-modal-title"]
    ${random}  Generate Random String    8     
    set instance name  ${instanceName}_${random}
    select subscriber name
    set instance name  ${instanceName}_${random}
    select service type
    select owining entity
    select project
    click on set button
    select vid frame
    select input vnf
    click on SRIOV NET_1
    Wait Until Page Contains Element                  //sdc-loader[@ng-reflect-active="false"]
    set instance name   ${SRIOV_net1_instance_name}
    select product family
    select LCP region
    select tenat 
    select platform
    click on set button   
    click on SRIOV NET_2
    Wait Until Page Contains Element                  //sdc-loader[@ng-reflect-active="false"]
    set instance name   ${SRIOV_net2_instance_name}
    select product family
    select LCP region
    select tenat 
    select platform
    click on set button   
    Wait Until Page Contains Element                  //sdc-loader[@ng-reflect-active="false"]
    Click on Deploy

Example
    ${random}  Generate Random String    8
    Log To Console    ${random}    