{{ config(materialized='table') }}

WITH date_spine AS (

    SELECT
        d::date AS date_day

    FROM generate_series(
        '2024-01-01'::date,
        '2026-12-31'::date,
        interval '1 day'
    ) AS d

)

SELECT
    date_day AS date_id,

    -- clés utiles
    TO_CHAR(date_day, 'YYYYMMDD') AS date_key,

    -- composantes date
    EXTRACT(YEAR FROM date_day) AS year,
    EXTRACT(MONTH FROM date_day) AS month,
    TO_CHAR(date_day, 'Month') AS month_name,

    EXTRACT(DAY FROM date_day) AS day,
    TO_CHAR(date_day, 'Day') AS day_name,

    EXTRACT(DOW FROM date_day) AS day_of_week,
    EXTRACT(ISODOW FROM date_day) AS iso_day_of_week,

    EXTRACT(WEEK FROM date_day) AS week_number,
    EXTRACT(ISOYEAR FROM date_day) AS iso_year,

    -- formats utiles
    TO_CHAR(date_day, 'YYYY-MM') AS year_month,
    TO_CHAR(date_day, 'IYYY-"W"IW') AS iso_year_week,

    -- flags business
    CASE 
        WHEN EXTRACT(ISODOW FROM date_day) IN (6,7) THEN TRUE
        ELSE FALSE
    END AS is_weekend,

    CASE 
        WHEN EXTRACT(MONTH FROM date_day) IN (12,1,2) THEN 'Winter'
        WHEN EXTRACT(MONTH FROM date_day) IN (3,4,5) THEN 'Spring'
        WHEN EXTRACT(MONTH FROM date_day) IN (6,7,8) THEN 'Summer'
        ELSE 'Autumn'
    END AS season

FROM date_spine