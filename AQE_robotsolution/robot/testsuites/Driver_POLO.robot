*** Settings ***
Library    SeleniumLibrary
Library    String
Library    DateTime
Library    callReporter   
Library    testScreenshot    
Library    OSUtils

Resource          ../resources/global_properties.robot
Resource        ../resources/browser_setup.robot
Resource        ../resources/POLO/POLO_RESOURCE.robot

*** Variables ***
#${GROUP_ADDON}
#OR
${txtPOLO_UserId}                           xpath=//input[@name='userid']
${txtPOLO_Password}                         xpath=//input[@name='password']
${txtPOLO_TitleMessage}                     xpath=//span[@id='srv_TitleMsg']
${btnPOLO_OK}                               xpath=//input[@name='successOK']
${btnPOLO_Submit}                           xpath=//input[@name='btnSubmit']
${lnkPOLO_ClickHereToLogin}                 xpath=//a[@id='cspAndReturn']
${lnkPOLO_ClikHereToLogin_2}                xpath=//a[text()='Click here to login']
${divPOLO_PoloIcon}                         xpath=//div[@id='gridster-POLO-icon-link']
${framePOLO}                                xpath=//iframe[@id="tabframe-POLO"]
${divPOLO_HomeScreen}                       xpath=//*[contains(text(),'Portal Open Loop Operations (POLO)')]

${btnPOLO_AddTenantVRF}				        //tr[@id='row_vrfconfig']//a[text()='ADD-TENANT-VRF']
${lnkPOLO_AddTenantVRFName}			        //*[text()='ADD-TENANT-VRF ${VRF_NAME}']

${lnkPOLO_TenantNetworkTile}                xpath=//a[contains(.,'NC1.0 Features') and contains(.,'Tenant Network')]
${lblPOLO_NC1Features}                      xpath=//*[contains(text(),'NC1 Features')]
${txtPOLO_ComplexID}                        xpath=//input[@id='complexid']
${txtPOLO_RegionID}                         xpath=//input[@id='regionid']
${txtPOLO_ZoneID}                           xpath=//input[@id='zoneid']
${lnkPOLO_LocationSearch}                   //a[@id='btnlocationsrch']
${lnkPOLO_InServiceTab}                     //*[@id="tabcarr_ncftab1_li"]
${lnkPOLO_TenentSecurity}                   xpath=//a[contains(text(),'Tenant Security')]
${drpPOLO_TenantSecurityType}               //span[@id="pf_${GROUP_ADDON}"]/..//select
${btnPOLO_AssignActivate}                   //a[@id="${GROUP_ADDON}_btnpincfeature"]
${spanPOLO_AddTenantSecurityHeader}         //h3[text()='ADD-TENANT-SECURITY ${GROUP_ADDON}']
${lnkPOLO_TenantVRF}				//a[contains(text(),'Tenant VRF')]
${drpPOLO_RegionDropdown}		//select[@id='ncvrfregion']
${drpPOLO_VRFDropdown}			//select[@id='ncvrf']
${btnPOLO_DeleteTenantVRF}		//tr[@id='row_vrfconfig']//a[text()='DELETE-TENANT-VRF']
${lnkPOLO_DeleteTenantVRFName}			//*[text()='DELETE-TENANT-VRF ${VRF_NAME}']
${drpPOLO_SelectPrecheck}			//select[@id='device_hdcode_${VRF_NAME}_pre']
${drpPOLO_HealthCheckPreButton}		//a[@id='btn_device_hdcode_${VRF_NAME}_pre']
${lnkPOLO_GenDeleteTab}			//a[text()='gendelete']
${lnkPOLO_GenDeleteButton}		//div[@id='poptab_${VRF_NAME}_gendelete']//a
${drpPOLO_SelectPostCheck}	//select[@id='device_hdcode_${VRF_NAME}_post']
${lnkPOLO_HealthCheckPostButton}		//a[@id='btn_device_hdcode_${VRF_NAME}_post']
${lnkPOLO_DuplicateIpCheckButton_VRF}		//div[@id='poptab_${VRF_NAME}_duplicate-ip-check']//a

${divPOLO_TenantSecurity_PreCheckButton}    //div[@id='poptab_${GROUP_ADDON}_pre-check']//a

${lnkPOLO_AssignTab}                        //a[text()='Assign']
${lnkPOLO_AssignButton}                     //div[@id='poptab_${GROUP_ADDON}_assign']//a
${lnkPOLO_NetworkObjGrpCheckTab}            //a[text()='network-object-group-check']
${lnkPOLO_NetworkObjGrpCheckButton}         /div[@id='poptab_${GROUP_ADDON}_network-object-group-check']//a
${lnkPOLO_ActivateTab}                      //a[text()='Activate']
${lnkPOLO_ActivateButton}                   //div[@id='poptab_${GROUP_ADDON}_activate']//a
${lnkPOLO_POSTCheckTab}                     //a[text()='POST-Check']
${lnkPOLO_PostCheckButton}                  //div[@id='poptab_${GROUP_ADDON}_post-check']//a
${lnkPOLO_DuplicateIpCheckTab}              //a[text()='Duplicate-ip-check']
${lnkPOLO_DuplicateIpCheckButton}           //div[@id='poptab_${GROUP_ADDON}_duplicate-ip-check']//a
${lnkPOLO_UnassignTab}				//a[text()='unassign']
${lnkPOLO_UnassignedButton}			//div[@id='poptab_${GROUP_ADDON}_unassign']//a
${lnkPOLO_DeleteTab}				//a[text()='delete']
${lnkPOLO_DeleteButton}					//div[@id='poptab_${GROUP_ADDON}_delete']//a 


${btnPOLO_Close}                            //button[text()='Close']

#DATA
${PORTAL_URL_ETE_1902}                      https://www.e-access.att.com/ecomp_portal_ete3/ecompui/login.htm
${PORTAL_URL_IST_1902}                      https://www.e-access.att.com/ecomp_portal_ist/ecompui/login.htm
#${GLOBAL_ENVIRONMENT}                       IST_1902


${GROUP_ADDON}                              #auk511604jl1
${TENANT_SECURITY}                          ADD-TENANT-SECURITY
${VRF_NAME}				ATMU
${COMPLEX_ID}        AUSFTXNK
${REGION_ID}    auk51b
${ZONE_ID}    auk51
${HEALTH_PRE_CHECK}            ${${GROUP_ADDON} - pre-check}
${HEALTH_POST_CHECK}            ${${GROUP_ADDON} - post-check}

${SHORT_WAIT}                               30
${LONG_WAIT}                                300
${MID_WAIT}                                100
${POLO_SERVICEINSTANCE}                    GRP-27529-T-IST-07A_TN_gn_sd_sx_direct_net-132

${NoOfGroupAddon}                         2
&{POLO_GroupAddonValue}                       GroupAddonValue_0=auk511604jl1        GroupAddonValue_1=auk511603jl1
${NoOfSubnets}                            2

*** Test Cases ***
Login to POLO
     Login to POLO
     1-Search Location
     Add Tenant Network
     #Add Tenant Network New
     #Add Subnet to Tenant Network     ${NoOfSubnets}        
           
    
    # 1-Search Location
    # ADD Tenant Security    ${GROUP_ADDON}
    # ADD Tenant VRF
Test
    Test 
     
    
*** Keywords ***



Switch to Frame - POLO
    Unselect Frame
    Select Frame    ${framePOLO}


#Login to POLO
    [Documentation]    This function logs in to POLO via PORTAL Application
    Log To Console    Execution Starting for Keyword - Login to POLO    
    Setup Browser
    Go To    ${PORTAL_URL_${GLOBAL_ENVIRONMENT}}
    #    Open Browser    ${PORTAL_URL_${GLOBAL_ENVIRONMENT}}    firefox
    Maximize Browser Window
    # Set Selenium Speed    ${GLOBAL_SELENIUM_DELAY}
    # Set Browser Implicit Wait    ${GLOBAL_SELENIUM_BROWSER_IMPLICIT_WAIT}
    Log    Logging in to ${PORTAL_URL_${GLOBAL_ENVIRONMENT}}
    
    Title Should Be    AT&T Security Server: Login
    
   
    ${USERNAME} =    Common Get Username
    ${PASSWORD} =    Common Get Password
    #Log to console   username entered is  ${Username}
    Common Input Text     Input User Name    ${txtPOLO_UserId}    ${USERNAME}   
    #Sleep   2
    Common Input Password     Input User Password    ${txtPOLO_Password}    ${PASSWORD}     
    #Sleep    2
    Common Click element    Click Ok Button    ${btnPOLO_Submit}
    # Wait Until Page Contains Element    ${txtCLAMP_TitleMessage}   ${GLOBAL_SELENIUM_BROWSER_WAIT_TIMEOUT}
    Common Click Element    Click SuccessOK Button    ${btnPOLO_OK} 
    Sleep    7
    Wait Until Page Contains Element    ${lnkPOLO_ClickHereToLogin}  ${MID_WAIT}
    Wait Until Element Is Enabled    ${lnkPOLO_ClickHereToLogin}  ${MID_WAIT}        
    Common Click Element    Click on 'Click here to Login' link    ${lnkPOLO_ClickHereToLogin}       
    
    Wait Until Page Contains Element    ${divPOLO_PoloIcon}    ${MID_WAIT}        #Wait until POLO icon is loaded on the Portal HomePage
    Wait Until Element Is Enabled    ${divPOLO_PoloIcon}    ${MID_WAIT}
    Sleep    5        
    Common Click Element    Click on POLO icon    ${divPOLO_PoloIcon}
    
    Wait Until Page Contains Element    ${framePOLO}    ${MID_WAIT}        #Wait until First Frame -POLO is loaded
    Sleep    5    
    Select Frame    ${framePOLO}
    
    Sleep    10
    #    Run Keyword And Return Status    Common Click Element    Click on Click here to Login - POLO    ${lnkPOLO_ClikHereToLogin_2}
    
    
    
   
    Wait Until Page Contains Element    ${divPOLO_HomeScreen}      ${MID_WAIT}    #Wait until the header is visible      
    Sleep    5       
    Log To Console    Logged in to  ${PORTAL_URL_${GLOBAL_ENVIRONMENT}}
    Log To Console    Execution Successful for Keyword - Login to POLO 
    Return From Keyword    0
    
# 1-Search Location
    # [Documentation]    Enter Complex ID, Region ID, Zone ID and search for location
    # Sleep    5
    # Wait Until Page Contains Element    ${lnkPOLO_TenantNetworkTile}
    # Common Click Element    Click on NC - Tenant Netword card    ${lnkPOLO_TenantNetworkTile}
    
    # Wait Until Page Contains Element    ${lblPOLO_NC1Features}
    
    # Common Input Text    Enter the Complex ID    ${txtPOLO_ComplexID}    ${COMPLEX_ID}
    # Common Input Text    Enter the Region ID    ${txtPOLO_RegionID}    ${REGION_ID}
    # Common Input Text    Enter the Zone ID    ${txtPOLO_ZoneID}    ${ZONE_ID}
    # Common Click Element    Click on the Search Button   ${lnkPOLO_LocationSearch}
    
# 2-ADD/DELETE Tenant Security
    # [Documentation]    Adds or Delete Tenant Security    
    # [Arguments]    ${GROUP_ADDON}            #    ${GROUP_ADDON} ->  auk511604jl1
    # Common Click Element    Click on In-Service tab    ${lnkPOLO_InServiceTab}
    # Common Click Element    Click on Tenant Secutiy    ${lnkPOLO_TenentSecurity}
    # Select From List By Value    ${drpPOLO_TenantSecurityType}    ADD-TENANT-SECURITY
    # Common Click Element    Click on Assign/Activate button    ${btnPOLO_AssignActivate} 
ADD Tenant Security
    [Documentation]     This keyword adds a tenant security
    [Arguments]    ${GROUP_ADDON}        #    ${GROUP_ADDON} ->  auk511604jl1
    
    Log To Console    *** Starting Execution for Keyword - ADD Tenant Security *** 
    Common Click Element    Click on In-Service tab    ${lnkPOLO_InServiceTab}
    Common Click Element    Click on Tenant Secutiy    ${lnkPOLO_TenentSecurity}
    Select From List By Value    ${drpPOLO_TenantSecurityType}    ADD-TENANT-SECURITY
    Common Click Element    Click on Assign/Activate button    ${btnPOLO_AssignActivate}



        
    
    
    Wait Until Page Contains Element    ${spanPOLO_AddTenantSecurityHeader}    #//h3[text()='ADD-TENANT-SECURITY auk511604jl1'] 
    #Pre-Check Tab
    Common Click Element    Click on Pre-Check Button    ${divPOLO_TenantSecurity_PreCheckButton}
    Sleep    5
    
    #Assign Tab
    Common Click Element    Click on Assign Tab    ${lnkPOLO_AssignTab}
    Common Click Element    Click on Assign Button    ${lnkPOLO_AssignButton}
    
    #Network Object Group Check tab
    Common Click Element    Click on Network-Object-Group-Check Tab    ${lnkPOLO_NetworkObjGrpCheckTab}
    Common Click Element    Click on Network-Object-Group-Check Button    ${lnkPOLO_NetworkObjGrpCheckButton}
    
    #Activate tab
    Common Click Element    Click on Activate Tab    ${lnkPOLO_ActivateTab}
    Common Click Element    Click on Activate Button    ${lnkPOLO_ActivateButton}
    #POST Check Tab
    Common Click Element    Click on POST-Check Tab    ${lnkPOLO_POSTCheckTab}
    Common Click Element    Click on POST-Check Button    ${lnkPOLO_PostCheckButton}
    #Duplicate-ip-check Tab
    Common Click Element    Click on Duplicate-ip-check Tab    ${lnkPOLO_DuplicateIpCheckTab}
    Common Click Element    Click on Duplicate-ip-check Button    ${lnkPOLO_DuplicateIpCheckButton}
    
    
    Common Click Element    Click on Close Button    ${btnPOLO_Close}
      
    Log To Console    *** Executed the Keyword - ADD Tenant Security                   


                    
DELETE Tenant Security
    [Documentation]     This keyword deletes a tenant security
    [Arguments]    ${GROUP_ADDON}
    Log To Console               *** Starting Execution for Keyword - DELETE Tenant Security ***
    Common Click Element         Click on In-Service tab            ${lnkPOLO_InServiceTab}
    Common Click Element         Click on Tenant Secutiy            ${lnkPOLO_TenentSecurity}
    Select From List By Value    ${drpPOLO_TenantSecurityType}      DELETE-TENANT-SECURITY
    Common Click Element         Click on Assign/Activate button    ${btnPOLO_AssignActivate}


    #Pre-Check Tab
    Common Click Element         Click on Pre-Check Button          ${divPOLO_TenantSecurity_PreCheckButton}
    Sleep                        5

    #unassign Tab
    Common Click Element         Click on Unassign Tab              ${lnkPOLO_UnassignTab}
    Common Click Element         Click on Unassign Button           ${lnkPOLO_UnassignedButton}

    #delete                      tab
    Common Click Element         Click on Delete Tab                ${lnkPOLO_DeleteTab}
    Common Click Element         Click on Delete Button             ${lnkPOLO_DeleteButton}
    #POST-Check Tab
    Common Click Element         Click on POST-Check Tab            ${lnkPOLO_POSTCheckTab}
    Common Click Element         Click on POST-Check Button         ${lnkPOLO_PostCheckButton}

    Common Click Element         Click on Close Button              ${btnPOLO_Close}

    Log To Console               *** Executed the Keyword - DELETE Tenant Security


    
ADD Tenant VRF
    [Documentation]    Adds a Tenant VRF
    
    Common Click Element                Click on In-Service tab               ${lnkPOLO_InServiceTab}
    Common Click Element                Click on Tenant Security              ${lnkPOLO_TenantVRF}
    Select From List By Value           ${drpPOLO_RegionDropdown}             ${REGION_ID}
    Sleep                               3
    Wait Until Page Contains Element    ${drpPOLO_VRFDropdown}                50
    Select From List By Value           ${drpPOLO_VRFDropdown}                ${VRF_NAME}
    Sleep                               3
    Wait Until Page Contains Element    ${btnPOLO_AddTenantVRF}               50
    Common Click Element                Click on ADD TENANT VRF               ${btnPOLO_AddTenantVRF}

    Wait Until Page Contains Element    ${lnkPOLO_AddTenantVRFName}           50

    #Health-Check-Pre
    Select From List By Value           ${drpPOLO_SelectPrecheck}             ${HEALTH_PRE_CHECK}
    Common Click Element                Click on Health Check Pre button      ${drpPOLO_HealthCheckPreButton}

    #Assign Tab
    Common Click Element                Click on Assign Tab                   ${lnkPOLO_AssignTab}
    Common Click Element                Click on Assign Button                ${lnkPOLO_AssignButton}
    #Activate tab
    Common Click Element                Click on Activate Tab                 ${lnkPOLO_ActivateTab}
    Common Click Element                Click on Activate Button              ${lnkPOLO_ActivateButton}
    #Health-Check-Post

    Select From List By Value           ${drpPOLO_SelectPostCheck}            ${HEALTH_POST_CHECK}
    Common Click Element                Click on Health Check Post button     ${lnkPOLO_HealthCheckPostButton}
    #Duplicate-ip-check Tab
    Common Click Element                Click on Duplicate-ip-check Tab       ${lnkPOLO_DuplicateIpCheckTab}
    Common Click Element                Click on Duplicate-ip-check Button    ${lnkPOLO_DuplicateIpCheckButton_VRF}
    Common Click Element                Click on Close Button                 ${btnPOLO_Close}
      
    Log To Console    *** Executed the Keyword - ADD Tenant VRF    
                
            
    


DELETE Tenant VRF
    [Documentation]    Deletes Tenant VRF
    
    Common Click Element                Click on In-Service tab                    ${lnkPOLO_InServiceTab}
    Common Click Element                Click on Tenant VRF                        ${lnkPOLO_TenantVRF}
    Select From List By Value           ${drpPOLO_RegionDropdown}                  ${REGION_ID}
    Sleep                               3
    Wait Until Page Contains Element    ${drpPOLO_VRFDropdown}                     50
    Select From List By Value           ${drpPOLO_VRFDropdown}                     ${VRF_NAME}
    Sleep                               3
    Wait Until Page Contains Element    ${btnPOLO_DeleteTenantVRF}                 50
    Common Click Element                Click on ADD TENANT VRF                    ${btnPOLO_DeleteTenantVRF}

    Wait Until Page Contains Element    ${lnkPOLO_DeleteTenantVRFName}             50

    #Health-Check-Pre
    Select From List By Value           ${drpPOLO_SelectPrecheck}                  ${HEALTH_PRE_CHECK}
    Common Click Element                Click on Health Check Pre button           ${drpPOLO_HealthCheckPreButton}

    #gendelete Tab
    Common Click Element                Click on gendelete Tab                     ${lnkPOLO_GenDeleteTab}
    Common Click Element                Click on gendelete Button                  ${lnkPOLO_GenDeleteButton}


    #unassign Tab
    Common Click Element                Click on Unassign Tab                      ${lnkPOLO_UnassignTab}
    Common Click Element                Click on Assign Button                     ${lnkPOLO_UnassignedButton}
    #delete tab
    Common Click Element                Click on Delete Tab                        ${lnkPOLO_DeleteTab}
    Common Click Element                Click on Delete Button                     ${lnkPOLO_DeleteButton}
    #Health-Check-Post

    Select From List By Value           ${drpPOLO_SelectPostCheck}                 ${HEALTH_POST_CHECK}
    Common Click Element                Click on Health Check Post button          ${lnkPOLO_HealthCheckPostButton}
    #Duplicate-ip-check Tab
    Common Click Element                Click on Network-Object-Group-Check Tab    ${lnkPOLO_DuplicateIpCheckTab}
    Common Click Element                Click on Network-Object-Group-Check Tab    ${lnkPOLO_DuplicateIpCheckButton_VRF}
    Common Click Element                Click on Close Button                      ${btnPOLO_Close}
      
    Log To Console    *** Executed the Keyword - DELETE Tenant VRF    
                
       
    
Add Tenant Network Old
    
    [Documentation]    Adding Tenant Network 
    
    Common Click Element    Click on In-Service tab    //*[@id="tabcarr_ncftab1_li"]
    Common Click Element    Click on Tenant Secutiy    //a[contains(text(),'Tenant VRF')]
    Select From List By Value   //select[@id='ncvrfregion']    auk51b
    Sleep    3    
    
    

    
 Add Tenant Network O
    #Created@Rishuvee
      
    [Documentation]    Adding Tenant Network   
    [Arguments]    ${GROUP_ADDON}
        
     Common Click Element    Click on In-Service tab    //*[@id="tabcarr_ncftab1_li"]
     Common Click Element    Click on Tenant Network    //a[contains(text(),'Tenant Network')] 
     ${errorstatus}    Run Keyword And Return Status    Wait Until Page Contains Element  //span[contains(text(),'System alert')]   50s        
     Run Keyword If    "${errorstatus}"=="True"    Click Element    xpath=//a[contains(text(),'Close')] 
          
     Common Click Element    Click on Tenant Network Again    //a[contains(text(),'Tenant Network')]
        
     Common Click Element    click on Region Id     //select[@id='ncregion']//option[@value='${REGION_ID}']    
     Common Click Element    click on Service Instance    //select[@id='ncserviceinstance']//option[text()='${POLO_SERVICEINSTANCE}']  
     Common Click Element    click on Add Subnet     //select[@id='${GROUP_ADDON}_action_dd']//option[@value='ADD-TENANT-NETWORK']
     Common Click Element    Select Text box    //input[@targetclass='chk_${GROUP_ADDON}_configs']
     Common Click Element    Select Text box    //a[@device='${GROUP_ADDON}']//i[@class='icon-play']
     #Rest part to be added ; done till Clicking at the group Addon after selecting All Network
     
Add Subnet to Tenant Network
    #Created@Rishuvee
     [arguments]    ${NoOfSubnets}
     
     
     Common Click Element    Click on In-Service tab    //*[@id="tabcarr_ncftab1_li"]
     Common Click Element    Click on Tenant Network    //a[contains(text(),'Tenant Network')] 
     # ${status}    Run Keyword And Return Status     Handle Alert    action=DISMISS  
     # Log To Console    msg-${status}  
     Sleep     5s
     Run Keyword And Continue On Failure    Common Click Element   Click on Close  //div[@class='modal-footer']//a[@id='btncloseDialog']    
     #Common Click Element   Click on Close  //div[@class='modal-footer']//a[@id='btncloseDialog']
     Log To Console    Clicked Close    
     Common Click Element    Click on Tenant Network    //a[contains(text(),'Tenant Network')]  
     #Select From List By Value   //select[@id='ncregion']    ${REGION_ID}
     Common Click Element    click on Region Id     //select[@id='ncregion']//option[@value='${REGION_ID}']    
     Common Click Element    click on Service Instance    //select[@id='ncserviceinstance']//option[text()='${POLO_SERVICEINSTANCE}']
     Common Click Element    click on Add Subnet     //select[@id='${GROUP_ADDON}_action_dd']//option[@value='ADD-SUBNET-TO-TENANT-NETWORK']
     # Get Number of Subnets to be selected
     
     :FOR  ${index}    IN RANGE   ${NoOfSubnets}  
     \  ${index}   Evaluate    ${index}+1 
     \  Log To Console    selecting index of value ${index}   
     \  Common Click Element   Select Text box    (//input[@class='chk_${GROUP_ADDON}_configs'])[${index}]
     \  ${subentname}    Get Text    xpath=(//input[@class='chk_auk511604jl1_configs'])[1]//parent::td//parent::tr//td[3] 
     \  Log To Console    Subnet-${subentname}    
     \  Append To File    ${EXECDIR}\\robot\\resources\\POLO\\POLO_DATA.robot   ${\n}\${${GROUP_ADDON}_SubnetName_${index}}${SPACE}${SPACE}${SPACE}${subentname}       
     
     # Common Click Element   Select Text box    //a[@device='${GROUP_ADDON}']//i[@class='icon-play']
     
     # Part to add R-LEAF remains and after closing that we would add next GROUP ADDON for same Network Instance
     
     
     
Delete Tenant Network
    #Created@Rishuvee
      
    [Documentation]    Delete Tenant Network   
    [Arguments]    ${GROUP_ADDON}
     
       
         Common Click Element    Click on In-Service tab    //*[@id="tabcarr_ncftab1_li"]
         Common Click Element    Click on Tenant Network    //a[contains(text(),'Tenant Network')]    
         Common Click Element    Click on Tenant Network Again    //a[contains(text(),'Tenant Network')]
        
         Common Click Element    click on Region Id     //select[@id='ncregion']//option[@value='${REGION_ID}']    
         Common Click Element    click on Service Instance    //select[@id='ncserviceinstance']//option[text()='${POLO_SERVICEINSTANCE}']  
         Common Click Element    click on Add Subnet     //select[@id='${GROUP_ADDON}_action_dd']//option[@value='DELETE-TENANT-NETWORK']
         Common Click Element    Select Text box    //input[@targetclass='chk_${GROUP_ADDON}_configs']
         Common Click Element    Select Text box    //a[@device='${GROUP_ADDON}']//i[@class='icon-play']     
     
  


    
 Add Tenant Network New
    #Created@Rishuvee
      
    [Documentation]    Adding Tenant Network   
    #[Arguments]    ${GROUP_ADDON}
    
           
        Common Click Element    Click on In-Service tab    //*[@id="tabcarr_ncftab1_li"]
        Common Click Element    Click on Tenant Network    //a[contains(text(),'Tenant Network')] 
        Sleep     5s
        Run Keyword And Continue On Failure    Common Click Element   Click on Close  //div[@class='modal-footer']//a[@id='btncloseDialog']    
     #Common Click Element   Click on Close  //div[@class='modal-footer']//a[@id='btncloseDialog']
        Log To Console    Clicked Close 
          
        Common Click Element    Click on Tenant Network Again    //a[contains(text(),'Tenant Network')]
     
          :FOR  ${index}    IN RANGE   ${NoOfGroupAddon} 
    \    ${GROUP_ADDON}  Set Variable   ${POLO_GroupAddonValue}[GroupAddonValue_${index}]  
    \    Log To Console    GroupAddon-${GROUP_ADDON} 
        
     \    Common Click Element    click on Region Id     //select[@id='ncregion']//option[@value='${REGION_ID}']    
     \    Common Click Element    click on Service Instance    //select[@id='ncserviceinstance']//option[text()='${POLO_SERVICEINSTANCE}']  
     \    Common Click Element    click on Add Subnet     //select[@id='${GROUP_ADDON}_action_dd']//option[@value='ADD-TENANT-NETWORK']
     \    Common Click Element    Select Text box    //input[@targetclass='chk_${GROUP_ADDON}_configs']
     \    Sleep     5s
     \    Common Click Element    click on Region Id     //select[@id='ncregion']//option[@value='${REGION_ID}']    
     \    Common Click Element    click on Service Instance    //select[@id='ncserviceinstance']//option[text()='${POLO_SERVICEINSTANCE}']  
     \    #Common Click Element    Select Text box    //a[@device='${GroupAddonValue}']//i[@class='icon-play']




  
Test
    
    #${index}  Set Variable    1
     # :FOR  ${INDEX}    IN RANGE   ${NoOfSubnets}
     # \    ${INDEX}    Evaluate    ${INDEX}+1
     # ${GroupAddonValue}  Set Variable   ${POLO_GROUPADDON}[GROUP_ADDON_0]  
     # Log To Console    GroupAddon-${GroupAddonValue}
     
           # :FOR  ${index}    IN RANGE   ${NoOfGroupAddon} 
    # \    ${GROUP_ADDON}  Set Variable   ${POLO_GroupAddonValue}[GroupAddonValue_${index}]  
    # \    Log To Console    GroupAddon-${GROUP_ADDON} 
     
     
     ${Env}    Split String From Right    ${GLOBAL_ENVIRONMENT}   _
     Log To Console   ${Env}[0]    
      #Append To File    ${EXECDIR}\\robot\\resources\\POLO\\POLO_DATA.robot   ${\n}\${${GROUP_ADDON}_SubnetName_1}${SPACE}${SPACE}${SPACE}TYED            
       
    