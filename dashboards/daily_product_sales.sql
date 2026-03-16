-- Analyser la performance commerciale des produits dans le temps
-- Chaque ligne représente un produit x un jour

CREATE OR REPLACE VIEW `digital-marketing-campaigns.marketing.view_daily_product_sales` AS

SELECT
    order_date,
    p.product_id,
    category,
    COUNT(DISTINCT p.product_id) as nbr_product_ordered,
    SUM(quantity) as total_quantity_sold,
    SUM(unit_price * quantity) as revenue,
    COUNT(DISTINCT customer_id) as nbr_customers,
    COUNT(DISTINCT o.order_id) as nbr_orders
FROM `digital-marketing-campaigns.marketing.orders` as o
JOIN `digital-marketing-campaigns.marketing.order_items` as oi ON o.order_id = oi.order_id
JOIN `digital-marketing-campaigns.marketing.products` as p ON oi.product_id = p.product_id
GROUP BY order_date, p.product_id, category
ORDER BY order_date, p.product_id;