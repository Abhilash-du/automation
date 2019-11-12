*** Settings ***
Library    SeleniumLibrary
        
Library    String 
Library    OperatingSystem    
Library 	      RequestsLibrary
Resource          ../resources/DCAE/DCAE_RESOURCE.robot
Resource    ../resources/DCAE/dcae_data.robot
Resource    ../resources/DCAE/dcae_OR.robot
Resource    ../resources/aai/AAI_RESOURCE.robot

*** Test Cases ***
DCAE_Shakeout_Flow
    Connectivity test
    Connectivity Test Using Snmp
    Run A&AI Get Request - Keyword
    Run FIDB
    Microservices Health Check   
    ${MODEL_NAME}    CLAMP Simplified Flow - Simplified_HighlandPark_Template
    Login to Policy Handler docker   ${MODEL_NAME}      #Model_RA_20190709_015247_SimpleUpload - s3   #${MODEL_NAME}
    Login to Hp Overland docker    ${MODEL_NAME}
    Policy Validation in Consul     ${MODEL_NAME}

TC1
    Connectivity test 
TC2
    Connectivity Test Using Snmp
TC3
    Run A&AI Get Request - Keyword
TC4
    Run FIDB
TC5
    Microservices Health Check     
TC6 
     ${MODEL_NAME}    CLAMP Simplified Flow - Simplified_HighlandPark_Template
    Login to Policy Handler docker   ${MODEL_NAME}      #Model_RA_20190709_015247_SimpleUpload - s3   #${MODEL_NAME}
    Login to Hp Overland docker    ${MODEL_NAME}
    Policy Validation in Consul     ${MODEL_NAME}     

	
	
PreRequisites
    Run A&AI Get Request    /nodes/vservers?vserver-name=    tempest-virtualinterfacestestjson-server-1739476718   
Nagios GUI
    Nagios GUI (Prerequisite Check)
Guest OS FM Flow
    ${text}    Generating CRITICAL Alarm
    ${topic}    SAM Event    ${text}
    ${hptag}    HP NormalizerOROverland    ${text}    ${topic}
    ${EPhpTAG}    Event Processor    ${text}    ${hptag}
    Publish To Ruby    ${EPhpTAG}