{{ config(materialized='view') }}

SELECT
    a.order_id,
    a.total_product_value,
    a.total_freight_value,
    a.freight_to_price_ratio,
    a.item_count,
    b.review_score,
    b.satisfaction_level

FROM {{ ref('int_order_financials') }} a
JOIN {{ ref('int_order_satisfaction') }} b
USING (order_id)