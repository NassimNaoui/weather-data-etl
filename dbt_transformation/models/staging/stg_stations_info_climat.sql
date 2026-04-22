{{ config(materialized='view') }}

WITH raw_data AS (
    SELECT stations 
    FROM {{ source('airbyte_raw', 'info_climat') }}
)

SELECT 
    element->>'id' as station_id, 
    element->>'name' as station_name,
    (element->>'latitude')::float as latitude,
    (element->>'longitude')::float as longitude,
    (element->>'elevation')::int as elevation, 
    element->>'type' as station_type
FROM raw_data,
LATERAL jsonb_array_elements(stations) AS element