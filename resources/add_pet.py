import requests
import random
from faker import Faker


def submit_add_pet_request(url):
    pet_id = random.randint(1, 1000)
    fake = Faker()
    pet_name = fake.first_name()

    headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
    }
    body = {
            "id": pet_id,
            "category": {
                "id": 0,
                "name": "dog"
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
