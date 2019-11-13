*** Settings ***
Documentation     The main interface for interacting with VID. It handles low level stuff like managing the selenium request library and VID required steps
Library           Collections
Library           OSUtils
Library           OperatingSystem
Library           SeleniumLibrary   
 
 
Resource          global_properties.robot

*** Variables ***
${HEADLESS}   False
${FF_PROFILE_Latest}                ${EXECDIR}\\profile_ff

*** Keywords ***
Setup Browser
    [Documentation]   Sets up browser based upon the value of ${GLOBAL_SELENIUM_BROWSER}
    Run Keyword If    '${GLOBAL_SELENIUM_BROWSER}' == 'firefox' or '${GLOBAL_SELENIUM_BROWSER}' == 'Firefox'     Setup Browser Firefox
    Run Keyword If    "${GLOBAL_SELENIUM_BROWSER}"=="Chrome" or "${GLOBAL_SELENIUM_BROWSER}"=="chrome"       Setup Browser Chrome
    Log    Running with ${GLOBAL_SELENIUM_BROWSER}
 Setup Browser Firefox
    ${caps}    Evaluate    sys.modules['selenium.webdriver'].common.desired_capabilities.DesiredCapabilities.FIREFOX    sys,selenium.webdriver
    Set To Dictionary    ${caps}   elementScrollBehavior    1
    log to console   ${caps}
    Set Global Variable    ${FF_PROFILE}      ${FF_PROFILE_Latest}
    Create Webdriver    Firefox   desired_capabilities=${caps}  firefox_profile=${FF_PROFILE}  
    Delete All Cookies
Setup Browser Chrome
    ${chrome options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome options}    add_argument    no-sandbox
    Run Keyword If  ${HEADLESS}==True  Call Method    ${chrome options}    add_argument    headless
    ${dc}   Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME  sys, selenium.webdriver
    log to console  ${dc}
    Set To Dictionary   ${dc}   elementScrollBehavior    1
    SeleniumLibrary.Create Webdriver    Chrome   chrome_options=${chrome_options}    desired_capabilities=${dc}
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER_CAPABILITIES}    ${dc}

###################----> Old Code:-
Setup Browser Firefox_old
    Set Environment Variable    webdriver.firefox.driver    C:\\Users\\s07051\\AppData\\Local\\Mozilla Firefox\\firefox.exe  


	# ${firefox_path}=  Evaluate  sys.modules['selenium.webdriver'].firefox.firefox_binary.FirefoxBinary(firefox_path='C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe', log_file=None)  sys,selenium.webdriver
	# ${caps}=  Evaluate  sys.modules['selenium.webdriver'].common.desired_capabilities.DesiredCapabilities.FIREFOX    sys,selenium.webdriver
	# Set To Dictionary  ${caps}  marionette=${True}
	# Create WebDriver  Firefox  firefox_binary=${firefox_path}  capabilities=${caps}   firefox_profile=${FF_PROFILE_Latest} 



    # ${caps}    Evaluate    sys.modules['selenium.webdriver'].common.desired_capabilities.DesiredCapabilities.FIREFOX    sys,selenium.webdriver
    # # ${firefox_path}=  Evaluate  sys.modules['selenium.webdriver'].firefox.firefox_binary.FirefoxBinary(firefox_path='C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe', log_file=None)  sys
   # # ${firefox_path}   'C:/\Program Files (x86)/\Mozilla Firefox/\firefox.exe'
    # Log To Console    value is ${FF_PROFILE_Latest}
    ${caps}    Evaluate    sys.modules['selenium.webdriver'].common.desired_capabilities.DesiredCapabilities.FIREFOX    sys,selenium.webdriver
    Set To Dictionary    ${caps}   elementScrollBehavior    1
    #Set To Dictionary    ${caps}    marionette=${True}  
     Set To Dictionary    ${caps}   firefox_binary=C:\/Users\/s07051\/AppData\/Local\/Mozilla Firefox\/firefox.exe
        log to console   ${caps}
    Set Global Variable    ${FF_PROFILE}      ${FF_PROFILE_Latest}
    Create Webdriver    Firefox   desired_capabilities=${caps}  firefox_profile=${FF_PROFILE}  
     Delete All Cookies
     
    # Go To    https://stackoverflow.com
    # Sleep    2 s
    # [Teardown]    Close All Browsers
 Setup Browser Chrome_old
   # ${os}=   Get Normalized Os
   # Log    Normalized OS=${os}
    ${chrome options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome options}    add_argument    no-sandbox
    Run Keyword If  ${HEADLESS}==True  Call Method    ${chrome options}    add_argument    headless
    ${dc}   Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME  sys, selenium.webdriver
    log to console  ${dc}
    Set To Dictionary   ${dc}   elementScrollBehavior    1
    SeleniumLibrary.Create Webdriver    Chrome   chrome_options=${chrome_options}    desired_capabilities=${dc}
    Set Global Variable    ${GLOBAL_SELENIUM_BROWSER_CAPABILITIES}    ${dc}

# Handle Proxy Warning
    # [Documentation]    Handle Intermediate Warnings from Proxies
    # ${status}    ${data}=    Run Keyword And Ignore Error   Variable Should Exist    \${GLOBAL_PROXY_WARNING_TITLE}
    # Return From Keyword if    '${status}' != 'PASS'
    # ${status}    ${data}=    Run Keyword And Ignore Error   Variable Should Exist    \${GLOBAL_PROXY_WARNING_CONTINUE_XPATH}
    # Return From Keyword if    '${status}' != 'PASS'
    # Return From Keyword if    "${GLOBAL_PROXY_WARNING_TITLE}" == ''
    # Return From Keyword if    "${GLOBAL_PROXY_WARNING_CONTINUE_XPATH}" == ''
    # ${test}    ${value}=    Run keyword and ignore error    Title Should Be     ${GLOBAL_PROXY_WARNING_TITLE}
    # Run keyword If    '${test}' == 'PASS'    Click Element    xpath=${GLOBAL_PROXY_WARNING_CONTINUE_XPATH}