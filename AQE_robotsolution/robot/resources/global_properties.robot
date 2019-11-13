*** Settings ***
Documentation                                   store all properties that can change or are used in multiple places here
...                                             format is all caps with underscores between words and prepended with GLOBAL
...                                             make sure you prepend them with GLOBAL so that other files can easily see it is from this file.
*** Variables ***
${GLOBAL_SELENIUM_BROWSER_CAPABILITIES}         Create Dictionary
${GLOBAL_SELENIUM_BROWSER}                      Chrome    #Firefox
${GLOBAL_SELENIUM_BROWSER_IMPLICIT_WAIT}        120s