*** Settings ***
Resource                        ../resources/common.robot
Resource                        ../steps/add_pet_steps.robot
Resource                        ../steps/get_pet_steps.robot
Resource                        ../steps/delete_pet_steps.robot

Test Setup                      create test context

#robot -d results tests/get_pet_tests.robot
*** Test Cases ***
Get pet record by id
    [Tags]      get_pet
    Given an existing pet record
    When get pet by id request is sent
    Then get pet by id response is successful
    And get pet response should contain the correct     id
    And get pet response should contain the correct     name


Get record of a non-existing pet id
    [Tags]      get_pet     error_test
    Given a non-existing pet
    When get pet by id request is sent
    Then get pet response should be error


Get record of a delete pet record
    [Tags]      get_pet     error_test
    Given a deleted pet record
    When get pet by id request is sent
    Then get pet response should be error
