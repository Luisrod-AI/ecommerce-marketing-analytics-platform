SELECT *
FROM {{ ref('wh_agg_marketing_efficiency_scorecard') }}
WHERE
    (spend_share IS NOT NULL AND (spend_share < 0 OR spend_share > 1))
    OR
    (revenue_share IS NOT NULL AND (revenue_share < 0 OR revenue_share > 1))