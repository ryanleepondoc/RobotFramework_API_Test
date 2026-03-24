from assertpy import assert_that


def validate_response_status_code(expected_status_code, actual_status_code):
    assert_that(int(actual_status_code)).is_equal_to(int(expected_status_code))


def validate_response_body(actual_response_body, key, expected_value):
    assert_that(actual_response_body[key]).is_equal_to(expected_value)


def validate_response_contains_sub_map(actual_response, sub_map_pattern):
    expected_json = convert_to_json(sub_map_pattern)
    assert is_subset(expected_json, actual_response), "Pattern not found in JSON"


def set_nested(d, keys, value):
    """Recursively build nested dictionary"""
    for key in keys[:-1]:
        d = d.setdefault(key, {})
    d[keys[-1]] = value


def parse_value(value):
    value = value.strip()

    # Integer
    if value.isdigit():
        return int(value)

    # Float
    try:
        return float(value)
    except ValueError:
        pass

    # Boolean
    if value.lower() in ["true", "false"]:
        return value.lower() == "true"

    # Default: string
    return value


def convert_to_json(input_pattern):
    result = {}

    parts = [x.strip() for x in input_pattern.split("::")]

    if len(parts) < 2:
        raise ValueError(f"Invalid format: {input_pattern}")

    *keys, value = parts
    value = parse_value(value)
    set_nested(result, keys, value)

    return result


def is_subset(expected, actual):
    if isinstance(expected, dict):
        for key, value in expected.items():
            if key not in actual:
                return False
            if not is_subset(value, actual[key]):
                return False
        return True
    else:
        return expected == actual
