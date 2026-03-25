*** Variables ***
${base_url} =                   https://petstore.swagger.io
${api_key} =                    special-key
${add_pet_path} =               /v2/pet
${get_pet_by_id_path} =         /v2/pet/{pet_id}
${delete_pet_by_id_path} =      /v2/pet/{pet_id}
${update_pet_by_id_path} =      /v2/pet

${add_pet_schema_filepath} =        ${EXECDIR}/schema/add_pet.json
${get_pet_schema_filepath} =        ${EXECDIR}/schema/get_pet.json
${update_pet_schema_filepath} =     ${EXECDIR}/schema/update_pet.json
