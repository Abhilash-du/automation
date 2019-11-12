*** Settings ***
#Library 	    ExtendedSelenium2Library
# Resource    ../resources/asdc_IST_1810/Resource_SDC_Create_VSP.robot
# Resource    ../resources/asdc_IST_1810/Resource_SDC_Import_VF.robot
# Resource    ../resources/asdc_IST_1810/Resource_SDC_Test_VF.robot
# Resource    ../resources/asdc_IST_1810/asdc_change_userrole.robot
# Resource    ../resources/asdc_IST_1810/NewLicenseModel.robot
# Resource   ../resources/asdc_IST_1810/Resource_SDC_Create_Service.robot
# Resource   ../resources/asdc_IST_1810/Resource_SDC_Test_Service.robot
# Resource   ../resources/asdc_IST_1810/Resource_SDC_Approve_Service.robot
# Resource   ../resources/asdc_IST_1810/Resource_SDC_Distribute_Service.robot
# Resource    ../resources/asdc_IST_1810/Resource_SDC_Check_Distribution_API .robot
#Resource      ../resources/VID-SmokeTest_1810/vid_IST_interface.robot
#Resource      ../resources/aai_SmokeTest_1810/service_instance_IST.robot





### VISHAL CODE STARTS ######

#Resource    ../resources/aai/aai_interface.robot
Resource    ../resources/aai/aai_service_instance.robot
Resource    ../resources/aai/aai_validations/aai_service_instance_logs_validation.robot
Resource    ../resources/aai/aai_unix_interface.robot
Resource    ../resources/aai/aai_pserver.robot
Resource    ../resources/aai/aai_validations/aai_model_validation.robot
Resource    ../resources/aai/aai_validations/aai_volume_group_validation.robot
#Library    RequestsLibrary
Resource    ../resources/vid/vid_interface.robot
Resource    ../resources/aai/aai_validations/aai_vf_module_validation.robot
Resource    ../resources/portal/portal_interface.robot
Resource    ../resources/aai/Shakeout/aai_shakeout.robot
Resource    ../resources/aai/aai_Linux_files.robot
Resource    ../resources/global_properties.robot
Resource    ../resources/browser_setup.robot
Suite Teardown    Close Agents    


### VISHAL CODE STARTS ######


*** Variable ***
# ${role_change_username}   kk707x    
# ${userrole_to_change}    TESTER
${vlm_name}    #e5122bd9-375e-465e-9a82
${ASDC_MODEL}    #SDC_Automation_200691    #SDC_Automation_458729     #SDC_Automation_807180
${CUSTOMER_NAME}    #SDC_Automation_200691_Service2    
${Global-Customer-Id}    #a9a77d5a-123e-4ca2-9eb9-0b015d2ee0fb        
${Service-Instance-Id}    #6e424f70-07ef-4eb4-bacf-717584f146f5    
${VNF_ID}    		#831205cf-6bb5-4db7-98ee-897047c1f44f    
${BASE_VFModule_ID}
${VFModule1_ID}    	#5e39516a-ea2b-4c37-b495-512366b1a5c7
${VFModule2_ID}    #9e02dbd5-38de-4a73-97ac-89b6580abe4b   
${VFModule3_ID}    	#6e1c18b1-df38-49e6-bccb-79cdae2df4e5
${VFModule4_ID}    #4b24fd8a-340f-4cf8-8cef-52dc93644e66
${VFModule7a_ID}
${VFModule7b_ID}    #3a793317-9a7f-46df-bd61-0ec9ffe53654
${VFModule8_ID}    #a0db3b66-8a41-4e46-a7e8-12bb816f5364
${VFModule9_ID}    #48fb28a4-6217-4e05-a304-a02239a21a88
${Volume_ID}
${CUSTOMER_VNF_MODULE_BASE}
${CUSTOMER_VNF_IST_MODULE2}   
${CUSTOMER_VNF_IST_MODULE3}   
${CUSTOMER_VNF_IST_MODULE4}
${CUSTOMER_VNF_IST_MODULE7a}
${CUSTOMER_VNF_IST_MODULE7b}
${CUSTOMER_VNF_IST_MODULE8}
${CUSTOMER_VNF_IST_MODULE9}
${CUSTOMER_VOLUME}
${Module2_Volume_ID}    #49c1cf85-3bf4-4549-9a9b-41c086c566a9 
${Module6_Volume_ID}
${CUSTOMER_VOLUME_MODULE2}    #SDC_Automation_200691_Module2_Volume
${CUSTOMER_VOLUME_MODULE6}


*** Test Cases ***

### VISHAL CODE STARTS #####


#### A&AI STARTS#######
    
A&AI Health Check
    [Documentation]    Runs A&AI Health Check
    Run A&AI Health Check

    
A&AI Service Instance Get Request
    [Documentation]    Basic A&AI Get Request. Requires 3 Arguments. 1st Customer ID, 2nd Service Subscription and 3rd Service Instance Id.
    A&AI Service Instance GET Request    a9a77d5a-123e-4ca2-9eb9-0b015d2ee0fb    Mobility     51de28a6-b81f-4a8e-bd70-47ccc2087ee3
    
    
A&AI Put Request simple
    [Documentation]    Basic A&AI Put Request. Requires 3 Arguments. 1st Resource Path and 2nd Entity ID and 3rd Payload Data in correct Json Syntax
    Run A&AI Put Request Basic    /cloud-infrastructure/pservers/pserver/    abcde    {"in-maint":true}
    
         
A&AI Put Request jsonfile
    [Documentation]    Basic A&AI Get Request from a text file. Requires 2 Arguments. 1st Resource Path and 2nd Entity ID and 3rd Payload FIle Name
    Run A&AI Put Request   /cloud-infrastructure/pservers/pserver/    amist-GINGER-host-0    SANITY_API_CREATE_PSERVER.txt


Run A&AI Delete Request
    ${GET Response}    Run A&AI Get Request    /cloud-infrastructure/pservers/pserver/    amist-GINGER-host-0 
    ${json} =  Set Variable   ${GET response.json()}
    ${resource-version}  Set Variable  ${json["resource-version"]}
    Run A&AI Delete Request    /cloud-infrastructure/pservers/pserver/    amist-GINGER-host-0    ${resource-version}
    


    
 Run Unix Validations
     ${dummy}    A&AI Unix Logs GET Validation    51de28a6-b81f-4a8e-bd70-47ccc2087ee3
     Log    ${dummy} 
     Log to Console    ${dummy}   
     
 A&AI Service Instance Unix Get Request
     A&AI Service Instance Unix Logs GET Validation    51de28a6-b81f-4a8e-bd70-47ccc2087ee3
      
      
A&AI Model Validations
    #Need 2 Arguments. 1st Model Invariant ID and 2nd Model UUID
    A&AI Model GET Validation    6203dbf7-9c19-4635-8650-173935a64335     a47b1444-fbc8-4d7f-beb1-78dd67184634     
      

A&AI Volume Group Validations
    #Need 1 Argument i.e. Generic Vnf ID where we are checking the presence of volume group
    A&AI Volume Group Validations    27b7c8c4-b7a2-4e65-8d6f-edf728301e9a

A&AI Base vF Modules Validations
    #Need 1 Argument i.e. Generic Vnf ID where we are checking the presence of volume group
    A&AI Base vF Modules Validations    27b7c8c4-b7a2-4e65-8d6f-edf728301e9a
    

A&AI Addon vF Modules Validations
    #Need 1 Argument i.e. Generic Vnf ID where we are checking the presence of volume group
    A&AI Addon vF Modules Validations    27b7c8c4-b7a2-4e65-8d6f-edf728301e9a
     

Run A&AI API Shakeout
    [Documentation]    A&AI Shakeout.It Consists of 5 TCs. Namely .Create,Update and Delete of PSERVER, CLOUD-REGION, GENERIC-VNF, COMPLEX and TENANT WITH RELATIONSHIP.
    
    #Shakeout for PSERVER
    Pserver Shakeout
    #Shakeout for Cloud Region
    Cloud Region Shakeout
    #Shakeout for Generic Vnf
    Generic Vnf Shakeout
    #Shakeout for Complex
    Complex Shakeout 
    #Shakeout for Tenant With Relationship
    Tenant With Relationship



Run A&AI UI Shakeout
    [Documentation]    A&AI UI Shakeout.It Consists of 2 TCs. Namely, UI Basic Validations and UI Connectivity Validations.
    
    #A&AI UI Basic Validation
    Run A&AI UI Basic Validations
    #A&AI UI Data Connectivity Valdidations
    Run A&AI UI Data Connectivity Validations  

Run A&AI Shakeout
    [Documentation]    A&AI API and UI Shakeout Scenarios.
    
    #Shakeout for PSERVER
    Pserver Shakeout
    #Shakeout for Cloud Region
    Cloud Region Shakeout
    #Shakeout for Generic Vnf
    Generic Vnf Shakeout
    #Shakeout for Complex
    Complex Shakeout 
    #Shakeout for Tenant With Relationship
    Tenant With Relationship
    #A&AI UI Basic Validation
    Run A&AI UI Basic Validations
    #A&AI UI Data Connectivity Valdidations
    Run A&AI UI Data Connectivity Validations  
    #Requires 1 argument of feed file name i.e. NETDB or RCT
    A&AI Linux Input Feed Files Validations    RCT
    A&AI Linux Input Feed Files Validations    NETDB
    #Requires 1 argument of pickup file name i.e. GFP_IP, INSTAR_DCAE_PMOSS, RUBY or GCP
    A&AI Linux Output Pickup Files Validations    GFP_IP
    A&AI Linux Output Pickup Files Validations    INSTAR_DCAE_PMOSS
    A&AI Linux Output Pickup Files Validations    RUBY
    A&AI Linux Output Pickup Files Validations    GCP 

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


#### A&AI ENDS#######
    
    
#### VID STARTS#######    
    
VID HealthCheck
    #Running the basic VID HealthCheck. Requires 0 Arguments.Can only be ran on ATT Machines. Proxy Wont Work here.
    Run VID Health Check


Go To VID Home
    #Running the Test Case to Launch VID Directly.
    Go To VID Home


Launch Ecomp Portal
    Login To Ecomp Portal



Check Random String
    ${String}    Random String
    Log to Console    ${String}
    
    
    
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
    

# Return Check
    # ${Return}  hello
    # ${1st}    Get From List    ${Return}    1
    # Log to console   ${1st}

Split String
    ${string}    Set Variable    abcd efgh
    ${Hello}    Split String    ${string}    
    ${sd}  Get from List    ${Hello}    1  
    log to Console  ${sd}  
    
    
Volume Group Addition through VID
    Login To Ecomp Portal
    #This Keyword is for Loginin to ECOMP Portal
    Launch Application and Validate    VID
    #This Keyword is for Launch the particular Application and perform the basic Validations. Requires 1 argument as Application Name.
    Add Volume Group VID    d325a6ad-ce31-4ce7-b81e-44ef3e52759a    APP-C-24595-T-IST-05A_vcom_mngt_01 
    #This keyword is for Creating a network. Includes 2 Keywords. 1st Instance Creation. 2nd Network Creation.
    #Instance Creation Requires 1 Argument as Model UUID.
    #N/W creation requires Instance name That is same as the N/W Preload Name.
    #Arguments Required 2. 1st Model UUID. 2nd Network Name from SDN Portal
        
 
       
#### VISHAL CODE ENDS ####   
    
    
    
    
     
    # Create New License Model
# #      Change User Role    ${GLB_ATT_USERID}    ${ROLE_NAME_DES}
    # ${vlm}=    Create New License Model
    # Set suite variable   ${vlm_name}   ${vlm}
        
# Create New VSP
    # Create New Vendor Software Product    ${vlm_name}
    
# Import The VF   
   # Import VF
    

#Create New Service
   #Change User Role    ${GLB_ATT_USERID}    ${ROLE_NAME_DES}
     #Create New Service

# Test The Service
  # Change User Role    ${GLB_ATT_USERID}    ${ROLE_NAME_TEST}
   # Test Service

# Approve The Service
    # Change User Role    ${GLB_ATT_USERID}    ${ROLE_NAME_GOV}
    # Approve service
    
# Distribute The Service
    # Change User Role    ${GLB_ATT_USERID}    ${ROLE_NAME_OPS}
   # ${ASDC_MODEL} =     Distribute service
   # set global variable    ${ASDC_MODEL}
      

# Check Model Distribution In MSO Catalog
   # Sleep    2 minutes
    # Check model distribution
   # Sleep    2 minutes
    
# Check Model Distribution In A&AI Catalog
    # Sleep    60s
    # Check model distribution in A&AI    
    
   
# Login into Portal
    # Login To VID GUI
    
# Create service Instance
    # ${CUSTOMER_NAME}=  Create VID Service Instance    ${ASDC_MODEL}
    # set global variable    ${CUSTOMER_NAME} 
    
# ADD VNF
# #    ${Global-Customer-Id}    ${Service-Instance-Id}    ${VNF_ID}    ${VNF_NAME}    ${VNF_TYPE}     ${vnf-Type_Module2}    ${vnf-Type_Module3}    ${vnf-Type_Module4} =    Create VID VNF for Mobility    ${CUSTOMER_NAME}
    # ${Global-Customer-Id}    ${Service-Instance-Id}    ${VNF_ID}    ${VNF_NAME}    ${VNF_TYPE}=    Create VID VNF    ${CUSTOMER_NAME}
    # set global variable    ${Global-Customer-Id}
    # set global variable    ${Service-Instance-Id}
    # set global variable    ${VNF_ID}
    # set global variable    ${VNF_NAME}
    # set global variable    ${VNF_TYPE}
    # # set global variable    ${vnf-Type_Module2}
    # # set global variable    ${vnf-Type_Module3}
    # # set global variable    ${vnf-Type_Module4}
    
# ADD BASE VFmodule
    # ${CUSTOMER_VNF_MODULE_BASE}=    Create VID BASE VF module    ${CUSTOMER_NAME}
    # set global variable    ${CUSTOMER_VNF_MODULE_BASE}
     
     
# Add Volume Group for Module2
     # ${CUSTOMER_VOLUME_MODULE2}=    Add Volume Group for Module2    ${CUSTOMER_NAME}    #${vf_module2_name}
     # set global variable    ${CUSTOMER_VOLUME_MODULE2}
     
# Add Volume Group for Module6
     # ${CUSTOMER_VOLUME_MODULE2}=    Add Volume Group for Module6    ${CUSTOMER_NAME}    #${vf_module2_name}
     # set global variable    ${CUSTOMER_VOLUME_MODULE2}  

    
     
# ADD VFmodule2
     # ${CUSTOMER_VNF_IST_MODULE2}=    Create VID VF module2    ${CUSTOMER_NAME}    ${CUSTOMER_VOLUME_MODULE2}    #${vf_module2_name}
     # set global variable    ${CUSTOMER_VNF_IST_MODULE2}
      
# ADD VFmodule3
     # ${CUSTOMER_VNF_IST_MODULE3}=    Create VID VF module3    ${CUSTOMER_NAME}
     # set global variable    ${CUSTOMER_VNF_IST_MODULE3}
    
# ADD VFmodule4
    # ${CUSTOMER_VNF_IST_MODULE4}=    Create VID VF module4    ${CUSTOMER_NAME}
    # set global variable    ${CUSTOMER_VNF_IST_MODULE4}
    
# ADD VFmodule7a
    # ${CUSTOMER_VNF_IST_MODULE7a}=    Create VID VF module7a    ${CUSTOMER_NAME}
    # set global variable    ${CUSTOMER_VNF_IST_MODULE7a}
    
# ADD VFmodule7b
    # ${CUSTOMER_VNF_IST_MODULE7b}=    Create VID VF module7b    ${CUSTOMER_NAME}
    # set global variable    ${CUSTOMER_VNF_IST_MODULE7b}
    
    
# ADD VFmodule8
    # ${CUSTOMER_VNF_IST_MODULE8}=    Create VID VF module8    ${CUSTOMER_NAME}
    # set global variable    ${CUSTOMER_VNF_IST_MODULE8}
    
    
# ADD VFmodule9
    # ${CUSTOMER_VNF_IST_MODULE9}=    Create VID VF module9    ${CUSTOMER_NAME}
    # set global variable    ${CUSTOMER_VNF_IST_MODULE9}                
   
    
# Get VFModule IDs for Service
    # ${VFModule1_ID}    ${VFModule2_ID}    ${VFModule3_ID}    ${VFModule4_ID}    ${VFModule7a_ID}    ${VFModule7b_ID}    ${VFModule8_ID}    ${VFModule9_ID}    ${Module2_Volume_ID}=    Get VFmodule IDs    ${CUSTOMER_NAME}    ${CUSTOMER_VNF_MODULE_BASE}    ${CUSTOMER_VNF_IST_MODULE2}    ${CUSTOMER_VNF_IST_MODULE3}    ${CUSTOMER_VNF_IST_MODULE4}    ${CUSTOMER_VNF_IST_MODULE7a}    ${CUSTOMER_VNF_IST_MODULE7b}    ${CUSTOMER_VNF_IST_MODULE8}    ${CUSTOMER_VNF_IST_MODULE9}    ${CUSTOMER_VOLUME_MODULE2}    
    # set global variable    ${VFModule1_ID}
    # set global variable    ${VFModule2_ID}
    # set global variable    ${VFModule3_ID}
    # set global variable    ${VFModule4_ID}
    # set global variable    ${VFModule7a_ID}
    # set global variable    ${VFModule7b_ID}
    # set global variable    ${VFModule8_ID}
    # set global variable    ${VFModule9_ID}
    # set global variable    ${Module2_Volume_ID}
    
# # Tear Down
    # # Close All Browsers    
    
   
# Check Service Instance In A&AI Catalog    
    # Check Service Instance In A&AI    ${Global-Customer-Id}    ${Service-Instance-Id}    
    
# Validate VNF ID In A&AI 
    # Validate VNF In A&AI      ${VNF_ID}   
    
# Validate BASE VFModule In A&AI
    # Validate BASE VFModule In A&AI    ${VNF_ID}   ${VFModule1_ID}  
    
# Validate VFModule2 In A&AI
    # ${URL_Module2}=    Validate VFModule2 In A&AI    ${VNF_ID}    ${VFModule2_ID} 
    # set global variable    ${URL_Module2}
    
# Validate VFModule3 In A&AI
    # ${URL_Module3}=    Validate VFModule3 In A&AI    ${VNF_ID}    ${VFModule3_ID}
    # set global variable    ${URL_Module3}
    
# Validate VFModule4 In A&AI
    # ${URL_Module4}=    Validate VFModule4 In A&AI    ${VNF_ID}    ${VFModule4_ID}
    # set global variable    ${URL_Module4}  
    
# Validate VFModule7a In A&AI
    # ${URL_Module7a}=    Validate VFModule7a In A&AI    ${VNF_ID}    ${VFModule7a_ID}
    # set global variable    ${URL_Module7a} 
    
# Validate VFModule7b In A&AI
    # ${URL_Module7b}=    Validate VFModule7b In A&AI    ${VNF_ID}    ${VFModule7b_ID}
    # set global variable    ${URL_Module7b} 
    
# Validate VFModule8 In A&AI
    # ${URL_Module8}=    Validate VFModule8 In A&AI    ${VNF_ID}    ${VFModule8_ID}
    # set global variable    ${URL_Module8} 
    
# Validate VFModule9 In A&AI
    # ${URL_Module9}=    Validate VFModule9 In A&AI    ${VNF_ID}    ${VFModule9_ID}
    # set global variable    ${URL_Module9}     
                  
    
# Validate Volume Group for Module2 In A&AI
    # Validate Volume Group for Module2 In A&AI    ${Module2_Volume_ID} 
      
    
# Validate Vserver for VFModule2 IN A&AI
    # Validate Vserver for VFModule2 IN A&AI    ${URL_Module2}
    
# Validate Vserver for VFModule3 IN A&AI
    # Validate Vserver for VFModule2 IN A&AI    ${URL_Module3}
    
# Validate Vserver for VFModule4 IN A&AI
    # Validate Vserver for VFModule2 IN A&AI    ${URL_Module4}     
   
    
    