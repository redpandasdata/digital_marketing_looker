-- Répartition du trafic par canal

SELECT 
    channel_name,
    SUM(pages_viewed) AS total_pages_viewed
FROM `digital-marketing-campaigns.marketing.marketing_channels` AS mc
JOIN `digital-marketing-campaigns.marketing.campaigns` AS c ON mc.channel_id = c.channel_id
JOIN `digital-marketing-campaigns.marketing.website_sessions` AS ws ON ws.campaign_id = c.campaign_id
GROUP BY channel_name
ORDER BY total_pages_viewed DESC;

