{{ config(materialized='view') }}




WITH data_be AS (
    SELECT 
    'IICHTE19' AS station_id,
    date,
    time,
    temperature,
    dew_point, 
    humidity,
    wind as wind_direction,
    speed,
    gust, 
    pressure,
    precip_rate,
    precip_accum,
    uv,
    solar
    FROM {{ ref('stg_data_weather_u_be') }}
), data_fr AS (
    SELECT 
    'ILAMAD25' AS station_id,
    date,
    time,
    temperature,
    dew_point,
    humidity,
    wind as wind_direction,
    speed,
    gust,
    pressure,
    precip_rate,
    precip_accum,
    uv,
    solar
    FROM {{ ref('stg_data_weather_u_fr') }}
)


SELECT *
FROM data_be
UNION
SELECT *
FROM data_fr