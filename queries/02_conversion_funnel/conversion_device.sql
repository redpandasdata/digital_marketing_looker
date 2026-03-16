-- Taux de conversion par appareil préféré

SELECT
    device_preference,
    COUNT(session_id) as total_sessions,
    SUM(converted) as conversion,
    SUM(converted)/COUNT(session_id)*100 as conversion_pct
FROM `digital-marketing-campaigns.marketing.website_sessions` as ws
JOIN `digital-marketing-campaigns.marketing.customers`as c ON ws.customer_id = c.customer_id
GROUP BY device_preference
ORDER BY conversion_rate DESC;