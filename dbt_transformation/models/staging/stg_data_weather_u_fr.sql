{{ config(materialized='view')}}

WITH raw_data AS (
    SELECT *
    FROM {{source("airbyte_raw", "weather_underground_fr")}}
)

select 
	   'FR' as country,
       raw_data."Time" as time, 
	   TO_DATE(date, 'YYYYMMDD') as date,
       REPLACE(raw_data."Temperature", ' °F','')::float as temperature,
	   REPLACE(raw_data."Dew Point", ' °F','')::float as dew_point,
	   REPLACE(raw_data."Humidity", ' %','')::float /100 as humidity,
	   raw_data."Wind" as wind,
	   REPLACE(raw_data."Speed", ' mph','')::float as speed,
	   REPLACE(raw_data."Gust", ' mph','')::float as gust,
	   REPLACE(raw_data."Pressure", ' in','')::float as pressure,
	   REPLACE(raw_data."Precip. Rate.", ' in','')::float as precip_rate,
	   REPLACE(raw_data."Precip. Accum.", ' in','')::float as precip_accum,
	   raw_data."UV" as uv,
	   REPLACE(raw_data."Solar", ' w/m²','')::float as solar
from raw_data