SELECT *
FROM {{ ref('wh_agg_marketing_efficiency_scorecard') }}
WHERE
    spend_share > 0
    AND ABS(
        efficiency_index
        - SAFE_DIVIDE(revenue_share, spend_share)
    ) > 0.000001