{{ config(materialized='view') }}

SELECT
    event_id,
    {{ extract_year_month('event_timestamp') }},
    user_id,
    channel,
    campaign,
    cost,
    event_timestamp
FROM {{ source('raw', 'marketing_events') }}