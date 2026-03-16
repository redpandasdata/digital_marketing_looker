-- Quelle catégorie de produit génère le plus de revenus ?

SELECT
    p.category,
    ROUND(SUM(oi.unit_price * oi.quantity),2) as revenue
FROM `digital-marketing-campaigns.marketing.products` AS p
JOIN `digital-marketing-campaigns.marketing.order_items` AS oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY revenue desc;