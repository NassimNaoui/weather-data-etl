{{ config(materialized='view') }}

WITH raw_data AS (
    SELECT metadata
    FROM {{source('airbyte_raw', 'info_climat')}}
)

SELECT 
    kv.key AS metric_name,
    kv.value AS metric_description
FROM raw_data,
     jsonb_each_text(metadata) AS kv