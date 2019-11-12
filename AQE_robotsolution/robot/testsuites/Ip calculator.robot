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
Resource             ../resources/IP Calculation And Preload.robot
Resource            CLAMP_Regression.robot
Resource            ../resources/commonKeywords.robot
Resource            Driver_ASDC.robot
Resource            aai_testsuite.robot
Library             callReporter
Library             testScreenshot
Library             testLib
Library             ../../properties/global_properties.py

Library             SeleniumLibrary
Test Setup          Authentication
Test Teardown       Copy Logs       ${EXECDIR}    ${SUITE NAME}

*** Test Cases ***
calculate ip
    launch Ip calculator