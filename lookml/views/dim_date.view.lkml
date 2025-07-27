view: dim_date {
  sql_table_name: `ra-development.analytics_ecommerce_ecommerce.dim_date` ;;
  
  # Primary Key
  dimension: date_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.date_key ;;
    description: "Primary key in YYYYMMDD format"
  }

  # Date Dimensions
  dimension_group: date_actual {
    type: time
    timeframes: [raw, date, week, month, quarter, year, day_of_week, day_of_month, day_of_year]
    datatype: timestamp
    sql: ${TABLE}.date_actual ;;
    description: "Calendar date"
  }

  dimension: calendar_date {
    type: date
    sql: ${TABLE}.date_actual ;;
    description: "Calendar date (alias for date_actual)"
  }

  # Year Dimensions
  dimension: year_number {
    type: number
    sql: ${TABLE}.year_number ;;
    description: "Year number"
  }

  dimension: year_name {
    type: string
    sql: ${TABLE}.year_name ;;
    description: "Year name"
  }

  # Quarter Dimensions
  dimension: quarter_number {
    type: number
    sql: ${TABLE}.quarter_number ;;
    description: "Quarter number (1-4)"
  }

  dimension: quarter_name {
    type: string
    sql: ${TABLE}.quarter_name ;;
    description: "Quarter name"
  }

  dimension: quarter_code {
    type: string
    sql: ${TABLE}.quarter_code ;;
    description: "Quarter code"
  }

  # Month Dimensions
  dimension: month_number {
    type: number
    sql: ${TABLE}.month_number ;;
    description: "Month number (1-12)"
  }

  dimension: month_name {
    type: string
    sql: ${TABLE}.month_name ;;
    description: "Month name"
  }

  dimension: month_short_name {
    type: string
    sql: ${TABLE}.month_short_name ;;
    description: "Month short name"
  }

  dimension: month_year_name {
    type: string
    sql: ${TABLE}.month_year_name ;;
    description: "Month year name"
  }

  dimension: month_year_code {
    type: string
    sql: ${TABLE}.month_year_code ;;
    description: "Month year code"
  }

  # Week Dimensions
  dimension: week_number {
    type: number
    sql: ${TABLE}.week_number ;;
    description: "Week number"
  }

  dimension: iso_week_number {
    type: number
    sql: ${TABLE}.iso_week_number ;;
    description: "ISO week number"
  }

  dimension_group: week_start {
    type: time
    timeframes: [raw, date]
    datatype: datetime
    sql: ${TABLE}.week_start_date ;;
    description: "Week start date"
  }

  dimension_group: week_end {
    type: time
    timeframes: [raw, date]
    datatype: datetime
    sql: ${TABLE}.week_end_date ;;
    description: "Week end date"
  }

  # Day Dimensions
  dimension: day_of_month {
    type: number
    sql: ${TABLE}.day_of_month ;;
    description: "Day of month (1-31)"
  }

  dimension: day_of_year {
    type: number
    sql: ${TABLE}.day_of_year ;;
    description: "Day of year (1-366)"
  }

  dimension: day_of_week_number {
    type: number
    sql: ${TABLE}.day_of_week_number ;;
    description: "Day of week number (1-7)"
  }

  dimension: day_of_week_name {
    type: string
    sql: ${TABLE}.day_of_week_name ;;
    description: "Day of week name"
  }

  dimension: day_of_week_short_name {
    type: string
    sql: ${TABLE}.day_of_week_short_name ;;
    description: "Day of week short name"
  }

  # Boolean Flags
  dimension: is_weekday {
    type: yesno
    sql: ${TABLE}.is_weekday ;;
    description: "Is weekday"
  }

  dimension: is_weekend {
    type: yesno
    sql: ${TABLE}.is_weekend ;;
    description: "Is weekend"
  }

  # Current Period Flags
  dimension: is_current_day {
    type: yesno
    sql: ${TABLE}.is_current_day ;;
    description: "Is current day"
  }

  dimension: is_current_week {
    type: yesno
    sql: ${TABLE}.is_current_week ;;
    description: "Is current week"
  }

  dimension: is_current_month {
    type: yesno
    sql: ${TABLE}.is_current_month ;;
    description: "Is current month"
  }

  dimension: is_current_quarter {
    type: yesno
    sql: ${TABLE}.is_current_quarter ;;
    description: "Is current quarter"
  }

  dimension: is_current_year {
    type: yesno
    sql: ${TABLE}.is_current_year ;;
    description: "Is current year"
  }

  # Previous Period Flags
  dimension: is_previous_day {
    type: yesno
    sql: ${TABLE}.is_previous_day ;;
    description: "Is previous day"
  }

  dimension: is_previous_week {
    type: yesno
    sql: ${TABLE}.is_previous_week ;;
    description: "Is previous week"
  }

  dimension: is_previous_month {
    type: yesno
    sql: ${TABLE}.is_previous_month ;;
    description: "Is previous month"
  }

  dimension: is_previous_quarter {
    type: yesno
    sql: ${TABLE}.is_previous_quarter ;;
    description: "Is previous quarter"
  }

  dimension: is_previous_year {
    type: yesno
    sql: ${TABLE}.is_previous_year ;;
    description: "Is previous year"
  }

  # Fiscal Dimensions
  dimension: fiscal_year {
    type: number
    sql: ${TABLE}.fiscal_year ;;
    description: "Fiscal year"
  }

  dimension: fiscal_quarter {
    type: number
    sql: ${TABLE}.fiscal_quarter ;;
    description: "Fiscal quarter"
  }

  # Metadata
  dimension_group: warehouse_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.warehouse_updated_at ;;
    description: "Warehouse update timestamp"
  }

  # Measures
  measure: count {
    type: count
    drill_fields: [date_key, date_actual_date, day_of_week_name, month_name]
  }

  measure: count_weekdays {
    type: count
    filters: [is_weekday: "yes"]
    description: "Count of weekdays"
  }

  measure: count_weekends {
    type: count
    filters: [is_weekend: "yes"]
    description: "Count of weekend days"
  }

  measure: count_current_period {
    type: count
    filters: [is_current_day: "yes"]
    description: "Count of current period days"
  }

  measure: days_in_period {
    type: count_distinct
    sql: ${date_key} ;;
    description: "Number of days in selected period"
  }
}