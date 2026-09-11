{{ config(materialized='view') }}

SELECT DISTINCT
    DATE(order_purchase_timestamp) AS date,
    EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
    EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
    EXTRACT(QUARTER FROM order_purchase_timestamp) AS quarter
FROM {{ ref('stg_orders') }}
WHERE order_purchase_timestamp IS NOT NULL