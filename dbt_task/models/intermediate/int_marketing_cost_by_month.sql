{{ config(materialized='view') }}

SELECT
    event_timestamp_year AS event_year,
    event_timestamp_month AS event_month,
    COUNT(event_id) AS total_marketing_events
    SUM(cost) AS total_marketing_cost
FROM {{ ref('stg_marketing_events') }}
GROUP BY 1, 2