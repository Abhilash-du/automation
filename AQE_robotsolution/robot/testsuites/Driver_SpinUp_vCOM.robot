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




*** Variables ***
${SERVICE_NAME}    
${EXCEL_NAME}    mgmt_vcom_net_95.xlsm
${NETWORK_NAME}    APP-C-24595-T-IST-05A-COM-TOAM0_net_99
${files}           mgmt_vcom_net_95.xlsm      #GRP-27529-T-SIL-13B_MGMT_VISBC0_net_11.xlsm   GRP-27529-T-SIL-13B_TRST_VISBC0_net_11.xlsm  GRP-27529-T-SIL-13B_UNTR_VISBC0_net_11.xlsm

*** Test Cases ***
   
    

TEST_vBGF_Network_Model
    
    ${USERNAME} =    Common Get Username
    
    # ${UUID}=           Evaluate    random.randint(100000, 999999)    random
    # ${SERVICE_NAME}    catenate    SDC_RA_SVC_${UUID}
    ${SERVICE_NAME}=      Create New Service Network model - CONTRIAL_30_Basic     # Network Model - Component from Ginger
    Log To Console    Name of Service is : ${SERVICE_NAME}
    
#    Change User Role    ${USERNAME}    TESTER

    Log to Console    Change the role to TESTER. Waiting for 15sec
    Sleep    15
    Test Service    ${SERVICE_NAME}
    
#    Change User Role    ${USERNAME}    GOVERNER
    Log to Console    Change the role to GOVERNER. Waiting for 15sec
    Sleep    15

    Approve Service    ${SERVICE_NAME}
#    Change User Role    ${USERNAME}    OPS

    Log to Console    Change the role to OPS. Waiting for 15sec
    Sleep    15
    
    @{SERVICE_DISTRIBUTION_DETAILS}    Distribute Service    ${SERVICE_NAME}
     Log To Console    First Param: @{SERVICE_DISTRIBUTION_DETAILS}[0]
     Log To Console     Second Param: @{SERVICE_DISTRIBUTION_DETAILS}[1]    
    
#    Change User Role    ${USERNAME}    DESIGNER
     Log to Console    Change the role to DESIGNER. Waiting for 15sec
    Sleep    15

Test_SDNC_ADMIN
    
     Login To Ecomp Portal
     Launch Application and Validate   SDNGC-Admin-Portal
     # Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]      300s
    Update the Network Preload Details    ${EXCEL_NAME}    ${NETWORK_NAME}
    Get the Network Preload Details    ${EXCEL_NAME}    ${NETWORK_NAME}
      Network preload upload    ${files}
Test_ASDC_VNF_MODEL
    
    
    # ${vlm_name}    ${la_name}        ${fg_name}        Create New License Model              
    # log to console    value of vlm is ${vlm_name}
    # log to console    value of la is ${la_name}
    # Set suite variable    ${vlm_name}    ${vlm_name}
    # Set suite variable    ${la_name}    ${la_name}
    # Set suite variable    ${fg_name}    ${fg_name}
    # log to console    value of vlm_name is ${vlm_name}
    
    
#    ${vsp_name}           Create New Vendor Software Product - Heatfile     ${vlm_name}    ${la_name}     ${fg_name}
#    ${vsp_name}           Create New Vendor Software Product - Heatfile    RA_VLM_c01e28     RA_LA_c01e28     RA_FG_c01e28
#    Log To Console        Executed the Keyword : Create New VSP - NAME - ${vsp_name}
#    Set Suite Variable    	${vsp_name}        ${vsp_name}
      
      
#    ${vf_name}    Import VF    ${vsp_name}
#***********    ${vf_name}    Import VF    RA_VSP_837819
#    Log To Console    VF Name - ${vf_name}
    
#    Import VF    <<{vsp_name}>>
    
    
#    ${SERVICE_NAME}=    Create New Service    ${vf_name}
     ${SERVICE_NAME}=    Set Variable    SDC_RA_SVC_919287   
        
#    Change User Role    ${USERNAME}    TESTER

    # Log to Console    Change the role to TESTER. Waiting for 15sec
    # Sleep    15
    # Test Service    ${SERVICE_NAME}
    
#    Change User Role    ${USERNAME}    GOVERNER
    Log to Console    Change the role to GOVERNER. Waiting for 15sec
    Sleep    15

    Approve Service    ${SERVICE_NAME}
#    Change User Role    ${USERNAME}    OPS

    Log to Console    Change the role to OPS. Waiting for 15sec
    Sleep    15
    
     @{SERVICE_DISTRIBUTION_DETAILS}    Distribute Service    ${SERVICE_NAME}
     Log To Console    First Param: @{SERVICE_DISTRIBUTION_DETAILS}[0]
     Log To Console     Second Param: @{SERVICE_DISTRIBUTION_DETAILS}[1]    
    
#    Change User Role    ${USERNAME}    DESIGNER
     Log to Console    Change the role to DESIGNER. Waiting for 15sec
    Sleep    15

Test_ASDC_VNF_MODEL_VID_FLOW_VNF_CREATION
    Login To Ecomp Portal
    Launch Application and Validate    VID
    ${VNF_DETAILS}    VID VNF Creation       93cc6781-907b-43df-8958-8afed58a7514 

Test_ASDC
    
    
    
    # ${SERVICE_NAME} =     Set Variable      ServiceWith_CONTRIAL30_342522
    # Log to Console    Change the role to TESTER. Waiting for 15sec
    # Sleep    15
    # Test Service    ${SERVICE_NAME}
    
# #    Change User Role    ${USERNAME}    GOVERNER
    # Log to Console    Change the role to GOVERNER. Waiting for 15sec
    # Sleep    15

    # Approve Service    ${SERVICE_NAME}
# #    Change User Role    ${USERNAME}    OPS

    # Log to Console    Change the role to OPS. Waiting for 15sec
    # Sleep    15
    
    # @{SERVICE_DISTRIBUTION_DETAILS}    Distribute Service    ${SERVICE_NAME}
     # Log To Console    First Param: @{SERVICE_DISTRIBUTION_DETAILS}[0]
     # Log To Console     Second Param: @{SERVICE_DISTRIBUTION_DETAILS}[1]    
    
# #    Change User Role    ${USERNAME}    DESIGNER
     # Log to Console    Change the role to DESIGNER. Waiting for 15sec
    # Sleep    15
    
#   A&AI Model GET Request      @{SERVICE_DISTRIBUTION_DETAILS}[1]    #@{SERVICE_DISTRIBUTION_DETAILS}[0]         
 
    Login To Ecomp Portal
    Launch Application and Validate    VID
    Create VID Service Instance       Ginger_AUTO_001    #ServiceWith_CONTRIAL30_342522 
    
    
    #    ServiceWith_CONTRIAL30_342522
test
     
#    A&AI Model GET Request      94f62349-dea2-4b3b-89e2-753f4cccac92    #@{SERVICE_DISTRIBUTION_DETAILS}[0]         
 
   ${SERVICE_NAME}=      Create New Service Network model - CONTRIAL_30_Basic     # Network Model - Component from Ginger
    Log To Console    Name of Service is : ${SERVICE_NAME}

Blueprint of vCOM VNF Spin up

    ${USERNAME} =    Common Get Username
    
    # # ${UUID}=           Evaluate    random.randint(100000, 999999)    random
    # # ${SERVICE_NAME}    catenate    SDC_RA_SVC_${UUID}
    # ${SERVICE_NAME}=      Create New Service Network model - CONTRIAL_30_Basic     # Network Model - Component from Ginger
    # Log To Console    *******Name of Service is : ${SERVICE_NAME}
    
# #    Change User Role    ${USERNAME}    TESTER

    # Log to Console    Change the role to TESTER. Waiting for 15sec
    # Sleep    15
    # Test Service    ${SERVICE_NAME}
    
#    Change User Role    ${USERNAME}    GOVERNER
    # Log to Console    Change the role to GOVERNER. Waiting for 15sec
    # Sleep    15

    # Approve Service    ${SERVICE_NAME}
# #    Change User Role    ${USERNAME}    OPS

    # Log to Console    Change the role to OPS. Waiting for 15sec
    # Sleep    15
    
    # @{SERVICE_DISTRIBUTION_DETAILS}    Distribute Service    ${SERVICE_NAME}
     # Log To Console    First Param: @{SERVICE_DISTRIBUTION_DETAILS}[0]
     # Log To Console     Second Param: @{SERVICE_DISTRIBUTION_DETAILS}[1]    
    
# #    Change User Role    ${USERNAME}    DESIGNER
     # Log to Console    Change the role to DESIGNER. Waiting for 15sec
    # Sleep    15
    
# #    A&AI Model GET Request      94f62349-dea2-4b3b-89e2-753f4cccac92    #@{SERVICE_DISTRIBUTION_DETAILS}[0]         
# #    ************************************************************************************************************************************************************ 
    # Login To Ecomp Portal
    # Launch Application and Validate    VID
    # ${CUSTOMER_NAME}    ${service_instance_id}    Create VID Service Instance       ${SERVICE_NAME} 
    # Log To Console    ******Executed keyword : Create VID Service Instance******
    # Log To Console    Customer Name : ${CUSTOMER_NAME}
    # Log To Console    Service Instance ID : ${service_instance_id}            
    
#    ***************************************************************************************************************TESTED********************    
     
     # Login To Ecomp Portal
     # Launch Application and Validate   SDNGC-Admin-Portal
     # Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]      300s
    # Update the Network Preload Details    ${EXCEL_NAME}    ${NETWORK_NAME}
    # Get the Network Preload Details    ${EXCEL_NAME}    ${NETWORK_NAME}
  #  Upload Network Preload in SDNC Admin Portal(INCOMPLETE)    ${Preload_Excel}
    
   
    #SDNC Preload upload  vmogx.xlsm
#***    Network preload upload    ${files}
    
     
    #    **** TODO    Export Model Module Name from ASDC
          #<<{Supplement_data_file}    {Entity_in_Creation}>>            #Upload_PreLoad_Sheet_Network-1 - Component from Ginger
#***    @{SERVICE_INSTANCE_ID}      Create VID Service Instance    @{SERVICE_DISTRIBUTION_DETAILS}[1]
# **    ${SERVICE_INSTANCE_ID}    Create VID Network          @{SERVICE_INSTANCE_ID}[1]    {network_name_from_prelaod}>>
    
# ***********    ${RESPONSE}    A&AI Network GET Request    <<{NETWORK_ID}>>    #A&AI L3-Network Validation - Component from Ginger
    

    
    ${vlm_name}    ${la_name}        ${fg_name}        Create New License Model              
    log to console    value of vlm is ${vlm_name}
    log to console    value of la is ${la_name}
    Set suite variable    ${vlm_name}    ${vlm_name}
    Set suite variable    ${la_name}    ${la_name}
    Set suite variable    ${fg_name}    ${fg_name}
    log to console    value of vlm_name is ${vlm_name}
    
    
    ${vsp_name}           Create New Vendor Software Product - Heatfile     ${vlm_name}    ${la_name}     ${fg_name}
    Log To Console    *******Executed the keyword : Create New Vendor Software Product - Heatfile*****    
    Log To Console        VSP Name: ${vsp_name}
    Set Suite Variable    	${vsp_name}        ${vsp_name}
      
      
    ${vf_name}    Import VF    ${vsp_name}
    Log To Console    ******Executed the keyword : Import VF*****    
    Log To Console    ${vf_name}
    
#    Import VF    <<{vsp_name}>>
    
    
    ${SERVICE_NAME}=    Create New Service    ${vf_name}
    
        
#    Change User Role    ${USERNAME}    TESTER

    Log to Console    Change the role to TESTER. Waiting for 15sec
    Sleep    15
    Test Service    ${SERVICE_NAME}
    
#    Change User Role    ${USERNAME}    GOVERNER
    Log to Console    Change the role to GOVERNER. Waiting for 15sec
    Sleep    15

    Approve Service    ${SERVICE_NAME}
#    Change User Role    ${USERNAME}    OPS

    Log to Console    Change the role to OPS. Waiting for 15sec
    Sleep    15
    
     @{SERVICE_DISTRIBUTION_DETAILS}    Distribute Service    ${SERVICE_NAME}
     Log To Console    First Param: @{SERVICE_DISTRIBUTION_DETAILS}[0]
     Log To Console     Second Param: @{SERVICE_DISTRIBUTION_DETAILS}[1]    
    
#    Change User Role    ${USERNAME}    DESIGNER
     Log to Console    Change the role to DESIGNER. Waiting for 15sec
    Sleep    15
    
    
    Login To Ecomp Portal
    Launch Application and Validate    VID
    ${VNF_DETAILS}    VID VNF Creation       @{SERVICE_DISTRIBUTION_DETAILS}[0] 

 
VNF Spin up vCOM
    ${USERNAME} =    Common Get Username
    
    # ${UUID}=           Evaluate    random.randint(100000, 999999)    random
    # ${SERVICE_NAME}    catenate    SDC_RA_SVC_${UUID}
    ${SERVICE_NAME}=      Create New Service Network model - CONTRIAL_30_Basic     # Network Model - Component from Ginger
    Log To Console    Name of Service is : ${SERVICE_NAME}
    
#    Change User Role    ${USERNAME}    TESTER

    Log to Console    Change the role to TESTER. Waiting for 15sec
    Sleep    15
    Test Service    ${SERVICE_NAME}
    
#    Change User Role    ${USERNAME}    GOVERNER
    Log to Console    Change the role to GOVERNER. Waiting for 15sec
    Sleep    15

    Approve Service    ${SERVICE_NAME}
#    Change User Role    ${USERNAME}    OPS

    Log to Console    Change the role to OPS. Waiting for 15sec
    Sleep    15
    
    @{SERVICE_DISTRIBUTION_DETAILS}    Distribute Service    ${SERVICE_NAME}
     Log To Console    First Param: @{SERVICE_DISTRIBUTION_DETAILS}[0]
     Log To Console     Second Param: @{SERVICE_DISTRIBUTION_DETAILS}[1]    
    
#    Change User Role    ${USERNAME}    DESIGNER
     Log to Console    Change the role to DESIGNER. Waiting for 15sec
    Sleep    15
    
#    A&AI Model GET Request      94f62349-dea2-4b3b-89e2-753f4cccac92    #@{SERVICE_DISTRIBUTION_DETAILS}[0]         
#    ************************************************************************************************************************************************************ 
    Login To Ecomp Portal
    Launch Application and Validate    VID
    Create VID Service Instance       ${SERVICE_NAME} 
    
    
     
     Login To Ecomp Portal
     Launch Application and Validate   SDNGC-Admin-Portal
     Wait Until Page Contains Element    //a[contains(.,'SDN-C AdminPortal')]      300s
    Update the Network Preload Details    ${EXCEL_NAME}    ${NETWORK_NAME}
    Get the Network Preload Details    ${EXCEL_NAME}    ${NETWORK_NAME}
  #  Upload Network Preload in SDNC Admin Portal(INCOMPLETE)    ${Preload_Excel}
    
   
    #SDNC Preload upload  vmogx.xlsm
    Network preload upload    ${files}
    
     
    #    **** TODO    Export Model Module Name from ASDC
          #<<{Supplement_data_file}    {Entity_in_Creation}>>            #Upload_PreLoad_Sheet_Network-1 - Component from Ginger
#***    @{SERVICE_INSTANCE_ID}      Create VID Service Instance    @{SERVICE_DISTRIBUTION_DETAILS}[1]
# **    ${SERVICE_INSTANCE_ID}    Create VID Network          @{SERVICE_INSTANCE_ID}[1]    {network_name_from_prelaod}>>
    
# ***********    ${RESPONSE}    A&AI Network GET Request    <<{NETWORK_ID}>>    #A&AI L3-Network Validation - Component from Ginger
    

    
    ${vlm_name}    ${la_name}        ${fg_name}        Create New License Model              
    log to console    value of vlm is ${vlm_name}
    log to console    value of la is ${la_name}
    Set suite variable    ${vlm_name}    ${vlm_name}
    Set suite variable    ${la_name}    ${la_name}
    Set suite variable    ${fg_name}    ${fg_name}
    log to console    value of vlm_name is ${vlm_name}
    
    
    ${vsp_name}           Create New Vendor Software Product - Heatfile     ${vlm_name}    ${la_name}     ${fg_name}
    Log To Console        ${vsp_name}
    Set Suite Variable    	${vsp_name}        ${vsp_name}
      
      
    ${vf_name}    Import VF    ${vsp_name}
    Log To Console    ${vf_name}
    
#    Import VF    <<{vsp_name}>>
    
    
    ${SERVICE_NAME}=    Create New Service    ${vf_name}
    
        
#    Change User Role    ${USERNAME}    TESTER

    Log to Console    Change the role to TESTER. Waiting for 15sec
    Sleep    15
    Test Service    ${SERVICE_NAME}
    
#    Change User Role    ${USERNAME}    GOVERNER
    Log to Console    Change the role to GOVERNER. Waiting for 15sec
    Sleep    15

    Approve Service    ${SERVICE_NAME}
#    Change User Role    ${USERNAME}    OPS

    Log to Console    Change the role to OPS. Waiting for 15sec
    Sleep    15
    
     @{SERVICE_DISTRIBUTION_DETAILS}    Distribute Service    ${SERVICE_NAME}
     Log To Console    First Param: @{SERVICE_DISTRIBUTION_DETAILS}[0]
     Log To Console     Second Param: @{SERVICE_DISTRIBUTION_DETAILS}[1]    
    
#    Change User Role    ${USERNAME}    DESIGNER
     Log to Console    Change the role to DESIGNER. Waiting for 15sec
    Sleep    15
    
    
    Login To Ecomp Portal
    Launch Application and Validate    VID
    ${VNF_DETAILS}    VID VNF Creation       @{SERVICE_DISTRIBUTION_DETAILS}[0] 
    
    # Create VID VNF   ${SERVICE_NAME}
    # Create VID Service Instance       ${SERVICE_NAME}
    
    # Run VID Health Check
    # Login To Ecomp Portal
    # Launch Application and Validate    VID
 
   
    Close Browser
    
# ******    A&AI Generic_Vnf GET Request    <<{VNF_ID}>>
    
    Run VID Health Check
    Login To Ecomp Portal
    Launch Application and Validate    VID
    Go To VID Home
    Select SDNC Auto Preload    <<{Supplement_data_file}    {Entity_in_Creation}>>            #Upload_PreLoad_Sheet_VF-1 - Component from Ginger
    
    A&AI Vserver GET Request  <<{CLOUD_OWNER}    {CLOUD_REGION_ID}    {TENANT_ID}    {VSERVER_ID}>>
    
    Create VID BASE VF module    <<{service_instance_id}    {PreloadType}    {PreloadFileName}>>
    
    
    
    
    
    
    
    