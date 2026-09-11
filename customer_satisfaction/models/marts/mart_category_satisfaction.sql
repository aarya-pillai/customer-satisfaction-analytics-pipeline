{{ config(materialized='view') }}

SELECT 
        a.order_id,
        a.product_category_name_english,
        b.review_score,
        b.satisfaction_level,
        c.delivery_days,
        c.delivery_delay_days,
        c.is_late_delivery

FROM {{ ref('int_order_category') }} a
JOIN {{ ref('int_order_satisfaction') }} b
USING (order_id)
JOIN {{ ref('int_order_fulfillment') }} c
USING (order_id)