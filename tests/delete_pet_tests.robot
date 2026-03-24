*** Settings ***
Resource                        ../resources/common.robot
Resource                        ../steps/add_pet_steps.robot
Resource                        ../steps/delete_pet_steps.robot

Test Setup                      create test context

#robot -d results tests/delete_pet_tests.robot

*** Test Cases ***
Delete record of an existing pet
    [Tags]      delete_pet
    Given an existing pet record
    When delete pet request is submitted
    Then delete pet response is successful
    And delete pet response should contain      id


Delete record of a non existing pet
    [Tags]      delete_pet      error_test
    Given a non-existing pet
    When delete pet request is submitted
    Then delete pet response should be error
