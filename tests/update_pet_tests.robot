*** Settings ***
Resource                ../resources/common.robot
Resource                ../steps/add_pet_steps.robot
Resource                ../steps/delete_pet_steps.robot
Resource                ../steps/update_pet_steps.robot

Test Setup              create test context

#robot -d results tests/update_pet_tests.robot
*** Test Cases ***
Update name of an existing pet
    [Tags]      update_pet
    Given an existing pet record
    When a request to update the name of a pet      new name
    Then update pet response is successful
    And update pet response should match schema
    And add pet response should contain
    ...     name::$pet_name
    ...     category::name::$pet_category
