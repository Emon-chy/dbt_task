{{ config(materialized='table', dist = 'product_id') }}

SELECT
    s.transaction_id,
    s.transaction_timestamp_year AS transaction_year,
    s.transaction_timestamp_month AS transaction_month,
    s.user_id,
    s.product_id,
    s.revenue,
    s.cost,
    s.transaction_timestamp,
    p.category
FROM {{ ref('stg_sales_transactions') }} s
LEFT JOIN {{ ref('stg_product_catalog') }} p ON s.product_id = p.product_id