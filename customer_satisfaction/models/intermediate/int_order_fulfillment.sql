{{ config(materialized='view') }}

SELECT
    order_id,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date,

    TIMESTAMP_DIFF(
        order_delivered_customer_date,
        order_purchase_timestamp,
        DAY
    ) AS delivery_days,

    TIMESTAMP_DIFF(
        order_delivered_customer_date,
        order_estimated_delivery_date,
        DAY
    ) AS delivery_delay_days,

    CASE
        WHEN order_delivered_customer_date IS NULL THEN NULL
        WHEN order_delivered_customer_date > order_estimated_delivery_date
        THEN 'Yes'
        ELSE 'No'
    END AS is_late_delivery,

    TIMESTAMP_DIFF(
        order_approved_at,
        order_purchase_timestamp,
        HOUR
    ) AS approval_time,

    TIMESTAMP_DIFF(
        order_delivered_carrier_date,
        order_approved_at,
        HOUR
    ) AS approval_to_carrier_time,

    TIMESTAMP_DIFF(
        order_delivered_customer_date,
        order_delivered_carrier_date,
        HOUR
    ) AS carrier_to_customer_time

FROM {{ ref('stg_orders') }}