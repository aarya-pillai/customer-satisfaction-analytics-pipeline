{{ config(materialized='view') }}

SELECT
    a.order_id,
    c.customer_state,
    b.seller_state,
    CASE
        WHEN c.customer_state = b.seller_state THEN 'No'
        ELSE 'Yes'
    END AS is_interstate

FROM {{ ref('stg_orders') }} a

JOIN {{ ref('int_order_seller_info') }} b
USING (order_id)

JOIN {{ ref('stg_customers') }} c
USING (customer_id)