{{ config(materialized='view') }}

WITH raw_data AS (
    SELECT hourly
    FROM {{source('airbyte_raw', 'info_climat')}}
)

SELECT 
	kv.key as station_id, 
	(element->>'dh_utc')::timestamp as date_heure,
	(element->>'temperature')::float as temperature,
	(element->>'pression')::float as pression,
	(element->>'humidite')::int as humidite,
	(element->>'point_de_rosee')::float as point_de_rosee,
	(element->>'visibilite')::int as visibilite,
	(element->>'vent_moyen')::float as vent_moyen,
	(element->>'vent_rafales')::float as vent_rafales,
	(element->>'vent_direction')::float as vent_direction,
	NULLIF(element->>'pluie_3h', '')::float AS pluie_3h,
	NULLIF(element->>'pluie_1h', '')::float AS pluie_1h,
	NULLIF(element->>'nebulosite', '')::float AS nebulosite,
	NULLIF(element->>'temps_omm', '')::float AS temps_omm
FROM raw_data,
	LATERAL jsonb_each(hourly) as kv,
	LATERAL jsonb_array_elements(kv.value) as element