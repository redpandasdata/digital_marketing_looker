-- ROI des campagnes marketing

SELECT
    campaign_name,
    ((quantity * unit_price) - daily_budget) / daily_budget * 100 as ROI
FROM `digital-marketing-campaigns.marketing.campaigns` AS c
JOIN `digital-marketing-campaigns.marketing.orders` AS o ON c.campaign_id = o.campaign_id
JOIN `digital-marketing-campaigns.marketing.order_items` AS oi ON o.order_id = oi.order_id
GROUP BY campaign_name, daily_budget, quantity, unit_price
ORDER BY ROI DESC;