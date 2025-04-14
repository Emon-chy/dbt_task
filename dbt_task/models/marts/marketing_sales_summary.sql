{{ config(materialized='table') }}

WITH sales_data AS (
    SELECT
        transaction_year,
        transaction_month,
        category,
        COUNT(DISTINCT user_id) AS unique_customers,
        SUM(revenue) AS total_revenue,
        SUM(cost) AS total_cost
    FROM {{ ref('int_sales_with_category') }}
    GROUP BY 1, 2, 3
    HAVING SUM(revenue) > 0
),
marketing_data AS (
    SELECT
        event_year,
        event_month,
        total_marketing_events,
        total_marketing_cost
    FROM {{ ref('int_marketing_cost_by_month') }}
)
SELECT
    s.*,
    COALESCE(m.total_marketing_cost, 0) AS total_marketing_cost,
    COALESCE(m.total_marketing_events, 0) AS total_marketing_events,
    CASE
        WHEN s.total_cost > 0 THEN (s.total_revenue / s.total_cost)
        ELSE 0
    END AS revenue_to_cost_ratio
FROM sales_data s
LEFT JOIN marketing_data m ON s.transaction_year = m.event_year 
AND s.transaction_month = m.event_month
ORDER BY transaction_year, transaction_month, category