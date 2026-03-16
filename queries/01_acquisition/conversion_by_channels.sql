-- Nombre de conversions par canal

SELECT
    SUM(converted) as conversion,
    channel_name
FROM `digital-marketing-campaigns.marketing.website_sessions` AS ws
JOIN `digital-marketing-campaigns.marketing.campaigns` AS c ON ws.campaign_id = c.campaign_id
JOIN `digital-marketing-campaigns.marketing.marketing_channels` AS mc ON c.channel_id = mc.channel_id
GROUP BY channel_name
ORDER BY conversion DESC;