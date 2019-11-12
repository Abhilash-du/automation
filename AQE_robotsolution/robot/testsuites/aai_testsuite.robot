
*** Settings ***
Resource            ../resources/aai/AAI_RESOURCE.robot
Resource            ../resources/global_properties.robot
Resource            ../resources/browser_setup.robot
Resource             ../resources/aai/aai_data.robot
Library            Process

*** Variable ***
${REPORT_COMMAND_INIT}    com.amdocs.auto.framework.Run -c initHTMLReportFile -p "reportName=test_report06.html&reportLocation=test_reports&reportTitle=ECOMP Test Report"
${REPORT_JAR_PATH}    java    -jar    "${EXECDIR}\\robot\\library\\myLibraries\\auto_framework_utilities.jar"
  
*** Test Cases ***


A&AI Health Check
    [Documentation]    Runs A&AI Health Check
    Run A&AI Health Check

    
A&AI Put Request simple
    [Documentation]    Basic A&AI Put Request. Requires 3 Arguments. 1st Resource Path and 2nd Entity ID and 3rd Payload Data in correct Json Syntax
    Set Log Level    DEBUG
    Run A&AI Put Request Basic    /cloud-infrastructure/pservers/pserver/    abcde    {"in-maint":true}
    
         
A&AI Put Request jsonfile
    [Documentation]    Basic A&AI Get Request from a text file. Requires 2 Arguments. 1st Resource Path and 2nd Entity ID and 3rd Payload FIle Name
    Set Log Level    DEBUG
    Run A&AI Put Request   /cloud-infrastructure/pservers/pserver/    amist-GINGER-host-0    SANITY_API_CREATE_PSERVER.txt

    
Run Unix Validations
     ${dummy}    A&AI Unix Logs GET Validation    51de28a6-b81f-4a8e-bd70-47ccc2087ee3
     Log    ${dummy} 
     Log to Console    ${dummy}   
     

API Shakeout for PSERVER
    ${response}    A&AI Pserver GET Request    ${SHAKEOUT_PSERVER}
    Run Keyword If    ${response.status_code}==404    A&AI Pserver PUT Request    ${SHAKEOUT_PSERVER}    SANITY_API_CREATE_PSERVER.txt
    A&AI Pserver Update Request    ${SHAKEOUT_PSERVER}    SANITY_API_UPDATE_PSERVER.txt
    A&AI Pserver DELETE Request    ${SHAKEOUT_PSERVER}
    
API Shakeout for Cloud Region  
    ${response}    A&AI CLOUD_REGION GET Request    ${SHAKEOUT_CLOUD-REGION}
    Run Keyword If    ${response.status_code}==404    A&AI CLOUD_REGION PUT Request    ${SHAKEOUT_CLOUD-REGION}    SANITY_API_CREATE_CLOUD-REGION.txt
    A&AI CLOUD_REGION Update Request    ${SHAKEOUT_CLOUD-REGION}    SANITY_API_UPDATE_CLOUD-REGION.txt
    A&AI CLOUD_REGION DELETE Request    ${SHAKEOUT_CLOUD-REGION}
    
API Shakeout for Generic Vnf
    ${response}    A&AI Generic_Vnf GET Request    ${SHAKEOUT_GENERIC_VNF}
    Run Keyword If    ${response.status_code}==404    A&AI Generic_Vnf PUT Request    ${SHAKEOUT_GENERIC_VNF}    SANITY_API_CREATE_Generic-Vnf.txt
    A&AI Generic_Vnf Update Request    ${SHAKEOUT_GENERIC_VNF}    SANITY_API_UPDATE_Generic-Vnf.txt
    A&AI Generic_Vnf DELETE Request    ${SHAKEOUT_GENERIC_VNF}

API Shakeout for Complex
    ${response}    A&AI COMPLEX GET Request    ${SHAKEOUT_COMPLEX}
    Run Keyword If    ${response.status_code}==404    A&AI COMPLEX PUT Request    ${SHAKEOUT_COMPLEX}    SANITY_API_CREATE_Generic-Vnf.txt
    A&AI COMPLEX Update Request    ${SHAKEOUT_COMPLEX}    SANITY_API_UPDATE_Generic-Vnf.txt
    A&AI COMPLEX DELETE Request    ${SHAKEOUT_COMPLEX}

    #Shakeout for Tenant With Relationship
    #TODO
    #Tenant With Relationship

Run A&AI UI Shakeout
    [Documentation]    A&AI UI Shakeout.It Consists of 2 TCs. Namely, UI Basic Validations and UI Connectivity Validations.
    
    #A&AI UI Basic Validation
    A&AI UI Basic Validations
    #A&AI UI Data Connectivity Valdidations
    A&AI UI Data Connectivity Validations  


Run Linux Feed Files Validations
    #Requires 1 argument of feed file name i.e. NETDB or RCT
    A&AI Linux Input Feed Files Validations    RCT
    A&AI Linux Input Feed Files Validations    NETDB

Run Linux Pickup Files Validations
    #Requires 1 argument of pickup file name i.e. GFP_IP, INSTAR_DCAE_PMOSS, RUBY or GCP
    A&AI Linux Output Pickup Files Validations    GFP_IP
    A&AI Linux Output Pickup Files Validations    INSTAR_DCAE_PMOSS
    A&AI Linux Output Pickup Files Validations    RUBY
    A&AI Linux Output Pickup Files Validations    GCP 
    
Shakeout Linux Test Cases
    Run Process    java    -jar    "${EXECDIR}\\robot\\library\\myLibraries\\auto_framework_utilities.jar" com.amdocs.auto.framework.Run -c initHTMLReportFile -p "reportName=test_report06.html&reportLocation=test_reports&reportTitle=ECOMP Test Report"
    #Run Process    ${REPORT_JAR_PATH}    ${REPORT_COMMAND_INIT}
    