import requests


def delete_pet_by_id(base_url, delete_pet_path, pet_id, api_key):
    url = base_url + delete_pet_path
    headers = {
        'Accept': 'application/json',
        'api_key': api_key
    }
    response = requests.delete(
        url=url.format(pet_id=pet_id),
        headers=headers
    )
    return response
