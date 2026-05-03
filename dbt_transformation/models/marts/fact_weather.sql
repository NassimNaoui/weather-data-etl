{{ config(materialized='table') }}

SELECT
    station_id,
    date,
    time,
    temperature,
    pressure,
    humidity,
    dew_point,
    gust,
    wind_direction,
    speed,
    precip_rate,
    precip_accum,
    uv,
    solar,
    visibility,
    mean_wind,
    rain_over_3h,
    rain_over_1h,
    haze,
    present_weather
FROM {{ ref('int_union_weather') }}