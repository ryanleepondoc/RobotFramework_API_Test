*** Settings ***
Library                     Collections
Library                     String
Library                     ../resources/add_pet.py
Library                     ../resources/validations.py
Resource                    ../resources/common.robot
Resource                    ../config/config.robot


*** Keywords ***
add pet request is sent
    ${url} =    set variable    ${base_url}${add_pet_path}
    ${result}   ${pet_id}   ${pet_name} =   submit add pet request  ${url}
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


an existing pet record
    add pet request is sent

a non-existing pet
    ${pet_id} =     generate random integer
    set context value    pet_id     ${pet_id}
