-- Nombre de sessions par commandes

SELECT
    order_id,
    COUNT(session_id) as sessions_count
FROM `digital-marketing-campaigns.marketing.website_sessions`as ws
JOIN `digital-marketing-campaigns.marketing.orders` AS o ON ws.customer_id = o.customer_id
GROUP BY order_id
ORDER BY sessions_count DESC;