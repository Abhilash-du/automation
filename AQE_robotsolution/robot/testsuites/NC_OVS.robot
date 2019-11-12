*** Settings ***

Library    SeleniumLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     ../library/myLibraries/Replace.py
Library	      UUID      
Library	      Screenshot
Library       DateTime  
Resource  ../resources/mso/MSO_OR.robot
# Resource  ../resources/mso/MSO_properties.robot
Resource  ../resources/mso/NC/NC OVS/NCProperty.robot
Resource  ../resources/mso/NC/NC OVS/NetworkCloud_Execution.robot
Resource  ../resources/mso/NC/NC OVS/NetworkCloud_OR.robot
Resource  ../resources/mso/NC/NC OVS/input_keywords_nc.robot

*** Test Cases ***

NC Network Spinup OVS1
    
    NC Network Spinup OVS