-- Conversion après nombre de sessions supérieures à la moyenne

WITH temp AS (
    SELECT
        customer_id,
        COUNT(session_id) AS sessions
    FROM `digital-marketing-campaigns.marketing.website_sessions`
    GROUP BY customer_id
)

SELECT
    customer_id,
    sessions
FROM temp
WHERE sessions > (SELECT AVG(sessions) FROM temp)
ORDER BY sessions DESC;
