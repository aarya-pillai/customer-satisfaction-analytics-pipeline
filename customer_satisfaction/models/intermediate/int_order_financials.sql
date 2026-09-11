{{ config(materialized='view') }}

SELECT
    order_id,
    ROUND(SUM(price),2) AS total_product_value,
    ROUND(SUM(freight_value),2) AS total_freight_value,
    ROUND(SAFE_DIVIDE(
        SUM(freight_value),
        SUM(price)
    ),3) AS freight_to_price_ratio,
    COUNT(*) AS item_count

FROM {{ ref('stg_order_items') }}
GROUP BY order_id