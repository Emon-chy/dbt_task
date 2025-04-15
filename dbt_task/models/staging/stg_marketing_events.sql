{{ config(materialized='view') }}

SELECT
    event_id,
    {{ extract_year_month('event_timestamp') }},
    user_id,
    event_type,
    event_timestamp,
    channel,
    campaign,
    cost,
FROM {{ source('raw', 'marketing_events') }}