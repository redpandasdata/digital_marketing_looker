-- Nombre de sessions par utilisateurs uniques

SELECT
    customer_id,
    COUNT(DISTINCT session_id) AS sessions
FROM `digital-marketing-campaigns.marketing.website_sessions`
GROUP BY customer_id
ORDER BY sessions DESC;