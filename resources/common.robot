*** Settings ***
Library                     Collections
Library                     String

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


extract key from pattern
    [Arguments]    ${pattern}
    ${parts} =    split string    ${pattern}    ::
    ${parts_length}=    get length    ${parts}
    Run Keyword If    ${parts_length} < 2    Fail    Invalid pattern format: ${pattern}
    ${key} =      replace string    ${parts[-1]}    $       ${EMPTY}
    RETURN    ${key}


resolve pattern
    [Arguments]    ${pattern}
    ${key} =    extract key from pattern    ${pattern}
    ${value} =  get context value    ${key}
    ${resolved} =   replace string    ${pattern}    $${key}     ${value}
    RETURN    ${resolved}