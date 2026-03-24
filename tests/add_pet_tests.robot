*** Settings ***
Resource                        ../steps/add_pet_steps.robot
Resource                        ../resources/common.robot

Test Setup                      create test context


#robot -d result tests/add_pet_tests.robot
*** Test Cases ***
Add new record of pet
    [Tags]      add_pet
    When add pet request is sent
    Then add pet response should be successful
    And add pet response should contain correct     id
    And add pet response should contain correct     name
