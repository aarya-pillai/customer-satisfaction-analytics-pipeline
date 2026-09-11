{{ config(materialized='view') }}

SELECT
        a.order_id,
        a.seller_id,
        a.seller_state,
        b.review_score,
        b.satisfaction_level

FROM {{ ref('int_order_seller_info') }} a
JOIN {{ ref('int_order_satisfaction') }} b
USING (order_id)