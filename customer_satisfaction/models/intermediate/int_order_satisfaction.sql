{{ config(materialized='view') }}

WITH ranked_reviews AS (

    SELECT
        order_id,
        review_score,
        review_answer_timestamp,

        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY review_answer_timestamp DESC
        ) AS review_rank

    FROM {{ ref('stg_order_reviews') }}
)

SELECT
    order_id,
    review_score,
    review_answer_timestamp,
    CASE
        WHEN review_score IN (1, 2) THEN 'Low'
        WHEN review_score = 3 THEN 'Neutral'
        WHEN review_score IN (4, 5) THEN 'High'
    END AS satisfaction_level

FROM ranked_reviews
WHERE review_rank = 1