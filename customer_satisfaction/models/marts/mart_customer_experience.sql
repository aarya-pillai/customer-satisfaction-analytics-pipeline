{{ config(materialized='view') }}

SELECT
    a.order_id,
    a.review_score,
    a.satisfaction_level,
    b.delivery_days,
    b.delivery_delay_days,
    b.is_late_delivery,
    b.approval_time,
    b.approval_to_carrier_time,
    b.carrier_to_customer_time,
    c.total_product_value,
    c.total_freight_value,
    c.freight_to_price_ratio,
    c.item_count,
    d.seller_id,
    d.seller_state,
    e.customer_state,
    e.is_interstate,
    f.product_category_name_english

FROM {{ ref('int_order_satisfaction') }} a
JOIN {{ ref('int_order_fulfillment') }} b
USING (order_id)
JOIN {{ ref('int_order_financials') }} c
USING (order_id)
LEFT JOIN {{ ref('int_order_seller_info') }} d
USING (order_id)
LEFT JOIN {{ ref('int_order_geo') }} e
USING (order_id)
LEFT JOIN {{ ref('int_order_category') }} f
USING (order_id)