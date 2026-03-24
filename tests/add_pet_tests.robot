*** Settings ***
Resource                        ../steps/add_pet_steps.robot
Resource                        ../resources/common.robot

Test Setup                      create test context


#robot -d result tests/add_pet_tests.robot
*** Test Cases ***
Add new record of pet
    [Tags]          add_pet
    [Template]      Add new pet
    oreo        labrador
    max         bulldog
    bella       beagle


*** Keywords ***
Add new pet
    [Arguments]     ${pet_name}     ${pet_category}
    Given an unregistered pet with name and category of      ${pet_name}    ${pet_category}
    When add pet request is sent
    Then add pet response should be successful
    And add pet response should contain
    ...     name::${pet_name}
    ...     category::name::${pet_category}