-- Pages vues avant conversion ( en moyenne)

SELECT
    AVG(pages_viewed) as pages_viewed
FROM `digital-marketing-campaigns.marketing.website_sessions`
WHERE converted = 0;