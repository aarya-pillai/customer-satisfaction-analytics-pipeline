{{ config(materialized='view') }}

WITH seller_counts AS (

    SELECT
        order_id,
        COUNT(DISTINCT seller_id) AS seller_count

    FROM {{ ref('stg_order_items') }}

    GROUP BY order_id
),

single_seller_orders AS (

    SELECT order_id
    FROM seller_counts
    WHERE seller_count = 1

)

SELECT 
    DISTINCT a.order_id,
    a.seller_id,
    b.seller_state

FROM {{ ref('stg_order_items') }} a

JOIN single_seller_orders c
USING (order_id)

JOIN {{ ref('stg_sellers') }} b
USING (seller_id)