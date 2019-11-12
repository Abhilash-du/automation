*** Settings ***
#Resource  ../resources/mso/Camunda.robot
Resource  ../resources/mso/Shakeout_mso_NetworkCreation.robot
Resource  ../resources/vid/vid_interface.robot
Resource  ../resources/vid/mso_vid_interface.robot
Library    SeleniumLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     ../library/myLibraries/Replace.py
Library	      UUID      
Library	      Screenshot
Library       DateTime  
Resource  ../resources/mso/MSO_OR.robot
Resource  ../resources/mso/MSO_properties.robot
Resource  ../resources/vid/Change_Management.robot
Resource   ../resources/aai/aai_validations/aai_network_validation.robot
Suite Teardown   copyLogs   ${EXECDIR}  ${SUITE NAME}




*** variables ***
${mso_request_id}            
${mso_instance_id}  
${x}   
${y}

       


*** Test Cases ***

Camunda Validation
     
     Camunda Validation   ServiceInstance    WorkflowActionBB 
     #Test

    
SDNC Validations 
    
    SDNC Validation     
    
MSO Oam Network Creation 
         Login To Ecomp Portal
         Launch Application and Validate    VID
         #Select Test API        GR_API
         Browse ASDC Model  d325a6ad-ce31-4ce7-b81e-44ef3e527591  b2e23174-c041-4395-80e5-f07b4cc592f3  
         Populate values in Network Creation Flow 
         Validate Completion test for Instantiation
         Get Current Time
         Set Suite Variable    ${msoFilename}  ${MSO_VNF}_OAM_NETWORKCREATION_${time}
         Get VID Screen data and store 
         
         Log To Console    Searching for Existing Service Instance Id    
         Search for Existing Service Instance 
         Log To Console    Searching for Network Id 
         ${msoNetworkId}     Get Network Id  
         
         Log To Console    Camunda Validation Started   
          
         Log to Console    MSO DB Validation Started
         MSO DB Validation 
         
         Log to console     AAI Validations    
         A&AI Network GET Validation     ${msoNetworkId}
         
         Log To Console    SDNC Validation
         SDNC Validation 
         
         Log to Console    AIC Validation  
       
MSO Sriov Network Creation 
         Login To Ecomp Portal
         Launch Application and Validate    VID
         #Select Test API        GR_API
         Browse ASDC Model  3193a3b3-bb65-4b7a-81ec-90012f3073b5  2a0c1f2b-3b87-47b5-a233-8b587dbc95c6
         Populate values in Network Creation Flow 
         Validate Completion test for Instantiation
         Get Current Time
         Set Suite Variable    ${MSO_FILENAME}  ${MSO_VNF}_SRIOV_NETWORKCREATION_${time}
         Get VID Screen data and store 
         Log To Console    Searching for Existing Service Instance Id    
         Search for Existing Service Instance 
         Log To Console    Searching for Network Id 
         ${msoNetworkId}     Get Network Id  
         
         Log To Console    Camunda Validation Started   
          
         Log to Console    MSO DB Validation Started
         MSO DB Validation 
         
         Log to console     AAI Validations    
         A&AI Network GET Validation     ${msoNetworkId}
         
         Log To Console    SDNC Validation
         SDNC Validation 
         
         Log to Console    AIC Validation    
         
MSO Service Instance Creation
         Login To Ecomp Portal
         Launch Application and Validate    VID
         #Select Test API        GR_API
         Browse ASDC Model    d325a6ad-ce31-4ce7-b81e-44ef3e52759a  b2e23174-c041-4395-80e5-f07b4cc592f3
         Populate values in Service Instance 
         Validate Completion test for Instantiation
         Get Current Time
         Set Suite Variable    ${MSO_FILENAME}  ${MSO_VNF}_ServiceInstnace_${time}
         Get VID Screen data and store  
         Camunda Validation   ServiceInstance
         
         
MSO VNF Creation 
         Login To Ecomp Portal
         Launch Application and Validate    VID
         # Select Test API        GR_API
         #Search for Existing Service Instance       ${mso_instance_id} 
         Populate values in VNF   
         Validate Completion test for Instantiation
         Get Current Time
         Set Suite Variable    ${MSO_FILENAME}  ${MSO_VNF}_VNF_${time}
         Get VID Screen data and store  
         Set Global Variable    ${Mso_VNF_Id}    c894e9cf-a0ac-4e1b-b447-aeff4e0c6388
         
         
MSO Volume Group Creation 
         Login To Ecomp Portal
         Launch Application and Validate    VID
         #Select Test API        GR_API
         
MSO Base VF Creation
         Login To Ecomp Portal
         Launch Application and Validate    VID
         #Select Test API        GR_API
       
MSO Addon VF Creation
         Login To Ecomp Portal
         Launch Application and Validate    VID
         #Select Test API        GR_API         
        

MSO DB Validation 
        Set Global Variable    ${mso_request_id}     001da6bc-8b21-4e0c-bbf7-b512a77c4d85
        Set Global Variable    ${mso_instance_id}    ebf8c9b5-50d4-4022-abdc-a5781e01d98c
        MSO DB Validation     
          
Test
    Replace_Specialchar      string    badcharacters  
         
 
Run Random String 
          #Get Random String  
     Set Test Variable  ${mso}  hello  
     Get Current Time  
     Set suite Variable    ${MSO_FILENAME}  ${MSO_VNF}_OAM_NETWORKCREATION_${time}
     Get VID Screen data and store   


VVIG_SPINUP
       #OAM Network Creation
         Login To Ecomp Portal
         Launch Application and Validate    VID
         #Select Test API        GR_API
         Browse ASDC Model  d325a6ad-ce31-4ce7-b81e-44ef3e527591  b2e23174-c041-4395-80e5-f07b4cc592f3  
         Populate values in Network Creation Flow 
         Validate Completion test for Instantiation
         Get Current Time
         Set Suite Variable    ${MSO_FILENAME}  ${MSO_VNF}_OAM_NETWORKCREATION_${time}
         Get VID Screen data and store 
         Search for Existing Service Instance 
         Get Network Id 
         MSO DB Validation 
    
    
 Dummy Test
    @{abc}    Dummy 
    ${x}   Set Variable    ${abc[0]} 
    ${y}   Set Variable    ${abc[1]} 
    
    Dummy1     ${x}    ${y}   
    
    