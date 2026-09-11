{{ config(materialized='view') }}

SELECT
    a.product_id,
    a.product_category_name,
    b.product_category_name_english,
    a.product_weight_g,
    a.product_length_cm,
    a.product_height_cm,
    a.product_width_cm
FROM {{ ref('stg_products') }} a
LEFT JOIN {{ ref('stg_product_category_name_translation') }} b
USING (product_category_name)