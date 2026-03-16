-- Table pour Looker Studio : Dashboard performance de campagnes

CREATE OR REPLACE VIEW `digital-marketing-campaigns.marketing.view_daily_campaigns_perf` AS

WITH sessions AS (
    SELECT
        ws.session_date AS date,
        ws.campaign_id,
        COUNT(ws.session_id) AS sessions,
        SUM(ws.converted) AS conversions,
        SUM(ws.pages_viewed) AS pages_viewed
    FROM `digital-marketing-campaigns.marketing.website_sessions` AS ws
    GROUP BY date, campaign_id
),

orders AS (
    SELECT
        o.order_date AS date,
        o.campaign_id,
        COUNT(DISTINCT o.order_id) AS orders,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM `digital-marketing-campaigns.marketing.orders` AS o
    JOIN `digital-marketing-campaigns.marketing.order_items` AS oi
        ON o.order_id = oi.order_id
    GROUP BY date, campaign_id
)

SELECT
    s.date,
    c.campaign_id,
    c.campaign_name,
    mc.channel_name,
    s.sessions,
    s.conversions,
    s.pages_viewed,
    IFNULL(o.orders, 0) AS orders,
    IFNULL(o.revenue, 0) AS revenue,
    c.daily_budget AS cost
FROM sessions AS s
LEFT JOIN orders AS o
    ON s.campaign_id = o.campaign_id
    AND s.date = o.date
JOIN `digital-marketing-campaigns.marketing.campaigns` AS c
    ON s.campaign_id = c.campaign_id
JOIN `digital-marketing-campaigns.marketing.marketing_channels` AS mc
    ON c.channel_id = mc.channel_id
ORDER BY s.date, campaign_id;