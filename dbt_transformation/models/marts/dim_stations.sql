{{ config(materialized='table') }}

SELECT
    station_id,
    station_name,
    latitude,
    longitude,
    elevation,
    country,
    coalesce(city, station_name) as city,
    station_type,
    hardware,
    software
FROM {{ ref('int_union_stations') }}