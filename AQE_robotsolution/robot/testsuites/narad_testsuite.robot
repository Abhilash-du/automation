*** Settings ***
Resource    ../resources/narad/narad_resource.resource
Resource    ../resources/narad/narad_DATA.robot
Resource    ../resources/commonKeywords.robot
  
*** Test Cases ***
Narad Validations_Loop
    ${EXCEL_START}    Convert To Integer    ${EXCEL_START} 
    ${EXCEL_END}    Convert To Integer    ${EXCEL_END} 
    :FOR    ${i}    IN RANGE    ${EXCEL_START}    ${EXCEL_END+1}
    \    
    \    &{excelVal}            Fetch Data From Excel                 RGW                                                   ${i}
    \    Log To Console         ${excelVal}
    \    &{keyValDict}          Create Dictionary Values for NARAD    @{NARAD_JSONKey}                                      &{excelVal}
    \    ${narad_SIID}          Set Variable                          ${pre_ADD_SIID}-&{keyValDict}[service-instance-id]
    \    ${updatedResource}     Update Resource End URL               ${NARAD_customerResource}                             ${narad_SIID}
    \    ${response}            ${json_response}                      Run NARAD Get Request                                 ${updatedResource}
    \    JSON Tag Validation    ${json_response}                      service-instance-id                                   ${narad_SIID}
    \    ####-------------->>Relationship-Values Validation<<-------------------###
    \    ${status}    ${relationShipList}    NARAD Relationship Key Validation    ${json_response}    &{excelVal}
    \    Run Keyword If    ${status}==False    Fail    msg=${\n}${\n}Required relationship list not found for:${relationShipList}  
    \    ##----------------->>Network Validation-Cloud<<----------------------##
    \    &{RelkeyValDict}        NARAD Update Relationship Values    &{excelVal}                             #updates network name(relationship-value)
    \    ${Network_ID}           Set Variable                        &{RelkeyValDict}[relationship-value]
    \    Narad Cloud Validation    ${Network_ID}                       &{excelVal}
    \     ##------------------>>Network Validation-Vlan<<------------------##
    \    NARAD VLAN Validation    ${Network_ID}    &{excelVal}
    \    Log To Console    ended For: ${i}    

AAI Validation_Loop
    ${EXCEL_START}    Convert To Integer    ${EXCEL_START} 
    ${EXCEL_END}    Convert To Integer    ${EXCEL_END}    
    :FOR    ${i}    IN RANGE    ${EXCEL_START}    ${EXCEL_END+1}
    \    &{excelVal}            Fetch Data From Excel                 CAGG_Host                                               ${i}
    \    Log To Console         ${excelVal}
    \    &{keyValDict}          Create Dictionary Values for NARAD    @{AAI_JSONKey}                                          &{excelVal}
    \    ${aai_SIID}            Set Variable                          ${pre_ADD_SIID}-&{keyValDict}[service-instance-name]
    \    ${updatedResource}     Update Resource End URL               ${AAI_customerResource}                                 ${aai_SIID}
    \    ${response}            ${json_response}                      Run AAI Get Request                                     ${updatedResource}
    \    JSON Tag Validation    ${json_response}                      service-instance-id                                     ${aai_SIID}
    \    ####-------------->>Relationship-Values Validation<<-------------------###
    \    ${status}         ${relationShipList}    AAI Relationship Key Validation    ${json_response}                                                              &{excelVal}
    \    Run Keyword If    ${status}==False       Fail                               msg=${\n}${\n}Required relationship list not found for:${relationShipList}
    \    ##----------------->>Network Validation-Cloud<<----------------------##
    \    &{RelkeyValDict}        AAI Update Relationship Values    &{excelVal}                             #updates network name(relationship-value)
    \    ${Network_ID}           Set Variable                      &{RelkeyValDict}[relationship-value]
    \    AAI Cloud Validation    ${Network_ID}                     &{excelVal}
    \    ##------------------>>Network Validation-Vlan<<------------------##
    \    AAI VLAN Validation    ${Network_ID}    &{excelVal}

Narad Validations
    ${SpecificExcelRowNum}    Convert To Integer    ${SpecificExcelRowNum}    
    &{excelVal}            Fetch Data From Excel                 RGW                                                   ${SpecificExcelRowNum}
    Log To Console         ${excelVal}
    &{keyValDict}          Create Dictionary Values for NARAD    @{NARAD_JSONKey}                                      &{excelVal}
    ${narad_SIID}          Set Variable                          ${pre_ADD_SIID}-&{keyValDict}[service-instance-id]
    ${updatedResource}     Update Resource End URL               ${NARAD_customerResource}                             ${narad_SIID}
    ${response}            ${json_response}                      Run NARAD Get Request                                 ${updatedResource}
    JSON Tag Validation    ${json_response}                      service-instance-id                                   ${narad_SIID}
    ####-------------->>Relationship-Values Validation<<-------------------###
    ${status}    ${relationShipList}    NARAD Relationship Key Validation    ${json_response}    &{excelVal}
    Run Keyword If    ${status}==False    Fail    msg=${\n}${\n}Required relationship list not found for:${relationShipList}  
    ##----------------->>Network Validation-Cloud<<----------------------##
    &{RelkeyValDict}        NARAD Update Relationship Values    &{excelVal}                             #updates network name(relationship-value)
    ${Network_ID}           Set Variable                        &{RelkeyValDict}[relationship-value]
    Narad Cloud Validation    ${Network_ID}                       &{excelVal}
     ##------------------>>Network Validation-Vlan<<------------------##
     NARAD VLAN Validation    ${Network_ID}    &{excelVal}
AAI Validations
    ${SpecificExcelRowNum}    Convert To Integer    ${SpecificExcelRowNum} 
    &{excelVal}            Fetch Data From Excel                 CAGG_Host                                               ${SpecificExcelRowNum}
    Log To Console         ${excelVal}
    &{keyValDict}          Create Dictionary Values for NARAD    @{AAI_JSONKey}                                          &{excelVal}
    ${aai_SIID}            Set Variable                          ${pre_ADD_SIID}-&{keyValDict}[service-instance-name]
    ${updatedResource}     Update Resource End URL               ${AAI_customerResource}                                 ${aai_SIID}
    ${response}            ${json_response}                      Run AAI Get Request                                     ${updatedResource}
    JSON Tag Validation    ${json_response}                      service-instance-id                                     ${aai_SIID}
    ####-------------->>Relationship-Values Validation<<-------------------###
    ${status}         ${relationShipList}    AAI Relationship Key Validation    ${json_response}                                                              &{excelVal}
    Run Keyword If    ${status}==False       Fail                               msg=${\n}${\n}Required relationship list not found for:${relationShipList}
    ##----------------->>Network Validation-Cloud<<----------------------##
    &{RelkeyValDict}        AAI Update Relationship Values    &{excelVal}                             #updates network name(relationship-value)
    ${Network_ID}           Set Variable                      &{RelkeyValDict}[relationship-value]
    AAI Cloud Validation    ${Network_ID}                     &{excelVal}
    ##------------------>>Network Validation-Vlan<<------------------##
    AAI VLAN Validation    ${Network_ID}    &{excelVal}
    
AAI VLAN and Cloud Validation With existing DATA
    ${response}                     ${json_response}                        Run NARAD Get Request          ${AAI_networkVAlidation}
    Update JSON NARAD Dummy File    ${json_response}
    ${relationShipList}             NARAD Fetch Relationship List           ${json_response}
    ${data}                         Format NARAD Response for Validation    ${relationShipList}
    ${listCount}                    ${RelationshipList}                     Get NARAD Relationship List    ${data}
    ${status}                       Response Validation                     ${RelationshipList}            &{AAI_VLAN_INFO}
    ${status}                       Response Validation                     ${RelationshipList}            &{AAI_CLOUD_INFO}

NARAD VLAN and Cloud Validation
    ${response}                     ${json_response}                        Run NARAD Get Request          ${NARAD_networkValidation}
    Update JSON NARAD Dummy File    ${json_response}
    ${relationShipList}             NARAD Fetch Relationship List           ${json_response}
    ${data}                         Format NARAD Response for Validation    ${relationShipList}
    ${listCount}                    ${RelationshipList}                     Get NARAD Relationship List    ${data}
    ${status}                       Response Validation                     ${RelationshipList}            &{NARAD_SERVICE_INFO} 
    ${status}                       Response Validation                     ${RelationshipList}            &{NARAD_CLOUD_INFO}
    ${status}                       Response Validation                     ${RelationshipList}            &{NARAD_SUBNET_INFO}
    ${status}                       Response Validation                     ${RelationshipList}            &{NARAD_VLAN_INFO}

NARAD Validation from DATA File Values
    ${response}                     ${json_response}                        Run NARAD Get Request          ${NARAD_customerResource}
    Update JSON NARAD Dummy File    ${json_response}
    JSON Tag Validation   ${json_response}    service-instance-id    ${NARAD_ServiceInstanceID}
    ${relationShipList}             NARAD Fetch Relationship List           ${json_response}
    ${data}                         Format NARAD Response for Validation    ${relationShipList}
    ${listCount}                    ${RelationshipList}                     Get NARAD Relationship List    ${data}
    ${status}                       Response Validation                    ${RelationshipList}      &{NARAD_CustomerValidation}
AAI Validation2
   ${response}    ${json_response}    Run NARAD Get Request   ${AAI_customerResource}
   Update JSON NARAD Dummy File    ${json_response}
    ${relationShipList}             NARAD Fetch Relationship List           ${json_response}
    ${data}                         Format NARAD Response for Validation    ${relationShipList}
    ${listCount}                    ${RelationshipList}                     Get NARAD Relationship List    ${data}
    ${status}                       Response Validation                     ${RelationshipList}    &{AAI_CustomerValidation}

