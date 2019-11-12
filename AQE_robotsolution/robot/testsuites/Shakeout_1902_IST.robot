
*** Settings ***

Resource    ../resources/CLAMP/CLAMP_RESOURCE.robot
Resource    Driver_Policy.robot
Resource    CLAMP_Regression.robot
Resource    ../resources/commonKeywords.robot
Resource   Driver_ASDC.robot
#Resource     ../resources/AAI/Shakeout/aai_shakeout.robot
Resource     aai_testsuite.robot
Library    callReporter    
Library          testScreenshot    
Library    testLib 
Library           ../../properties/global_properties.py
Library    SSHLibrary    
#Library    RequestsLibrary.RequestsKeywords     

Library    SeleniumLibrary
#test setup   Call Create File    ${EXECDIR}\\robot\\library\\myLibraries   
#test teardown  Close All Browsers
# test Teardown      Close All Browsers    
# Suite Setup         Set Log Level    DEBUG  
Test Setup          test setup config   #Delete All Cookies
Test Teardown      test teardown config
#Test Setup          Delete All Cookies
*** Variables ***
${test}

*** Keywords ***
test setup config
    Authentication
    #Delete All Cookies
test teardown config
    Copy Logs    ${EXECDIR}    ${SUITE NAME}
   # Close All Browsers
    

*** Test Cases ***


# ShakeOut Policy
    # ShakeOut Policy
# CLAMP Simplified Flow - Simplified_Template  
    # [Tags]    Simplified_Model    Shakeout  
   # CLAMP Simplified Flow - Simplified_Template
   
# CLAMP Normal Model - HighlandPark Stringmatch
    # [Tags]    Normal_Model    Shakeout 
    
    # CLAMP Normal Model - HighlandPark Stringmatch
    
Run A&AI Shakeout
    Run A&AI Shakeout
    
vnf model Creation
   [Documentation]
   ...    in test the service, approve the service and distribute the service, two parameters are passed.
   ...    first is ${netItr} which represents to the number of iterations to be run. secing one is either 
   ...    vnf or network depending upon the type of modal you are trying to create
   # ...    for vnf enter type as vnf and for network enter network
       # delete checkout items
    Change User Role for testing     DESIGNER
    Create New License Model Test
    Create New VSP - HeatFile
    Import The VF
    Create New Service Test
    delete checkout items
    Change User Role for testing     TESTER
    Test The Service                 1           vnf    ${Service_Name}
    Change User Role for testing     GOVERNOR
    Approve The Service              1           vnf    ${Service_Name}
    Change User Role for testing     OPS
    Distribute The Service           1           vnf    ${Service_Name}
    Change User Role for testing     DESIGNER
Network MOdel creation
  ${NumModelsCount}    Evaluate    ${NumModels}+1    
  :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
  \    log to console  netItr is ${netItr}
  \    change User Role for testing    DESIGNER
  \    test loop    ${netItr}   
  \  Create New Service Network Test   ${netItr}
  \   Wait Until Keyword Succeeds    5  5x        clear checkout items 
  \  Change User Role for testing        TESTER
  \  Test The Service  ${netItr}  network   ${ServiceName}
  \  Change User Role for testing    GOVERNOR
  \  Approve The Service  ${netItr}  network    ${ServiceName}
  \  Change User Role for testing    OPS
  \  Distribute The Service  ${netItr}  network   ${ServiceName}
  \  Change User Role for testing    DESIGNER


Flexware Modals creation

    Create New License Model Test
    Create New VSP - Flexware
    Import The VF - Flexware 
    Create New Service Flexware
    delete checkout items
    Change User Role for testing     TESTER
    Test The Service                 1           vnf    ${service_name_Flexware}
    Change User Role for testing     GOVERNOR
    Approve The Service              1           vnf    ${service_name_Flexware}
    Change User Role for testing     OPS
    Distribute The Service           1           vnf    ${service_name_Flexware}
    Change User Role for testing     DESIGNER
Drag and Drop
    Drag and Drop  
Change role
    Change User Role for testing    DESIGNER  
# Test Loop
  # ${NumModelsCount}    Evaluate    ${NumModels}+1    
  # :FOR  ${netItr}  IN RANGE   1     ${NumModelsCount}
    # \    log to console  itr is ${netItr}
OAM model Creation and Distribution
         # Change User Role for testing    DESIGNER 
        Create New OAM Network model flow
        delete checkout items
        Change User Role for testing        TESTER
        Test The Service  1  vnf  ${service_name_OAM}
        Change User Role for testing        GOVERNOR
        Approve The Service  1  vnf   ${service_name_OAM}
        Change User Role for testing    OPS
        Distribute The Service    1  vnf   ${service_name_OAM}
        Change User Role for testing    DESIGNER  
SRIOV Model Creation
        Create New Service Network model flow
        delete checkout items
        Change User Role for testing        TESTER
        Test The Service  1  vnf  ${service_name_SRIOV}
        Change User Role for testing        GOVERNOR
        Approve The Service  1  vnf   ${service_name_SRIOV}
        Change User Role for testing    OPS
        Distribute The Service    1  vnf   ${service_name_SRIOV}
        Change User Role for testing    DESIGNER   
       
 