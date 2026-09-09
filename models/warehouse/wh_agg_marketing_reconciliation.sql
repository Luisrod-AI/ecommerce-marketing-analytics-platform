{{ config(
    materialized='table',
    alias='agg_marketing_reconciliation'
) }}

WITH marketing_data AS (

    SELECT
        activity_date,

        CASE
            WHEN platform = 'google_ads' THEN 'Google Ads'
            WHEN platform IN ('facebook_ads', 'instagram') THEN 'Meta'
            WHEN platform = 'pinterest_ads' THEN 'Pinterest'
            WHEN platform = 'klaviyo' THEN 'Email'
            ELSE 'Other'
        END AS normalized_channel,

        SUM(spend_amount) AS platform_spend,
        SUM(revenue) AS platform_attributed_revenue,
        SUM(conversions) AS platform_attributed_conversions

    FROM {{ ref('wh_fact_marketing_performance') }}

    WHERE marketing_type IN (
        'paid_advertising',
        'email_marketing'
    )

    GROUP BY 1, 2
),

commerce_data AS (

    SELECT
        DATE(order_created_at) AS activity_date,

        CASE
            WHEN LOWER(channel_source_medium) LIKE '%google%'
                AND LOWER(channel_source_medium) LIKE '%cpc%'
                THEN 'Google Ads'

            WHEN LOWER(channel_source_medium) LIKE '%facebook%'
                OR LOWER(channel_source_medium) LIKE '%instagram%'
                THEN 'Meta'

            WHEN LOWER(channel_source_medium) LIKE '%pinterest%'
                THEN 'Pinterest'

            WHEN LOWER(channel_source_medium) LIKE '%email%'
                THEN 'Email'

            ELSE 'Other'
        END AS normalized_channel,

        COUNT(DISTINCT order_id) AS ecommerce_orders,

        SUM(net_order_value) AS ecommerce_net_revenue,

        SUM(
            COALESCE(refund_subtotal, 0)
            + COALESCE(refund_tax, 0)
        ) AS refunds

    FROM {{ ref('wh_fact_orders') }}

    WHERE COALESCE(is_cancelled, FALSE) = FALSE

    GROUP BY 1, 2
),

reconciled AS (

    SELECT
        COALESCE(m.activity_date, c.activity_date) AS activity_date,
        COALESCE(m.normalized_channel, c.normalized_channel)
            AS normalized_channel,

        -- Marketing platform metrics
        COALESCE(m.platform_spend, 0) AS platform_spend,

        COALESCE(m.platform_attributed_revenue, 0)
            AS platform_attributed_revenue,

        COALESCE(m.platform_attributed_conversions, 0)
            AS platform_attributed_conversions,

        -- Commerce source-of-truth metrics
        COALESCE(c.ecommerce_orders, 0)
            AS ecommerce_orders,

        COALESCE(c.ecommerce_net_revenue, 0)
            AS ecommerce_net_revenue,

        COALESCE(c.refunds, 0)
            AS refunds,

        -- Revenue discrepancy
        COALESCE(m.platform_attributed_revenue, 0)
            - COALESCE(c.ecommerce_net_revenue, 0)
            AS revenue_variance,

        SAFE_DIVIDE(
            COALESCE(m.platform_attributed_revenue, 0)
                - COALESCE(c.ecommerce_net_revenue, 0),
            NULLIF(COALESCE(c.ecommerce_net_revenue, 0), 0)
        ) AS revenue_variance_pct,

        -- Conversion discrepancy
        COALESCE(m.platform_attributed_conversions, 0)
            - COALESCE(c.ecommerce_orders, 0)
            AS conversion_variance,

        SAFE_DIVIDE(
            COALESCE(m.platform_attributed_conversions, 0)
                - COALESCE(c.ecommerce_orders, 0),
            NULLIF(COALESCE(c.ecommerce_orders, 0), 0)
        ) AS conversion_variance_pct,

        -- Two perspectives on ROAS
        SAFE_DIVIDE(
            COALESCE(m.platform_attributed_revenue, 0),
            NULLIF(COALESCE(m.platform_spend, 0), 0)
        ) AS platform_roas,

        SAFE_DIVIDE(
            COALESCE(c.ecommerce_net_revenue, 0),
            NULLIF(COALESCE(m.platform_spend, 0), 0)
        ) AS commerce_based_roas

    FROM marketing_data m

    FULL OUTER JOIN commerce_data c
        ON m.activity_date = c.activity_date
        AND m.normalized_channel = c.normalized_channel
),

final AS (

    SELECT
        *,

        platform_roas - commerce_based_roas
            AS roas_variance,

        CASE
            WHEN ecommerce_net_revenue = 0
                AND platform_attributed_revenue > 0
                THEN 'Platform Revenue Only'

            WHEN ecommerce_net_revenue > 0
                AND platform_attributed_revenue = 0
                THEN 'Commerce Revenue Only'

            WHEN ABS(revenue_variance_pct) <= 0.05
                THEN 'Aligned'

            WHEN ABS(revenue_variance_pct) <= 0.15
                THEN 'Review'

            WHEN revenue_variance_pct IS NOT NULL
                THEN 'Investigate'

            ELSE 'No Activity'
        END AS reconciliation_status,

        CASE
            WHEN platform_attributed_revenue > ecommerce_net_revenue
                THEN 'Platform Higher'

            WHEN platform_attributed_revenue < ecommerce_net_revenue
                THEN 'Commerce Higher'

            ELSE 'Aligned'
        END AS discrepancy_direction,

        CURRENT_TIMESTAMP() AS created_at

    FROM reconciled
)

SELECT *
FROM final

ORDER BY
    activity_date DESC,
    ABS(revenue_variance) DESC