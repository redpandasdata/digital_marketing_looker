-- Analyser la rétention et la valeur client dans le temps.
-- Chauqe ligne représente un client dans une cohorte d'inscription

CREATE OR REPLACE VIEW `digital-marketing-campaigns.marketing.view_customer_cohorts` AS

WITH customers_table AS(
    SELECT
        customer_id,
        signup_date,
        EXTRACT(MONTH FROM signup_date) as signup_month,
        EXTRACT(YEAR FROM signup_date) as signup_year,
        country,
        device_preference
    FROM `digital-marketing-campaigns.marketing.customers`
),

sessions_table AS(
    SELECT
        customer_id,
        COUNT(session_id) as total_sessions,
        SUM(pages_viewed) as total_pages_viewed,
        MIN(session_date) as first_session_date
    FROM `digital-marketing-campaigns.marketing.website_sessions`
    GROUP BY customer_id
),

orders_table AS(
    SELECT
        customer_id,
        COUNT(order_id) as total_orders,
        MIN(order_date) as first_order_date
    FROM `digital-marketing-campaigns.marketing.orders`
    GROUP BY customer_id
),

revenue_table AS(
    SELECT
        customer_id,
        SUM(quantity * unit_price) as revenue
    FROM `digital-marketing-campaigns.marketing.orders` o
    JOIN `digital-marketing-campaigns.marketing.order_items` oi ON o.order_id = oi.order_id
    GROUP BY customer_id
)

SELECT
    c.customer_id,
    signup_date,
    signup_month,
    signup_year,
    country,
    device_preference,
    COALESCE(total_sessions,0) as total_sessions,
    COALESCE(total_pages_viewed, 0) as total_pages_viewed,
    first_session_date,
    COALESCE(total_orders, 0) as total_orders,
    first_order_date,
    COALESCE(revenue, 0) as revenue,
    DATE_DIFF(first_order_date, signup_date, DAY) as days_first_purchase,
    DATE_DIFF(CURRENT_DATE(), signup_date, MONTH) as months_since_signup
FROM customers_table c
LEFT JOIN sessions_table ON c.customer_id = sessions_table.customer_id
LEFT JOIN orders_table ON c.customer_id = orders_table.customer_id
LEFT JOIN revenue_table ON c.customer_id = revenue_table.customer_id
ORDER BY signup_date
;
    
