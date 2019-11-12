*** Settings ***

Resource       ../resources/vid/vid_interface.robot
Library        SeleniumLibrary
Library        OperatingSystem
Library        Collections
Library        String
Library        Process
#Library        ../library/myLibraries/Replace.py
Library	       UUID      
Library	       Screenshot
Library        DateTime  
Resource      ../resources/commonKeywords.robot 
Resource      ../resources/global_properties.robot
Resource      ../resources/browser_setup.robot
Resource      ../resources/portal/PORTAL_RESOURCE.robot
Resource      ../resources/EIPAM/EIPAM_RESOURCE.robot
Resource      ../resources/EIPAM/EIPAM_OR.robot
Resource      ../resources/EIPAM/EIPAM_DATA.robot

*** Variables ***




*** Test Cases ***

IP Additon

     Login To Ecomp Portal
     Launch Application and Validate     EIPAM
     ${randomStringforVRFName}    Generate Random String for VRF   
     ${RandomNewString}  Adding Pool Details     ${randomStringforVRFName}

# Check 
    # Adding Pool Details Check 