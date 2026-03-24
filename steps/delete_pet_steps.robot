*** Settings ***
Library                         ../resources/delete_pet.py
Library                         ../resources/validations.py
Resource                        ../resources/common.robot
Resource                        ../steps/add_pet_steps.robot
Resource                        ../config/config.robot

*** Keywords ***
delete pet request is submitted
    ${pet_id} =     get context value    pet_id
    ${result} =     delete pet by id    ${base_url}     ${delete_pet_by_id_path}    ${pet_id}   ${api_key}
    set context value    delete_pet_result      ${result}


delete pet response is successful
    ${result} =     get context value    delete_pet_result
    validate response status code    200    ${result.status_code}


delete pet response should contain
    [Arguments]     ${key}
    ${result} =     get context value    delete_pet_result
    ${expected_value} =     get context value    pet_${key}
    ${expected_value} =     convert to string    ${expected_value}
    ${response_body} =      evaluate    $result.json()
    validate response body    ${response_body}      message     ${expected_value}


delete pet response should be error
    ${result} =     get context value    delete_pet_result
    validate response status code    404    ${result.status_code}


a deleted pet record
    an existing pet record
    delete pet request is submitted
    delete pet response is successful
