*** Settings ***
Library                     Collections

*** Keywords ***
create test context
    ${ctx}=    create dictionary
    set test variable    ${CTX}    ${ctx}


set context value
    [Arguments]     ${key}      ${value}
    set to dictionary    ${CTX}    ${key}=${value}


get context value
    [Arguments]     ${key}
    dictionary should contain key       ${CTX}      ${key}
    ${value} =  get from dictionary     ${CTX}      ${key}
    RETURN    ${value}
