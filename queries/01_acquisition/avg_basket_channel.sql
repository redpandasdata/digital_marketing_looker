-- Panier moyen par canal

SELECT
    channel_name,
    SUM(quantity * unit_price) / COUNT(oi.order_id) as avg_basket
FROM `digital-marketing-campaigns.marketing.order_items` AS oi
JOIN `digital-marketing-campaigns.marketing.orders` AS o ON oi.order_id = o.order_id
JOIN `digital-marketing-campaigns.marketing.campaigns` AS c ON o.campaign_id = c.campaign_id
JOIN `digital-marketing-campaigns.marketing.marketing_channels` AS mc ON c.channel_id = mc.channel_id
GROUP BY channel_name
ORDER BY avg_basket DESC;