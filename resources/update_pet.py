import requests


def update_pet_record(base_url, update_pet_path, pet_id, pet_name):
    url = base_url + update_pet_path
    headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
    }
    body = {
        "id": pet_id,
        "category": {
            "id": 0,
            "name": "string"
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
    results = requests.put(
        url=url,
        headers=headers,
        json=body
    )
    return results
