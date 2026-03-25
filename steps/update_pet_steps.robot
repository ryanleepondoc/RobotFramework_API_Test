*** Settings ***
Library                     JSONLibrary
Library                     ../resources/update_pet.py
Library                     ../resources/validations.py
Resource                    ../resources/common.robot
Resource                    ../config/config.robot


*** Keywords ***
a request to update the name of a pet
    [Arguments]    ${pet_name}
    ${pet_id} =     get context value    pet_id
    ${result} =     update pet record    ${base_url}    ${update_pet_by_id_path}    ${pet_id}       ${pet_name}
    IF    '${result.status_code}' == '200'
        set context value    update_pet_result      ${result}
        set context value    pet_name               ${pet_name}
    END


update pet response is successful
    ${result} =     get context value    update_pet_result
    validate response status code    200    ${result.status_code}


update pet response should contain correct
    [Arguments]     ${key}
    ${result} =     get context value    update_pet_result
    ${expected_value} =     get context value    pet_${key}
    ${response_body} =      evaluate    $result.json()
    validate response body    ${response_body}     ${key}      ${expected_value}


update pet response should match schema
    ${result} =     get context value   update_pet_result
    ${response_body} =      evaluate    $result.json()
    ${schema} =     Load JSON From File     ${update_pet_schema_filepath}
    validate json schema    ${response_body}    ${schema}
