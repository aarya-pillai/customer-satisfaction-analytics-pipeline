{{ config(materialized='view') }}

SELECT
        a.order_id,
        b.review_score,
        b.satisfaction_level,
        a.delivery_days,
        a.delivery_delay_days,
        a.is_late_delivery,
        a.approval_time,
        a.approval_to_carrier_time,
        a.carrier_to_customer_time
FROM {{ref('int_order_fulfillment')}} a
JOIN {{ref('int_order_satisfaction')}} b
USING (order_id)