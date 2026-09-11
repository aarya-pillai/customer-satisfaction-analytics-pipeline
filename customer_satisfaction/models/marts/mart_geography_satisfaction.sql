{{ config(materialized='view') }}

SELECT
    a.order_id,
    a.customer_state,
    a.seller_state,
    a.is_interstate,
    b.delivery_days,
    b.delivery_delay_days,
    b.is_late_delivery,
    c.review_score,
    c.satisfaction_level

FROM {{ ref('int_order_geo') }} a
JOIN {{ ref('int_order_fulfillment') }} b
USING (order_id)
JOIN {{ ref('int_order_satisfaction') }} c
USING (order_id)