{{ config(materialized='view') }}

SELECT
    transaction_id,
    {{ extract_year_month('transaction_timestamp') }},
    user_id,
    product_id,
    revenue,
    cost,
    transaction_timestamp
FROM {{ source('raw', 'sales_transactions') }}