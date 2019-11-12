*** Settings ***
Resource            ../resources/vid/vid_interface.robot
#Resource            ../resources/portal/portal_interface.robot
Resource            ../resources/global_properties.robot
Resource            ../resources/browser_setup.robot
#Suite Teardown      Close Agents    


*** Variable ***



*** Test Cases ***   
VID HealthCheck
    #Running the basic VID HealthCheck. Requires 0 Arguments.Can only be ran on ATT Machines. Proxy Wont Work here.
    Run VID Health Check


Go To VID Home
    #Running the Test Case to Launch VID Directly.
    Go To VID Home


Launch Ecomp Portal
    Login To Ecomp Portal


    
Network Creation through VID
    Login To Ecomp Portal
    #This Keyword is for Loginin to ECOMP Portal
    Launch Application and Validate    VID
    #This Keyword is for Launch the particular Application and perform the basic Validations. Requires 1 argument as Application Name.
    Select Test API    GR_API
    #Requires 1 argument to select the Test API in Use. GR_API or VNF_API
    VID Network Creation    d325a6ad-ce31-4ce7-b81e-44ef3e52759a       APP-C-24595-T-IST-05A-COM-TOAM0_net_ms87820s     #APP-C-24595-T-IST-05A_vcom_mngt_01     
    #This keyword is for Creating a network. Includes 2 Keywords. 1st Instance Creation. 2nd Network Creation.
    #Instance Creation Requires 1 Argument as Model UUID.
    #N/W creation requires Instance name That is same as the N/W Preload Name.
    #Arguments Required 2. 1st Model UUID. 2nd Network Name from SDN Portal


VNF Creation through VID
    Login To Ecomp Portal
    #This Keyword is for Loginin to ECOMP Portal
    Launch Application and Validate    VID
    #This Keyword is for Launch the particular Application and perform the basic Validations. Requires 1 argument as Application Name.
    Select Test API    GR_API
    #Requires 1 argument to select the Test API in Use. GR_API or VNF_API
    VID VNF Creation    64484e12-5c8c-493c-b301-a9cd1f82e5fe    
    #This keyword is for Creating a network. Includes 2 Keywords. 1st Instance Creation. 2nd Network Creation.
    #Instance Creation Requires 1 Argument as Model UUID.
    #N/W creation requires Instance name That is same as the N/W Preload Name.
    #Arguments Required 2. 1st Model UUID. 2nd Network Name from SDN Portal    

Base VF Module Creation through VID
    Login To Ecomp Portal
    #This Keyword is for Loginin to ECOMP Portal
    Launch Application and Validate    VID
    #This Keyword is for Launch the particular Application and perform the basic Validations. Requires 1 argument as Application Name.
    Select Test API    GR_API
    #Requires 1 argument to select the Test API in Use. GR_API or VNF_API
    Create VID BASE VF module     8662002d-9768-4cb3-8ee3-d3c6439d595f    #VEDPG
    #Requires 1 argument as the Service Instance ID

AddOn VF Module Creation through VID
    Login To Ecomp Portal
    #This Keyword is for Loginin to ECOMP Portal
    Launch Application and Validate    VID
    #This Keyword is for Launch the particular Application and perform the basic Validations. Requires 1 argument as Application Name.
    Select Test API    GR_API
    #Requires 1 argument to select the Test API in Use. GR_API or VNF_API
    Create VID AddOn VF module     23037448-1a45-4ef8-a393-9c45b050d5f8    #APNDNS
    #Requires 1 argument as the Service Instance ID

Volume Group Addition through VID
    Login To Ecomp Portal
    #This Keyword is for Loginin to ECOMP Portal
    Launch Application and Validate    VID
    #This Keyword is for Launch the particular Application and perform the basic Validations. Requires 1 argument as Application Name.
    Select Test API    GR_API
    #Requires 1 argument to select the Test API in Use. GR_API or VNF_API
    Add Volume Group VID    8662002d-9768-4cb3-8ee3-d3c6439d595f
    #Requires 1 argument as the Service Instance ID
        
    