

*** Settings ***
Library             SeleniumLibrary          
Library             OperatingSystem
Library             String
Library             Screenshot
Library             testScreenshot  
Library             callReporter
Library              pyautogui
Library                pyperclip 
Library                clipboard    
Library               ScreenCapLibrary     # PyGTK       #screenshot_module=
Library             testLib
Library             restartModule 
#Library            tryLib 
#Library              ../library/myLibraries/PreloadExcelManipulation.py      
Library             ../library/myLibraries/testScreenshot.py

*** Variable ***
${time}             300s
${DESC}             ASDC Smoke Test Automation
${result}
#${username} 
@{takeSnapshot}
${conn_url} 
${session_id}
${count}   1
${snapValue}   
${countString}
${elementName} 
${FF_PROFILE}                ${EXECDIR}\\firefoxProfile
${textGot}    
${path}         ${EXECDIR}\\robot\\library\\myLibraries



*** Keywords ***
#inputs texts in the xpath provided
set dictionary variable
    set global Variable      ${snapValue}      @{takeSnapshot}[0] 
    log to console  ${elementName} 
    
Common Input Text 

    [Arguments]                      ${elementName}                                                         ${xpath}                                          ${value}                                   @{takeSnapshot}
    Wait Until Element Is visible    ${xpath}                                                               timeout=${time}
    Wait Until Element Is Enabled    ${xpath}                                                               timeout=${time}
    ${i}                             Run Keyword And Return Status                                          Evaluate                                          @{takeSnapshot}[0]                         #
   # log to console                   value is ${i}
    Run Keyword If                   '${i}' == 'False'                                                      log to console                                    action taken :${elementName}
    ...                              ELSE                                                                   Run Keywords                                      set global Variable                        ${snapValue}       @{takeSnapshot}[0]    AND    log to console    ${elementName}

    # log to console                 value of snapvalue is ${snapValue}
    Run Keyword If                   '${snapValue}' == 'y' or '${snapValue}' == 'Y' or '${i}' == 'False'    Wait Until Keyword Succeeds     3x     15s   Input Text Screenshot                             ${xpath}                                   ${value}
    ...                              ELSE IF                                                                '${snapValue}' == 'N' or '${snapValue}' == 'n'    Input Text                                 ${xpath}           ${value}
    ...                              ELSE                                                                   log to console                                    wrong value entered.Please enter Y or N


    
    
# inputs texts and takes screenshot
Input Text Screenshot
    [Arguments]                      ${xpath}             ${value}
    Wait Until Element Is visible    ${xpath}             timeout=${time}
    Wait Until Element Is Enabled    ${xpath}             timeout=${time}
    ${SnapDIR}                       takeSnapshot         ${EXECDIR}         ${SUITE NAME}    ${Test Name}
    Input Text                       ${xpath}             ${value}
    count Screeshots                 ${count}
   ScreenCapLibrary.Take Screenshot               ${SnapDIR}/mypic
    ${countString}                   Convert To String    ${count}
     
    #callApendFile     ${path}   input   pass   pass  ${SnapDIR}   ${countString}
    
#inputs password ithe xpath provided 
Common Input Password
    [Arguments]                      ${elementName}                                                         ${xpath}                                        ${value}                                   @{takeSnapshot}
    Wait Until Element Is visible    ${xpath}                                                               timeout=${time}
    Wait Until Element Is Enabled    ${xpath}                                                               timeout=${time}
    ${i}=                            Run Keyword And Return Status                                          Evaluate                                        @{takeSnapshot}[0]
    Run Keyword If                   ${i} == False                                                          log to console                                  ${elementName}
    ...                              ELSE                                                                   Run Keywords                                    set global Variable                        ${snapValue}       @{takeSnapshot}[0]    AND    log to console    ${elementName}
    Run Keyword If                   '${snapValue}' == 'y' or '${snapValue}' == 'Y' or '${i}' == 'False'    Wait Until Keyword Succeeds     3x     15s   Input Password Screenshot                       ${xpath}                                   ${value}
    ...                              ELSE IF                                                                '${snapValue}' == 'N' or ${snapValue} == 'n'    Input Password                             ${xpath}           ${value}
    ...                              ELSE                                                                   log to console                                  wrong value entered.Please enter Y or N
    
   # \    Exit For Loop If    ${x}=""
 
        
    
    
#inputs password and takes screenshot   
Input Password Screenshot
    [Arguments]                      ${xpath}             ${value}
    Wait Until Element Is visible    ${xpath}             timeout=${time}
    Wait Until Element Is Enabled    ${xpath}             timeout=${time}
    ${SnapDIR}                       takeSnapshot         ${EXECDIR}         ${SUITE NAME}    ${Test Name}
    #${SnapDIR}                      manage Snapshots
    Input Password                   ${xpath}             ${value}
    count Screeshots                 ${count}
    ScreenCapLibrary.Take Screenshot                  ${SnapDIR}/mypic
    ${countString}                   Convert To String    ${count}
   # callApendFile                    ${path}              input              pass             pass             ${SnapDIR}    ${countString}

#clicks on the element whose locator is provided   
Common Click Element 
    [Arguments]                      ${elementName}                                                         ${xpath}                                          @{takeSnapshot}
   # Wait Until Page Contains    ${xpath}    timeout=${time}
     log to console  trying to click${xpath}
    Wait Until Element Is visible    ${xpath}                                                               timeout=${time}
    Wait Until Element Is Enabled    ${xpath}                                                               timeout=${time}
    ${i}=                            Run Keyword And Return Status                                          Evaluate                                          @{takeSnapshot}[0]
    Run Keyword If                   ${i} == False                                                          log to console                                    ${elementName}
    ...                              ELSE                                                                   Run Keywords                                      set global Variable                        ${snapValue}    @{takeSnapshot}[0]    AND    log to console    ${elementName}
    Run Keyword If                   '${snapValue}' == 'y' or '${snapValue}' == 'Y' or '${i}' == 'False'    Wait Until Keyword Succeeds     8x     20s       Click Element Screenshot                          ${xpath}
    ...                              ELSE IF                                                                '${snapValue}' == 'N' or '${snapValue}' == 'n'   Wait Until Keyword Succeeds     8x     30s    Click Element                              ${xpath}
    ...                              ELSE                                                                   log to console                                    wrong value entered.Please enter Y or N

   
#clicks on the element and takes screenshot    
Click Element Screenshot
    [Arguments]                      ${xpath}
    Wait Until Element Is visible    ${xpath}             timeout=${time}
    Wait Until Element Is Enabled    ${xpath}             timeout=${time}
    ${SnapDIR}                       takeSnapshot         ${EXECDIR}         ${SUITE NAME}    ${Test Name}
    #${SnapDIR}                      manage Snapshots
    Click Element                    ${xpath}
    count Screeshots                 ${count}
    ScreenCapLibrary.Take Screenshot                 ${SnapDIR}/mypic
    ${countString}                   Convert To String    ${count}
  #  callApendFile                    ${path}              input              pass             pass            ${SnapDIR}    ${countString}
#clicks on a radio button whose grouoname is provided   
Common select radio button
    [Arguments]       ${elementName}                                                         ${groupName}                                      ${id}                                      @{takeSnapshot}
    ${i}=             Run Keyword And Return Status                                          Evaluate                                          @{takeSnapshot}[0]
    Run Keyword If    ${i} == False                                                          log to console                                    ${elementName}
    ...               ELSE                                                                   Run Keywords                                      set global Variable                        ${snapValue}       @{takeSnapshot}[0]    AND    log to console    ${elementName}
    Run Keyword If    '${snapValue}' == 'y' or '${snapValue}' == 'Y' or '${i}' == 'False'    Select Radio Button Screenshot                    ${groupName}                               ${id}
    ...               ELSE IF                                                                '${snapValue}' == 'N' or '${snapValue}' == 'n'    Select Radio Button                        ${groupName}       ${id}
    ...               ELSE                                                                   log to console                                    wrong value entered.Please enter Y or N
#clicks on radio button and takes screenshot    
Select Radio Button Screenshot
    [Arguments]                       ${groupName}         ${id}
    #Wait Until Element Is Enabled    ${xpath}             timeout=${time}
    ${SnapDIR}                        takeSnapshot         ${EXECDIR}         ${SUITE NAME}    ${Test Name}
    #${SnapDIR}                       manage Snapshots
    Select Radio Button               ${groupName}         ${id}
    count Screeshots                  ${count}
    ScreenCapLibrary.Take Screenshot                   ${SnapDIR}/mypic
    ${countString}                    Convert To String    ${count}
   # callApendFile                     ${path}              input              pass             pass            ${SnapDIR}    ${countString}
    
#choosesa file and enters it in the xpath provides from the path provided    
Common Choose File   
    [Arguments]                      ${elementName}                                                         ${xpath}                                          ${value}                                   @{takeSnapshot}
    Wait Until Element Is visible    ${xpath}                                                               timeout=${time}
    Wait Until Element Is Enabled    ${xpath}                                                               timeout=${time}
    ${i}=                            Run Keyword And Return Status                                          Evaluate                                          @{takeSnapshot}[0]
    Run Keyword If                   ${i} == False                                                          log to console                                    ${elementName}
    ...                              ELSE                                                                   Run Keywords                                      set global Variable                        ${snapValue}       @{takeSnapshot}[0]    AND    log to console    ${elementName}
    Run Keyword If                   '${snapValue}' == 'y' or '${snapValue}' == 'Y' or '${i}' == 'False'    Choose File Screenshot                            ${xpath}                                   ${value}
    ...                              ELSE IF                                                                '${snapValue}' == 'N' or '${snapValue}' == 'n'    Choose File                                ${xpath}           ${value}
    ...                              ELSE                                                                   log to console                                    wrong value entered.Please enter Y or N
#chhose file and take screenshot 
Choose File Screenshot
    [Arguments]                      ${xpath}             ${value}
    Wait Until Element Is visible    ${xpath}             timeout=${time}
    Wait Until Element Is Enabled    ${xpath}             timeout=${time}
    ${SnapDIR}                       takeSnapshot         ${EXECDIR}         ${SUITE NAME}    ${Test Name}
    # ${SnapDIR}                     manage Snapshots
    Choose File                      ${xpath}             ${value}
    count Screeshots                 ${count}
    ScreenCapLibrary.Take Screenshot                  ${SnapDIR}/mypic
    ${countString}                   Convert To String    ${count}
   # callApendFile                    ${path}              input              pass             pass             ${SnapDIR}    ${countString}
#selecting frame    
Common Select Frame   
    [Arguments]       ${elementName}                                                         ${xpath}                                          @{takeSnapshot}
    ${i}=             Run Keyword And Return Status                                          Evaluate                                          @{takeSnapshot}[0]
    Run Keyword If    ${i} == False                                                          log to console                                    ${elementName}
    ...               ELSE                                                                   Run Keywords                                      set global Variable                        ${snapValue}    @{takeSnapshot}[0]    AND    log to console    ${elementName}
    Run Keyword If    '${snapValue}' == 'y' or '${snapValue}' == 'Y' or '${i}' == 'False'    Select Frame Screenshot                           ${xpath}
    ...               ELSE IF                                                                '${snapValue}' == 'N' or '${snapValue}' == 'n'    Select Frame                               ${xpath}
    ...               ELSE                                                                   log to console                                    wrong value entered.Please enter Y or N

Select Frame Screenshot
    [Arguments]                       ${xpath}
    #Wait Until Element Is Enabled    ${xpath}                timeout=250s
    ${SnapDIR}                        takeSnapshot            ${EXECDIR}      ${SUITE NAME}    ${Test Name}
    #${SnapDIR}                       manage Snapshots
    log to console                    calling select frame
    Select Frame                      ${xpath}
    count Screeshots                  ${count}
    ScreenCapLibrary.Take Screenshot                   ${SnapDIR}/mypic
    ${countString}                    Convert To String       ${count}
  #  callApendFile                     ${path}                 input           pass             pass             ${SnapDIR}    ${countString}
#selecting value from dropdown    
Common Select From List By Value       
    [Arguments]                      ${elementName}                                                         ${xpath}                                          ${value}                                   @{takeSnapshot}
    Wait Until Element Is visible    ${xpath}                                                               timeout=${time}
    Wait Until Element Is Enabled    ${xpath}                                                               timeout=${time}
    ${i}=                            Run Keyword And Return Status                                          Evaluate                                          @{takeSnapshot}[0]
    Run Keyword If                   ${i} == False                                                          log to console                                    ${elementName}
    ...                              ELSE                                                                   Run Keywords                                      set global Variable                        ${snapValue}       @{takeSnapshot}[0]    AND    log to console    ${elementName}
    Run Keyword If                   '${snapValue}' == 'y' or '${snapValue}' == 'Y' or '${i}' == 'False'    Select From List By Value Screenshotshot          ${xpath}                                   ${value}
    ...                              ELSE IF                                                                '${snapValue}' == 'N' or '${snapValue}' == 'n'    Select From List By Value                  ${xpath}           ${value}
    ...                              ELSE                                                                   log to console                                    wrong value entered.Please enter Y or N

 
#selecting from list and take screenshot
Select From List By Value Screenshotshot    
    [Arguments]                      ${xpath}             ${value}
    Wait Until Element Is visible    ${xpath}             timeout=${time}
    Wait Until Element Is Enabled    ${xpath}             timeout=${time}
    ${SnapDIR}                       takeSnapshot         ${EXECDIR}         ${SUITE NAME}    ${Test Name}
    #${SnapDIR}                      manage Snapshots
    Select From List By Value        ${xpath}             ${value}
    count Screeshots                 ${count}
    ScreenCapLibrary.Take Screenshot                  ${SnapDIR}/mypic
    ${countString}                   Convert To String    ${count}
   # callApendFile                    ${path}              input              pass             pass             ${SnapDIR}    ${countString}
#selecting from list or dropdown by label(pass label)
Common Select From List By Label       
    [Arguments]                      ${elementName}                                                         ${xpath}                                          ${label}                                   @{takeSnapshot}
    Wait Until Element Is visible    ${xpath}                                                               timeout=${time}
    Wait Until Element Is Enabled    ${xpath}                                                               timeout=${time}
    ${i}=                            Run Keyword And Return Status                                          Evaluate                                          @{takeSnapshot}[0]
    Run Keyword If                   ${i} == False                                                          log to console                                    ${elementName}
    ...                              ELSE                                                                   Run Keywords                                      set global Variable                        ${snapValue}       @{takeSnapshot}[0]    AND    log to console    ${elementName}
    Run Keyword If                   '${snapValue}' == 'y' or '${snapValue}' == 'Y' or '${i}' == 'False'    Select From List By label Screenshotshot          ${xpath}                                   ${label}
    ...                              ELSE IF                                                                '${snapValue}' == 'N' or '${snapValue}' == 'n'    Select From List By label                  ${xpath}           ${label}
    ...                              ELSE                                                                   log to console                                    wrong value entered.Please enter Y or N

 
#selecting from list and take screenshot
Select From List By Label Screenshotshot    
    [Arguments]                      ${xpath}             ${label}
    Wait Until Element Is visible    ${xpath}             timeout=${time}
    Wait Until Element Is Enabled    ${xpath}             timeout=${time}
    ${SnapDIR}                       takeSnapshot         ${EXECDIR}         ${SUITE NAME}    ${Test Name}
    #${SnapDIR}                      manage Snapshots
    Select From List By label        ${xpath}             ${label}
    count Screeshots                 ${count}
    ScreenCapLibrary.Take Screenshot                  ${SnapDIR}/mypic
    ${countString}                   Convert To String    ${count}
   # callApendFile                    ${path}              input              pass             pass             ${SnapDIR}    ${countString}
#selecting from list or dropdown by label(pass label)

Common Select From List By Index       
    [Arguments]                      ${elementName}                                                         ${xpath}                                          ${index}                                   @{takeSnapshot}
    Wait Until Element Is visible    ${xpath}                                                               timeout=${time}
    Wait Until Element Is Enabled    ${xpath}                                                               timeout=${time}
    ${i}=                            Run Keyword And Return Status                                          Evaluate                                          @{takeSnapshot}[0]
    Run Keyword If                   ${i} == False                                                          log to console                                    ${elementName}
    ...                              ELSE                                                                   Run Keywords                                      set global Variable                        ${snapValue}       @{takeSnapshot}[0]    AND    log to console    ${elementName}
    Run Keyword If                   '${snapValue}' == 'y' or '${snapValue}' == 'Y' or '${i}' == 'False'    Select From List By index Screenshotshot          ${xpath}                                   ${index}
    ...                              ELSE IF                                                                '${snapValue}' == 'N' or '${snapValue}' == 'n'    Select From List By index                  ${xpath}           ${index}
    ...                              ELSE                                                                   log to console                                    wrong value entered.Please enter Y or N

 
#selecting from list or dropdown by label(pass label)  and take screenshot 
Select From List By Index Screenshotshot    
    [Arguments]                      ${xpath}             ${index}
    Wait Until Element Is visible    ${xpath}             timeout=${time}
    Wait Until Element Is Enabled    ${xpath}             timeout=${time}
    ${SnapDIR}                       takeSnapshot         ${EXECDIR}         ${SUITE NAME}    ${Test Name}
    #${SnapDIR}                      manage Snapshots
    Select From List By index        ${xpath}             ${index}
    count Screeshots                 ${count}
    ScreenCapLibrary.Take Screenshot                  ${SnapDIR}/mypic
    ${countString}                   Convert To String    ${count}
   # callApendFile                    ${path}              input              pass             pass             ${SnapDIR}    ${countString}

Common get Text 
    [Arguments]                      ${elementName}                                                         ${xpath}                                          @{takeSnapshot}
    Wait Until Element Is Visible    ${xpath}                                                               timeout=${time}
    ${i}=                            Run Keyword And Return Status                                          Evaluate                                          @{takeSnapshot}[0]
    Run Keyword If                   ${i} == False                                                          log to console                                    ${elementName}
    ...                              ELSE                                                                   Run Keywords                                      set global Variable                          ${snapValue}    @{takeSnapshot}[0]    AND    log to console    ${elementName}
    Run Keyword If                   '${snapValue}' == 'y' or '${snapValue}' == 'Y' or '${i}' == 'False'    get text screenshot                               ${xpath}
    ...                              ELSE IF                                                                '${snapValue}' == 'N' or '${snapValue}' == 'n'    get text without screenshot                  ${xpath}
    ...                              ELSE                                                                   log to console                                    wrong value entered .Please enter Y or N
    [Return]                         ${textGot}


       
get text without screenshot 
    [Arguments]                      ${xpath}
    Wait Until Element Is Visible    ${xpath}      timeout=${time}
    ${textGot}                       get text      ${xpath}
    ${textGot}  Strip String    ${textGot}    both
    Set Global Variable              ${textGot}
get text screenshot 		
    [Arguments]                      ${xpath}
    Wait Until Element Is Visible    ${xpath}             timeout=${time}

    ${SnapDIR}                       takeSnapshot         ${EXECDIR}         ${SUITE NAME}    ${Test Name}
    ${textGot}                       get text             ${xpath}
      ${textGot}  Strip String    ${textGot}    both
    count Screeshots                 ${count}
    ScreenCapLibrary.Take Screenshot                  ${SnapDIR}/mypic
    ${countString}                   Convert To String    ${count}
   # callApendFile                    ${path}              input              pass             pass            ${SnapDIR}    ${countString}
    Set Global Variable              ${textGot}
    
Common Open Context Menu 
    [Arguments]                      ${elementName}                                                         ${xpath}                                          @{takeSnapshot}
    Wait Until Element Is Visible    ${xpath}                                                               timeout=${time}
    Wait Until Element Is Enabled    ${xpath}                                                               timeout=${time}
    ${i}=                            Run Keyword And Return Status                                          Evaluate                                          @{takeSnapshot}[0]
    Run Keyword If                   ${i} == False                                                          log to console                                    ${elementName}
    ...                              ELSE                                                                   Run Keywords                                      set global Variable                        ${snapValue}    @{takeSnapshot}[0]    AND    log to console    ${elementName}
    Run Keyword If                   '${snapValue}' == 'y' or '${snapValue}' == 'Y' or '${i}' == 'False'    Open Context Menu Screenshot                      ${xpath}
    ...                              ELSE IF                                                                '${snapValue}' == 'N' or '${snapValue}' == 'n'    Open Context Menu                          ${xpath}
    ...                              ELSE                                                                   log to console                                    wrong value entered.Please enter Y or N

Open Context Menu Screenshot
   [Arguments]                      ${xpath}
   Wait Until Element Is Visible    ${xpath}             timeout=${time}
   Wait Until Element Is Enabled    ${xpath}             timeout=${time}
   ${SnapDIR}                       takeSnapshot         ${EXECDIR}         ${SUITE NAME}    ${Test Name}
   #${SnapDIR}                      manage Snapshots
   Open Context Menu                ${xpath}
   count Screeshots                 ${count}
   ScreenCapLibrary.Take Screenshot                  ${SnapDIR}/mypic
   ${countString}                   Convert To String    ${count}
  # callApendFile                    ${path}              input              pass             pass             ${SnapDIR}    ${countString}
#counting total scrrenshots
count Screeshots
    [Arguments]            ${count}
    ${countNew}            Evaluate    ${count}+1
    Set Global Variable    ${count}    ${countNew}

       
#getting usename from encrypted file
common get username
     Set Log Level    NONE
    @{credentials}    call Authentication    ${CURDIR}\\..\\..\\properties\\Input
    ${username}       Strip String          @{credentials}[0]                       both
    [Return]          ${username}

       
common manage Snapshots
    ${username}       common get username
    log to console    value is ${username}
    takeSnapshot      ${EXECDIR}              ${SUITE NAME}    ${Test Name}


#getting password value from encrypted file  
common get password
     Set Log Level    NONE
    @{credentials}    call Authentication    ${CURDIR}\\..\\..\\properties\\Input
    ${password}=      Strip String          @{credentials}[1]                       both
    [Return]          ${password}
common get itservices password 
     Set Log Level    NONE
    @{credentials}    call Authentication    ${CURDIR}\\..\\..\\properties\\Input
    ${itServicesPassword}=      Strip String          @{credentials}[2]                       both
    [Return]          ${itServicesPassword}
common get rsa Pin 
    #Set Log Level    NONE
    @{credentials}    call Authentication    ${CURDIR}\\..\\..\\properties\\Input
    ${pin}=      Strip String          @{credentials}[3]                       both
    [Return]          ${pin}         
common get Test itServices Password 
     Set Log Level    NONE
    @{credentials}    call Authentication    ${CURDIR}\\..\\..\\properties\\Input
    ${testItServices}=      Strip String          @{credentials}[4]                       both
    [Return]          ${testItServices}        
#find and replace an old value with new one in the file whose path is given
common find replace
     [Arguments]   ${elementName}   ${filename}  ${old}   ${new}
      find replace  ${filename}  ${old}   ${new}
#setting execution url and session id in a file whose path is given 
replace browserProps
    log to console    testing
    ${conn_url}       ${session_id}                                              return Driver Props

    log to console    conn_url is ${conn_url}
    log to console    session_id is ${session_id}
    find replace      ${EXECDIR}\\properties\\integration_robot_properties.py    GLOBAL_REMOTE_URL = "[a-zA-Z://0-9.]*"    GLOBAL_REMOTE_URL = "${conn_url}"
    find replace      ${EXECDIR}\\properties\\integration_robot_properties.py    GLOBAL_SESSION_ID = "[a-z0-9]*"           GLOBAL_SESSION_ID = "${session_id}"
    Set Global Variable    ${conn_url}  
    Set Global Variable    ${session_id}      
    sleep             2s
   # log to console    session previous is ${GLOBAL_SESSION_ID}
    #Set Driver Session ID    ${GLOBAL_SESSION_ID}
common JS Click Element
	[arguments]   ${element_xpath}
	Wait Until Element Is Visible   ${element_xpath}           timeout=${time}
    Wait Until Element Is Enabled    ${element_xpath}             timeout=${time}
	log to console   clicking ${element_xpath} with javascript
	count Screeshots                 ${count}
	${SnapDIR}                       takeSnapshot         ${EXECDIR}         ${SUITE NAME}    ${Test Name}
    ScreenCapLibrary.Take Screenshot                  ${SnapDIR}/mypic
    ${countString}                   Convert To String    ${count}
	Wait Until Keyword Succeeds   5x  7s    Execute JavaScript  document.evaluate("${element_xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();  
common click and drag
    [arguments]   ${xcoordinate}  ${ycoordinate}
    ${xcoordinate}   Evaluate    int(${xcoordinate})  
     ${ycoordinate}  Evaluate    int(${ycoordinate}) 
    drag to      ${xcoordinate}       ${ycoordinate}   duration=5.0   button=left	#mouseDownUp=False
common mouse position
    ${position}    Position 
    [return]        ${position} 
common move to
    [arguments]   ${xcoordinate}  ${ycoordinate}
    ${xcoordinate}   Evaluate    int(${xcoordinate})  
     ${ycoordinate}  Evaluate    int(${ycoordinate})
     Move To     ${xcoordinate}  ${ycoordinate}  duration=5.0 
    
common pyauto click
    [arguments]   ${xcoordinate}  ${ycoordinate}
    ${xcoordinate}   Evaluate    int(${xcoordinate})  
     ${ycoordinate}  Evaluate    int(${ycoordinate})
     click     ${xcoordinate}  ${ycoordinate}  #duration=3.0 
common get clipboard
    ${clipboardValue}     pyperclip.Paste   
    [return]   ${clipboardValue}
     
Authentication
    [Documentation]    This Keyword Encripts and Decripts the Credentials Supplied by the User.
    # log to console    test1
    ${userid}        common get username
    ${password}      common get password  
    Set Global Variable    ${GLOBAL_USERID}    ${userid}     
    Set Global Variable    ${GLOBAL_PWD}       ${password}    
Update Network preload files
    [Arguments]   ${filepath}  ${filename}   ${sheetnames}  ${parameterName}
    
      Update Preload Excel  ${filepath}  ${filename}   ${sheetnames}  ${parameterName}









