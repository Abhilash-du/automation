*** Settings ***
Documentation    Create,Delete and Edit Different Scope, Policy and Dictionary 
Resource    ../resources/POLICY/POLICY_RESOURCE.robot

*** Keywords ***
ShakeOut Policy
    Login To Portal
    Go to Policy Manager 
    Create Scope  
    Add SubScope
    Go To Dictinary
    Select Dictionary           ${ACTION_POLICY_DICTIONARY}    ${ACTION_DICTIONARY}
    Create Action Dictionary
    Edit Action Dictionary
    Delete Dictionary           ${ACTION_DICTIONARY}
    Go To Editor
    Right Click on Scope 
    Select Policy Type    ${ACTION_POLICY}    ${NO_SUBTYPE}
    Create Action Policy
    Save Policy and Close template  
    Goto Scope
    Right Click On Action Policy
    Edit Policy 
    Save Policy and Close template 
    Right Click On Action Policy 
    Delete Policy
    Go To Editor
    Delete Scope      
    Close Execution      