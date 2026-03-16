-- Table d'aggrégation des campagnes

WITH 
revenue_by_campaign AS (
    SELECT
        c.campaign_id,
        c.campaign_name,
        COUNT(o.order_id) as total_orders,
        COUNT(customer_id) as total_customers,
        SUM(quantity * unit_price) as revenue,
        SUM(daily_budget) as expenses
    FROM `digital-marketing-campaigns.marketing.campaigns` AS c
    JOIN `digital-marketing-campaigns.marketing.orders` AS o ON c.campaign_id = o.campaign_id
    JOIN `digital-marketing-campaigns.marketing.order_items` AS oi ON o.order_id = oi.order_id
    GROUP BY c.campaign_id, c.campaign_name
),

trafic AS(
    SELECT
        c.campaign_id,
        c.campaign_name,
        SUM(converted) as conversion,
        SUM(pages_viewed) as pages_viewed
    FROM `digital-marketing-campaigns.marketing.website_sessions` AS ws
    JOIN `digital-marketing-campaigns.marketing.campaigns` AS c ON ws.campaign_id = c.campaign_id
    GROUP BY campaign_id, campaign_name
)

SELECT
    rev.campaign_id,
    rev.campaign_name,
    SUM(SAFE_DIVIDE(conversion, pages_viewed)*100) as conversion_pct,
    SUM(SAFE_DIVIDE((revenue - expenses), expenses) * 100) as ROI,
    SUM(SAFE_DIVIDE(revenue, total_orders)) as avg_basket,
    SUM(SAFE_DIVIDE(expenses, conversion)) as CAC
FROM revenue_by_campaign as rev
JOIN trafic as t ON rev.campaign_id = t.campaign_id
GROUP BY campaign_id, campaign_name