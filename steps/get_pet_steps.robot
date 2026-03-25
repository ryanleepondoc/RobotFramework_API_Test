*** Settings ***
Library                     JSONLibrary
Library                     ../resources/get_pet.py
Library                     ../resources/validations.py
Resource                    ../resources/common.robot
Resource                    ../config/config.robot


*** Keywords ***
get pet by id request is sent
    ${pet_id} =     get context value    pet_id
    ${url} =    set variable    ${base_url}${get_pet_by_id_path}
    ${result} =     get pet by id    ${url}     ${pet_id}
    set context value    get_pet_result       ${result}
    IF    '${result.status_code}' == '200'
        ${response_body} =      evaluate     $result.json()
        set context value    get_pet_id         ${response_body}[id]
        set context value    get_pet_name       ${response_body}[name]
    END


get pet by id response is successful
    ${result} =     get context value    get_pet_result
    validate response status code   200     ${result.status_code}


get pet response should contain the correct
    [Arguments]     ${key}
    ${result} =             get context value       get_pet_result
    ${response_body} =      evaluate     $result.json()
    ${expected_value} =    get context value       pet_${key}
    validate response body    ${response_body}      ${key}      ${expected_value}


get pet response should be error
    ${result} =             get context value       get_pet_result
    validate response status code    404        ${result.status_code}


get pet response should match schema
    ${result} =     get context value   get_pet_result
    ${response_body} =      evaluate    $result.json()
    ${schema} =     Load JSON From File     ${pet_schema_filepath}
    validate json schema    ${response_body}    ${schema}
