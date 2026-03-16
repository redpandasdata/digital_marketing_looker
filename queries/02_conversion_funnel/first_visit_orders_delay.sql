-- Temps entre première visite et achat

WITH temp as (
    SELECT
        ws.customer_id,
        MIN(order_date) AS first_order_date,
        MIN(session_date) AS first_session_date,
        DATE_DIFF(MIN(order_date), MIN(session_date), DAY) as delay_order
    FROM `digital-marketing-campaigns.marketing.website_sessions` AS ws
    JOIN `digital-marketing-campaigns.marketing.orders` AS o ON ws.customer_id = o.customer_id
    GROUP BY customer_id
    ORDER BY delay_order DESC
)

SELECT
    *,
    AVG(delay_order) OVER() as avg_delay_order,
    (delay_order - AVG(delay_order) OVER()) as delay_order_diff
FROM temp