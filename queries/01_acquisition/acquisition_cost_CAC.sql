-- Cout d'acquisition client (CAC)

SELECT
    campaign_name,
    SUM(daily_budget)/SUM(converted) AS CAC
FROM `digital-marketing-campaigns.marketing.campaigns` AS c
JOIN `digital-marketing-campaigns.marketing.website_sessions` AS ws ON ws.campaign_id = c.campaign_id
GROUP BY campaign_name
ORDER BY CAC DESC;