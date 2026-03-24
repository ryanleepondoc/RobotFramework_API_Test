from assertpy import assert_that


def validate_response_status_code(expected_status_code, actual_status_code):
    assert_that(int(actual_status_code)).is_equal_to(int(expected_status_code))


def validate_response_body(actual_response_body, key, expected_value):
    assert_that(actual_response_body[key]).is_equal_to(expected_value)

