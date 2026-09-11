{{ config(materialized='view') }}

SELECT
    a.order_id,
    d.customer_id,
    e.customer_unique_id,
    DATE(d.order_purchase_timestamp) AS order_purchase_date,
    a.review_score,
    b.delivery_days,
    b.delivery_delay_days,
    b.is_late_delivery,
    b.approval_time,
    b.approval_to_carrier_time,
    b.carrier_to_customer_time,
    c.total_product_value,
    c.total_freight_value,
    c.freight_to_price_ratio,
    c.item_count

FROM {{ ref('int_order_satisfaction') }} a
JOIN {{ ref('int_order_fulfillment') }} b 
USING (order_id)
JOIN {{ ref('int_order_financials') }} c 
USING (order_id)
JOIN {{ ref('stg_orders') }} d 
USING (order_id)
JOIN {{ ref('stg_customers') }} e 
USING (customer_id)