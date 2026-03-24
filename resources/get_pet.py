import requests


def get_pet_by_id(url, pet_id):
    headers = {
        'Accept': 'application/json',
    }

    response = requests.get(
        url=url.format(pet_id=pet_id),
        headers=headers
    )
    return response
