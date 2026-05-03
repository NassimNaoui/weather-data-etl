{{ config(materialized='view') }}

SELECT *
FROM (
    VALUES 
        (
            'ILAMAD25',
            'La Madeleine',
            50.659,
            3.07,
            23,
            'France',
            'La Madeleine',
            'other',
            'EasyWeatherPro_V5.1.6'
        ),
        (
            'IICHTE19',
            'WeerstationBS',
            51.092,
            2.999,
            15,
            'Belgium',
            'Ichtegem',
            'other',
            'EasyWeatherV1.6.6'
        )
) AS t(
    station_id,
    station_name,
    latitude,
    longitude,
    elevation,
    country,
    city,
    hardware,
    software
)