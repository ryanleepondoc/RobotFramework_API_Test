import requests
import random
from faker import Faker


def submit_add_pet_request(url, pet_name=None, pet_category=None):
    pet_id = random.randint(1, 1000)
    fake = Faker()
    if pet_name is None:
        pet_name = fake.first_name()
    if pet_category is None:
        pet_category = "Unknown"

    headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
    }
    body = {
            "id": pet_id,
            "category": {
                "id": 0,
                "name": pet_category
            },
            "name": pet_name,
            "photoUrls": [
                "string"
            ],
            "tags": [
                {
                    "id": 0,
                    "name": "string"
                }
            ],
            "status": "available"
    }
    result = requests.post(
        url=url,
        headers=headers,
        json=body
    )
    return result, pet_id, pet_name


def generate_random_integer():
    return random.randint(1, 1000)


def generate_pet_details():
    fake = Faker()
    pet_name = fake.first_name()
    pet_category = "Unknown"

    return pet_name, pet_category
