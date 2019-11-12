*** Settings ***


Resource    ../resources/DCAE/dcae_data.robot
Resource    ../resources/DCAE/dcae_Interface.robot
Resource    ../resources/DCAE/dcae_OR.robot
Resource    ../../resources/aai/AAI_RESOURCE.robot

Test Teardown    Close All Browsers

*** Variables ***



*** Test Cases ***
PreRequisites
    Run A&AI Get Request    /nodes/vservers?vserver-name=    tempest-virtualinterfacestestjson-server-1739476718   
Nagios GUI
    Nagios GUI (Prerequisite Check)    ${nagiosusername}    ${nagiospassword}    ${nagiossamurl}    ${vserver}
Guest OS FM Flow
    ${text}    Generating CRITICAL Alarm    ${nagiosusername}    ${nagiospassword}    ${nagiossamurl}    ${vserver}    ${alarmforservice}
    SAM Event    ${text}    ${vserver}    ${alarmforservice}
HP Normalizer
    HP Normalizer