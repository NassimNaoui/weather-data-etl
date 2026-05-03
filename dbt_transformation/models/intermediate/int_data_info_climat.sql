{{ config(materialized='view') }}


SELECT station_id,
       date_heure::date as date, 
       TO_CHAR(date_heure, 'HH24:MI:SS') as time,
       temperature, 
       pression as pressure, 
       humidite as humidity, 
       point_de_rosee as dew_point, 
       visibilite as visibility,
       vent_moyen as mean_wind, 
       vent_rafales as gust, 
       CASE
        WHEN vent_direction < 22.5 THEN 'N'
        WHEN vent_direction < 45 THEN 'NNE'
        WHEN vent_direction < 67.5  THEN 'NE'
        WHEN vent_direction < 90  THEN 'ENE'
        WHEN vent_direction < 112.5  THEN 'E'
        WHEN vent_direction < 135  THEN 'ESE'
        WHEN vent_direction < 157.5  THEN 'SE'
        WHEN vent_direction < 180  THEN 'SEE'
        WHEN vent_direction < 202.5  THEN 'S'
        WHEN vent_direction < 225  THEN 'SSW'
        WHEN vent_direction < 247.5  THEN 'SW'
        WHEN vent_direction < 270  THEN 'WSW'
        WHEN vent_direction < 292.5  THEN 'W'
        WHEN vent_direction < 315  THEN 'WNW'
        WHEN vent_direction < 337.5  THEN 'NW'
        WHEN vent_direction < 360  THEN 'NNW'
    END AS wind_direction,
    pluie_3h as rain_over_3h, 
    pluie_1h as rain_over_1h, 
    nebulosite as haze, 
    temps_omm as present_weather

FROM {{ ref('stg_data_info_climat') }}
WHERE station_id != '_params'