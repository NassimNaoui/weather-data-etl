{{ config(materialized='view') }}

{{ dbt_utils.union_relations(
    relations=[
        ref('int_data_weather_u'),
        ref('int_data_info_climat')
    ]
) }}