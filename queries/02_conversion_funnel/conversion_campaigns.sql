-- Taux de conversion par campagne

SELECT
    c.campaign_id,
    c.campaign_name,
    SUM(converted) / COUNT(session_id) * 100 as conversion_pct
FROM `digital-marketing-campaigns.marketing.campaigns` as c
JOIN `digital-marketing-campaigns.marketing.website_sessions` as ws ON ws.campaign_id = c.campaign_id
GROUP BY campaign_id, campaign_name
ORDER BY conversion_pct DESC;