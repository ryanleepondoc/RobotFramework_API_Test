*** Settings ***
Library                     Collections
Library                     String
Library                     ../resources/add_pet.py
Library                     ../resources/validations.py
Resource                    ../resources/common.robot
Resource                    ../config/config.robot


*** Keywords ***
an unregistered pet with name and category of
    [Arguments]    ${pet_name}      ${pet_category}
    set context value    pet_name           ${pet_name}
    set context value    pet_category       ${pet_category}


add pet request is sent
    ${url} =    set variable    ${base_url}${add_pet_path}
    ${pet_name} =       get context value    pet_name
    ${pet_category} =   get context value    pet_category
    ${result}   ${pet_id}   ${pet_name} =   submit add pet request  ${url}      ${pet_name}     ${pet_category}
    set context value    add_pet_result     ${result}
    IF    '${result.status_code}' == '200'
        set context value    pet_id     ${pet_id}
        set context value    pet_name   ${pet_name}
    END


add pet response should be successful
    ${result} =     get context value   add_pet_result
    validate response status code    200    ${result.status_code}


add pet response should contain correct
    [Arguments]     ${key}
    ${result} =     get context value   add_pet_result
    ${expected_value} =     get context value   pet_${key}
    ${response_body} =      evaluate    $result.json()
    validate response body    ${response_body}     ${key}     ${expected_value}


add pet response should contain
    [Arguments]    @{input_pattern}
    ${result} =     get context value   add_pet_result
    ${response_body} =      evaluate    $result.json()
    validate response contains sub map    ${response_body}     ${input_pattern}


an existing pet record
    get random pet details
    add pet request is sent


get random pet details
    ${pet_name}     ${pet_category} =   generate pet details
    set context value    pet_name           ${pet_name}
    set context value    pet_category       ${pet_category}


a non-existing pet
    ${pet_id} =     generate random integer
    set context value    pet_id     ${pet_id}
