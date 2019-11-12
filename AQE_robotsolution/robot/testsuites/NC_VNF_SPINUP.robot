
*** Settings ***
   
Library    SeleniumLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library	      UUID      
Library	      Screenshot
Library       DateTime  
#Resource  ../resources/mso/MSO_OR.robot
#Resource  ../resources/mso/MSO.robot
Resource    ../resources/mso/MSO_RESOURCE.robot  
#Resource    ../resources/mso/VNAT_Flow.robot
#Resource    ../resources/mso/Camunda.robot

*** Variables ***
${REQUEST_ID}                                          39726e22-455d-4aaa-ac28-a144c63b796c

*** Test Cases *** 

CGNAT VNF Spinup
                      ${REQUEST_ID}          VNF Spinup of CGNAT
                      Set Global Variable    ${REQUEST_ID}

CGNAT VNF Deletion
                      ${vnf_InstanceName}    Set Variable           ${CGNAT_instance_name}
                      vnf Deletion           ${vnf_InstanceName
Hello     
                    Hello