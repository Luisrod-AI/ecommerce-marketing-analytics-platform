view: fact_marketing_performance {
  sql_table_name: `ra-development.analytics_ecommerce_ecommerce.fact_marketing_performance` ;;
  
  # Primary Key
  dimension: marketing_key {
    primary_key: yes
    type: string
    sql: ${TABLE}.marketing_key ;;
    description: "Marketing activity surrogate key"
  }

  # Date dimension
  dimension_group: activity {
    type: time
    timeframes: [raw, date, week, month, quarter, year, day_of_week, week_of_year]
    sql: ${TABLE}.activity_date ;;
    description: "Activity date timeframes"
  }

  # Marketing identifiers
  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
    description: "Marketing platform"
  }

  dimension: marketing_type {
    type: string
    sql: ${TABLE}.marketing_type ;;
    description: "Type of marketing"
  }

  dimension: content_type {
    type: string
    sql: ${TABLE}.content_type ;;
    description: "Type of content"
  }

  dimension: content_name {
    type: string
    sql: ${TABLE}.content_name ;;
    description: "Name of the content/campaign"
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.content_name ;;
    description: "Campaign name"
  }

  dimension: campaign_status {
    type: string
    sql: CASE 
      WHEN DATE(${activity_raw}) >= CURRENT_DATE() - 7 THEN 'active'
      WHEN DATE(${activity_raw}) >= CURRENT_DATE() - 30 THEN 'recent'
      ELSE 'inactive'
    END ;;
    description: "Campaign status based on activity"
  }

  dimension: utm_source {
    type: string
    sql: ${TABLE}.utm_source ;;
    description: "UTM source parameter"
  }

  dimension: utm_medium {
    type: string
    sql: ${TABLE}.utm_medium ;;
    description: "UTM medium parameter"
  }

  # Financial metrics
  dimension: spend_amount {
    type: number
    sql: ${TABLE}.spend_amount ;;
    value_format_name: usd
    description: "Advertising spend"
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
    value_format_name: usd
    description: "Revenue attributed"
  }

  dimension: profit {
    type: number
    sql: ${TABLE}.profit ;;
    value_format_name: usd
    description: "Profit (revenue - spend)"
  }

  dimension: return_on_ad_spend {
    type: number
    sql: ${TABLE}.return_on_ad_spend ;;
    value_format_name: decimal_2
    description: "Return on ad spend (ROAS)"
  }

  # Performance metrics
  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
    description: "Number of impressions"
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
    description: "Number of clicks"
  }

  dimension: conversions {
    type: number
    sql: ${TABLE}.conversions ;;
    description: "Number of conversions"
  }

  # Social engagement metrics
  dimension: likes {
    type: number
    sql: ${TABLE}.likes ;;
    description: "Number of likes"
  }

  dimension: comments {
    type: number
    sql: ${TABLE}.comments ;;
    description: "Number of comments"
  }

  dimension: shares {
    type: number
    sql: ${TABLE}.shares ;;
    description: "Number of shares"
  }

  dimension: saves {
    type: number
    sql: ${TABLE}.saves ;;
    description: "Number of saves"
  }

  dimension: total_interactions {
    type: number
    sql: ${TABLE}.total_interactions ;;
    description: "Total interactions"
  }

  dimension: overall_engagement_rate {
    type: number
    sql: ${TABLE}.overall_engagement_rate ;;
    value_format_name: percent_2
    description: "Overall engagement rate"
  }

  # Calculated metrics
  dimension: cost_per_click {
    type: number
    sql: ${TABLE}.cost_per_click ;;
    value_format_name: usd
    description: "Cost per click"
  }

  dimension: click_through_rate {
    type: number
    sql: ${TABLE}.click_through_rate ;;
    value_format_name: percent_2
    description: "Click-through rate"
  }

  dimension: cost_per_acquisition {
    type: number
    sql: ${TABLE}.cost_per_acquisition ;;
    value_format_name: usd
    description: "Cost per acquisition"
  }

  dimension: engagement_rate {
    type: number
    sql: ${TABLE}.engagement_rate ;;
    value_format_name: percent_2
    description: "Engagement rate"
  }

  # Classification dimensions
  dimension: performance_tier {
    type: string
    sql: ${TABLE}.performance_tier ;;
    description: "Performance tier classification"
  }

  dimension: channel_category {
    type: string
    sql: ${TABLE}.channel_category ;;
    description: "Channel category"
  }

  dimension: performance_score {
    type: number
    sql: ${TABLE}.performance_score ;;
    value_format_name: decimal_2
    description: "Performance score"
  }

  # Metadata
  dimension: source_table {
    type: string
    sql: ${TABLE}.source_table ;;
    description: "Source table for this record"
  }

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
    description: "Created timestamp"
  }

  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
    description: "Updated timestamp"
  }

  # Measures
  measure: count {
    type: count
    drill_fields: [marketing_key, activity_date, platform, content_name]
  }

  measure: records_with_spend {
    type: count
    filters: [spend_amount: ">0"]
    description: "Count of records with spend > 0"
  }

  measure: records_with_nulls {
    type: count
    filters: [spend_amount: "NULL"]
    description: "Count of records with NULL spend"
  }

  measure: total_spend {
    type: sum
    sql: COALESCE(${spend_amount}, 0) ;;
    value_format_name: usd
    description: "Total advertising spend"
  }

  measure: total_revenue {
    type: sum
    sql: COALESCE(${revenue}, 0) ;;
    value_format_name: usd
    description: "Total attributed revenue"
  }

  measure: total_profit {
    type: sum
    sql: COALESCE(${profit}, 0) ;;
    value_format_name: usd
    description: "Total profit"
  }

  measure: total_impressions {
    type: sum
    sql: COALESCE(${impressions}, 0) ;;
    description: "Total impressions"
  }

  measure: total_clicks {
    type: sum
    sql: COALESCE(${clicks}, 0) ;;
    description: "Total clicks"
  }

  measure: total_conversions {
    type: sum
    sql: COALESCE(${conversions}, 0) ;;
    description: "Total conversions"
  }

  measure: total_likes {
    type: sum
    sql: ${likes} ;;
    description: "Total likes"
  }

  measure: total_comments {
    type: sum
    sql: ${comments} ;;
    description: "Total comments"
  }

  measure: total_shares {
    type: sum
    sql: ${shares} ;;
    description: "Total shares"
  }

  measure: total_saves {
    type: sum
    sql: ${saves} ;;
    description: "Total saves"
  }

  measure: total_engagements {
    type: sum
    sql: ${total_interactions} ;;
    description: "Total engagements"
  }

  measure: avg_roas {
    type: average
    sql: ${return_on_ad_spend} ;;
    value_format_name: decimal_2
    description: "Average return on ad spend"
  }

  measure: overall_roas {
    type: number
    sql: ${total_revenue} / NULLIF(${total_spend}, 0) ;;
    value_format_name: decimal_2
    description: "Overall return on ad spend"
  }

  measure: overall_cpa {
    type: number
    sql: ${total_spend} / NULLIF(${total_conversions}, 0) ;;
    value_format_name: usd
    description: "Overall cost per acquisition"
  }

  measure: overall_ctr {
    type: number
    sql: ${total_clicks} / NULLIF(${total_impressions}, 0) ;;
    value_format_name: percent_2
    description: "Overall click-through rate"
  }

  measure: average_cpc {
    type: number
    sql: ${total_spend} / NULLIF(${total_clicks}, 0) ;;
    value_format_name: usd
    description: "Average cost per click"
  }

  measure: avg_engagement_rate {
    type: average
    sql: ${overall_engagement_rate} ;;
    value_format_name: percent_2
    description: "Average engagement rate"
  }

  measure: avg_performance_score {
    type: average
    sql: ${performance_score} ;;
    value_format_name: decimal_2
    description: "Average performance score"
  }

  measure: overall_conversion_rate {
    type: number
    sql: ${total_conversions} / NULLIF(${total_clicks}, 0) ;;
    value_format_name: percent_2
    description: "Overall conversion rate"
  }

  # Debug measure to check if data exists
  measure: debug_total_spend {
    type: number
    sql: SUM(${TABLE}.spend_amount) ;;
    value_format_name: usd
    description: "Debug: Direct sum of spend_amount from table"
  }

  measure: debug_row_count {
    type: count_distinct
    sql: ${TABLE}.marketing_key ;;
    description: "Debug: Count of distinct marketing keys"
  }
}