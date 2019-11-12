*** Settings ***
Library             RequestsLibrary
Library             OperatingSystem
Resource            ../resources/global_properties.robot
Resource            ../resources/narad/narad_DATA.robot
Library             String
Library             ../library/myLibraries/json_implementation.py    
*** Variables ***
${NARAD_Vlan_Validation_Resource}            cloud-infrastructure/cloud-regions/cloud-region/att-nc/auk51b/vlan-range/dlp-VLAN-RANGE-101-200/vlan-tags/vlan-tag
${VERSIONED_INDEX_PATH}       narad/v2/
${NARAD_FRONTEND_ENDPOINT}    ${${GLOBAL_ENVIRONMENT}_GLOBAL_NARAD_SERVER_PROTOCOL} 
${vlanID}    167
*** Keywords ***
Save Response
     [Documentation]     Saves A&AI Responses
     [Arguments]         ${response}
     Create Directory    ${NARAD_RESPONSES}
     ${time}             Get Time
     ${time}             Split String                                     ${time}             ${SPACE}
     ${time_hr}          Replace String                                   @{time}[1]          :                    -
     ${json}             To Json                                          ${response.text}    pretty_print=True
     #Log To Console     Response Returned is: ${json}
     Create File         ${narad_RESPONSES}${/}@{time}[0]_${time_hr}.txt    content=${json}

Narad Get Request
    [Documentation]    Basic Get Request   
    [Arguments]    ${narad_RESOURCE_PATH}     ${vlanID}
    Log To Console    ${NARAD_FRONTEND_ENDPOINT} -->1 
    Log To Console    ${VERSIONED_INDEX_PATH}${narad_RESOURCE_PATH}?vlan-id-outer=${vlanID} -->2   
    
    ${session} =  Create Session    narad    ${NARAD_FRONTEND_ENDPOINT}       	verify=${AAI_CERT}
    ${headers}=  Create Dictionary     X-FromAppId=${X_FromAppId}     X-TransactionId=${X_TransactionId}    Accept=${Accept}    Content-Type=${Content_Type}
    #Make the call(and capture the response in a varibale) 
    ${response} =   Get Request  narad    ${VERSIONED_INDEX_PATH}${narad_RESOURCE_PATH}?vlan-id-outer=${vlanID}       headers=${headers} 
    #Check the response status 
    #Should Be Equal As Strings     ${response.status_code}    200
    #Saving Response
    Save Response    ${response}
    Log    ${response.status_code}
    Log to Console    Response Recieved with Status Code:${response.status_code} for GET Request.
    Create File    ${NARAD_DummyResponseFile}    
    [Return]    ${response}

Response Validation
    [Arguments]    ${jsonTagName}
    ${jsonDATA}    Get Binary File     ${NARAD_DummyResponseFile} 


*** Test Cases ***
NARAD Call
    ${Response}    Narad Get Request    ${NARAD_Vlan_Validation_Resource}    ${vlanID}
    Response Validation    ${Response}