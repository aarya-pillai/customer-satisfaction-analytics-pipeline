{{ config(materialized='view') }}

WITH category_counts AS (

    SELECT
        a.order_id,
        COUNT(DISTINCT c.product_category_name_english) AS category_count

    FROM {{ ref('stg_order_items') }} a
    JOIN {{ ref('stg_products') }} b
    USING (product_id)
    JOIN {{ ref('stg_product_category_name_translation') }} c
    USING (product_category_name)

    GROUP BY a.order_id
),

single_category_orders AS (

    SELECT order_id
    FROM category_counts
    WHERE category_count = 1

)

SELECT DISTINCT
    a.order_id,
    c.product_category_name_english

FROM {{ ref('stg_order_items') }} a

JOIN {{ ref('stg_products') }} b
USING (product_id)

JOIN {{ ref('stg_product_category_name_translation') }} c
USING (product_category_name)

JOIN single_category_orders d
USING (order_id)