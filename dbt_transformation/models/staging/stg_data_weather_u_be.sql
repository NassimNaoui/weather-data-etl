{{ config(materialized='view')}}

WITH raw_data AS (
    SELECT *
    FROM {{source("airbyte_raw", "weather_underground_be")}}
)

select 
       'BE' as country,
       time, 
	   REPLACE(temperature, ' °F','')::float as temperature,
	   REPLACE(dew_point, ' °F','')::float as dew_point,
	   REPLACE(humidity, ' %','')::float /100 as humidity,
	   wind,
	   REPLACE(speed, ' mph','')::float as speed,
	   REPLACE(gust, ' mph','')::float as gust,
	   REPLACE(pressure, ' in','')::float as pressure,
	   REPLACE(precip__rate_, ' in','')::float as precip_rate,
	   REPLACE(precip__accum_, ' in','')::float as precip_accum,
	   uv,
	   REPLACE(solar, ' w/m²','')::float as solar
from raw_data