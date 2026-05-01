{{ config(materialized='view') }}

{{ dbt_utils.union_relations(
    relations=[
        ref('stg_stations_weather_u'),
        ref('stg_stations_info_climat')
    ]
) }}