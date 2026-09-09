SELECT
    activity_date,
    platform,
    channel_category,
    marketing_type,
    COUNT(*) AS row_count
FROM {{ ref('wh_agg_marketing_efficiency_scorecard') }}
GROUP BY
    activity_date,
    platform,
    channel_category,
    marketing_type
HAVING COUNT(*) > 1