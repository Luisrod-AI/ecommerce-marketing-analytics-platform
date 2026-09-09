{{ config(
    materialized='table',
    alias='agg_marketing_efficiency_scorecard'
) }}

WITH channel_performance AS (

    SELECT
        activity_date,
        platform,
        channel_category,
        marketing_type,

        -- Volume metrics
        SUM(impressions) AS impressions,
        SUM(clicks) AS clicks,
        SUM(conversions) AS conversions,
        SUM(total_interactions) AS total_interactions,

        -- Financial metrics
        SUM(spend_amount) AS spend,
        SUM(revenue) AS revenue,
        SUM(revenue) - SUM(spend_amount) AS net_marketing_revenue,

        -- Efficiency metrics
        SAFE_DIVIDE(
            SUM(revenue),
            NULLIF(SUM(spend_amount), 0)
        ) AS roas,

        SAFE_DIVIDE(
            SUM(spend_amount),
            NULLIF(SUM(conversions), 0)
        ) AS cost_per_acquisition,

        SAFE_DIVIDE(
            SUM(spend_amount),
            NULLIF(SUM(clicks), 0)
        ) AS cost_per_click,

        SAFE_DIVIDE(
            SUM(clicks),
            NULLIF(SUM(impressions), 0)
        ) AS click_through_rate,

        SAFE_DIVIDE(
            SUM(conversions),
            NULLIF(SUM(clicks), 0)
        ) AS click_to_conversion_rate,

        SAFE_DIVIDE(
            SUM(revenue) - SUM(spend_amount),
            NULLIF(SUM(revenue), 0)
        ) AS marketing_margin_pct

    FROM {{ ref('wh_fact_marketing_performance') }}

    GROUP BY
        activity_date,
        platform,
        channel_category,
        marketing_type
),

daily_totals AS (

    SELECT
        activity_date,
        SUM(spend) AS total_daily_spend,
        SUM(revenue) AS total_daily_revenue
    FROM channel_performance
    GROUP BY activity_date

),

scorecard AS (

    SELECT
        cp.*,

        -- Channel contribution
        SAFE_DIVIDE(
            cp.spend,
            NULLIF(dt.total_daily_spend, 0)
        ) AS spend_share,

        SAFE_DIVIDE(
            cp.revenue,
            NULLIF(dt.total_daily_revenue, 0)
        ) AS revenue_share,

        -- Measures whether a channel generates a larger
        -- share of revenue than its share of spend
        SAFE_DIVIDE(
            SAFE_DIVIDE(cp.revenue, NULLIF(dt.total_daily_revenue, 0)),
            NULLIF(
                SAFE_DIVIDE(cp.spend, NULLIF(dt.total_daily_spend, 0)),
                0
            )
        ) AS efficiency_index

    FROM channel_performance cp

    LEFT JOIN daily_totals dt
        ON cp.activity_date = dt.activity_date

),

final AS (

    SELECT
        *,

        CASE
            WHEN spend = 0 AND revenue > 0
                THEN 'Organic / Earned'

            WHEN efficiency_index >= 1.25
                THEN 'Highly Efficient'

            WHEN efficiency_index >= 1.00
                THEN 'Efficient'

            WHEN efficiency_index >= 0.75
                THEN 'Needs Attention'

            WHEN efficiency_index IS NOT NULL
                THEN 'Inefficient'

            ELSE 'Not Applicable'
        END AS efficiency_status,

        CURRENT_TIMESTAMP() AS created_at

    FROM scorecard

)

SELECT *
FROM final
ORDER BY activity_date DESC, revenue DESC