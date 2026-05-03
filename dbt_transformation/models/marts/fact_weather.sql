{{ config(materialized='table',
           post_hook=[
        "CREATE INDEX IF NOT EXISTS idx_fact_weather_station_id
         ON {{ this }} (station_id)",

        "CREATE INDEX IF NOT EXISTS idx_fact_weather_date
         ON {{ this }} (date)"
    ]) }}

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