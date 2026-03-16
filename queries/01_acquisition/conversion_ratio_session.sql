-- Taux de conversion session -> achat

SELECT 
    COUNT(session_id) AS total_sessions,
    SUM(converted) AS converted_sessions,
    SUM(converted)/COUNT(session_id)*100 AS conversion_rate
FROM `digital-marketing-campaigns.marketing.website_sessions`;