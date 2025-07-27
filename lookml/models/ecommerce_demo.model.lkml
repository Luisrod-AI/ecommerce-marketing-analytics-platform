# Ra Ecommerce Analytics Model
# This model defines the explores and relationships for the ecommerce data warehouse

connection: "ra_dw_prod"

# Note: Constants removed - define PROJECT_ID and ECOMMERCE_DATASET in your Looker instance

# Project configurations
include: "../views/*.view.lkml"
include: "../dashboards/*.dashboard.lookml"

datagroup: ra_ecommerce_default_datagroup {
  sql_trigger: SELECT MAX(last_updated) FROM `ra-development.analytics_ecommerce_ecommerce.fact_data_quality` ;;
  max_cache_age: "1 hour"
}

persist_with: ra_ecommerce_default_datagroup

# Main Orders Explore - Central hub for order analysis
explore: orders {
  from: fact_orders
  label: "Orders & Sales Analysis"
  description: "Comprehensive order and sales analysis with customer, product, and date dimensions"
  
  # Date dimension
  join: order_date {
    from: dim_date
    type: left_outer
    sql_on: ${orders.order_date_key} = ${order_date.date_key} ;;
    relationship: many_to_one
    fields: [order_date.date_actual_date, order_date.date_actual_week, order_date.date_actual_month, 
             order_date.date_actual_quarter, order_date.date_actual_year, order_date.date_actual_day_of_week, 
             order_date.date_actual_day_of_month, order_date.is_weekend, order_date.date_key]
  }
  
  # Customer dimension
  join: customers {
    from: dim_customers
    type: left_outer
    sql_on: ${orders.customer_key} = ${customers.customer_key} ;;
    relationship: many_to_one
  }
  
  # Channel dimension
  join: channels {
    from: dim_channels
    type: left_outer
    sql_on: ${orders.channel_key} = ${channels.channel_key} ;;
    relationship: many_to_one
  }
  
  # Order Items join to access product information
  join: order_items {
    from: fact_order_items
    type: left_outer
    sql_on: ${orders.order_id} = ${order_items.order_id} ;;
    relationship: one_to_many
  }
  
  # Product dimension through order items
  join: products {
    from: dim_products
    type: left_outer
    sql_on: ${order_items.product_key} = ${products.product_key} ;;
    relationship: many_to_one
  }
}

# Order Items Explore - Line item detail analysis
explore: order_items {
  from: fact_order_items
  label: "Order Items Analysis"
  description: "Detailed order line item analysis with product, customer, and channel dimensions"
  
  # Date dimension
  join: order_date {
    from: dim_date
    type: left_outer
    sql_on: ${order_items.order_date_key} = ${order_date.date_key} ;;
    relationship: many_to_one
    fields: [order_date.date_actual_date, order_date.date_actual_week, order_date.date_actual_month, 
             order_date.date_actual_quarter, order_date.date_actual_year, order_date.date_actual_day_of_week, 
             order_date.date_actual_day_of_month, order_date.is_weekend, order_date.date_key]
  }
  
  # Customer dimension
  join: customers {
    from: dim_customers
    type: left_outer
    sql_on: ${order_items.customer_key} = ${customers.customer_key} ;;
    relationship: many_to_one
  }
  
  # Product dimension
  join: products {
    from: dim_products
    type: left_outer
    sql_on: ${order_items.product_key} = ${products.product_key} ;;
    relationship: many_to_one
  }
  
  # Channel dimension
  join: channels {
    from: dim_channels
    type: left_outer
    sql_on: ${order_items.channel_key} = ${channels.channel_key} ;;
    relationship: many_to_one
  }
  
  # Order header
  join: orders {
    from: fact_orders
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.order_id} ;;
    relationship: many_to_one
  }
}

# Sessions Explore - Web analytics focus
explore: sessions {
  from: fact_sessions
  label: "Web Sessions & Events"
  description: "Website behavior analysis including sessions, events, and conversions"
  
  # Date dimension
  join: session_date {
    from: dim_date
    type: left_outer
    sql_on: ${sessions.session_date_key} = ${session_date.date_key} ;;
    relationship: many_to_one
    fields: [session_date.date_actual_date, session_date.date_actual_week, session_date.date_actual_month, 
             session_date.date_actual_quarter, session_date.date_actual_year, session_date.date_actual_day_of_week, 
             session_date.date_actual_day_of_month, session_date.is_weekend]
  }
  
  # Channel dimension
  join: channels {
    from: dim_channels
    type: left_outer
    sql_on: ${sessions.channel_key} = ${channels.channel_key} ;;
    relationship: many_to_one
  }
  
  # Events
  join: events {
    from: fact_events
    type: left_outer
    sql_on: ${sessions.user_pseudo_id} = ${events.user_pseudo_id} 
      AND DATE(${sessions.session_start_raw}) = ${events.event_date_only_date} ;;
    relationship: one_to_many
  }
}

# Marketing Performance Explore  
explore: marketing_performance {
  from: fact_marketing_performance
  label: "Marketing Performance"
  description: "Unified marketing campaign performance across all platforms"
  
  # Date dimension
  join: activity_date {
    from: dim_date
    type: left_outer
    sql_on: DATE(${marketing_performance.activity_raw}) = ${activity_date.date_actual_date} ;;
    relationship: many_to_one
    fields: [activity_date.date_actual_date, activity_date.date_actual_week, activity_date.date_actual_month, 
             activity_date.date_actual_quarter, activity_date.date_actual_year, activity_date.date_actual_day_of_week, 
             activity_date.date_actual_day_of_month, activity_date.is_weekend]
  }
}

# Customer Journey Explore
explore: customer_journey {
  from: fact_customer_journey
  label: "Customer Journey"
  description: "Multi-touch attribution and customer path analysis"
  
  # Date dimension
  join: session_date {
    from: dim_date
    type: left_outer
    sql_on: ${customer_journey.session_date_key} = ${session_date.date_key} ;;
    relationship: many_to_one
    fields: [session_date.date_actual_date, session_date.date_actual_week, session_date.date_actual_month, 
             session_date.date_actual_quarter, session_date.date_actual_year]
  }
  
  join: order_date {
    from: dim_date
    type: left_outer
    sql_on: ${customer_journey.order_date_key} = ${order_date.date_key} ;;
    relationship: many_to_one
    fields: [order_date.date_actual_date, order_date.date_actual_week, order_date.date_actual_month, 
             order_date.date_actual_quarter, order_date.date_actual_year]
  }
  
  # Customer dimension
  join: customers {
    from: dim_customers
    type: left_outer
    sql_on: ${customer_journey.customer_key} = ${customers.customer_key} ;;
    relationship: many_to_one
  }
  
  # Order dimension
  join: orders {
    from: fact_orders
    type: left_outer
    sql_on: ${customer_journey.order_key} = ${orders.order_key} ;;
    relationship: many_to_one
  }
  
  # Session dimension
  join: sessions {
    from: fact_sessions
    type: left_outer
    sql_on: ${customer_journey.session_key} = ${sessions.session_key} ;;
    relationship: many_to_one
  }
}

# Inventory Explore
explore: inventory {
  from: fact_inventory
  label: "Inventory Management"
  description: "Product inventory levels and stock management"
  
  # Product dimension
  join: products {
    from: dim_products
    type: left_outer
    sql_on: ${inventory.product_id} = ${products.product_id} ;;
    relationship: many_to_one
  }
}

# Data Quality Explore
explore: data_quality {
  from: fact_data_quality
  label: "Data Quality Monitoring"
  description: "Monitor pipeline health and data quality metrics"
  
  # Date dimension
  join: quality_date {
    from: dim_date
    type: left_outer
    sql_on: ${data_quality.report_date} = ${quality_date.date_actual_date} ;;
    relationship: many_to_one
    fields: [quality_date.date_actual_date, quality_date.date_actual_week, quality_date.date_actual_month, 
             quality_date.date_actual_quarter, quality_date.date_actual_year, quality_date.date_actual_day_of_week, 
             quality_date.date_actual_day_of_month, quality_date.is_weekend, quality_date.date_key]
  }
}

# Email Marketing Explore
explore: email_marketing {
  from: fact_email_marketing
  label: "Email Marketing Performance"
  description: "Email campaign performance metrics and engagement"
  
  # Date dimension
  join: event_date {
    from: dim_date
    type: left_outer
    sql_on: ${email_marketing.date_key} = ${event_date.date_key} ;;
    relationship: many_to_one
    fields: [event_date.date_actual_date, event_date.date_actual_week, event_date.date_actual_month, 
             event_date.date_actual_quarter, event_date.date_actual_year, event_date.date_actual_day_of_week, 
             event_date.date_actual_day_of_month, event_date.is_weekend]
  }
}

# Social Posts Explore
explore: social_posts {
  from: fact_social_posts
  label: "Social Media Performance"
  description: "Social media content performance and engagement analytics"
  
  # Date dimension
  join: post_date {
    from: dim_date
    type: left_outer
    sql_on: DATE(${social_posts.post_raw}) = ${post_date.date_actual_date} ;;
    relationship: many_to_one
    fields: [post_date.date_actual_date, post_date.date_actual_week, post_date.date_actual_month, 
             post_date.date_actual_quarter, post_date.date_actual_year, post_date.date_actual_day_of_week, 
             post_date.date_actual_day_of_month, post_date.is_weekend]
  }
  
  # Social content dimension
  join: social_content {
    from: dim_social_content
    type: left_outer
    sql_on: ${social_posts.post_id} = ${social_content.post_id} ;;
    relationship: many_to_one
  }
}

# Customer Metrics Explore
explore: customer_metrics {
  from: dim_customer_metrics
  label: "Customer Analytics"
  description: "Comprehensive customer metrics including RFM, CLV, and predictive analytics"
  
  # Customer dimension
  join: customers {
    from: dim_customers
    type: left_outer
    sql_on: ${customer_metrics.customer_key} = ${customers.customer_key} ;;
    relationship: many_to_one
  }
}

# Attribution Analysis Explore
# Attribution Analysis Explore (alias for fact_customer_journey)
explore: attribution_analysis {
  from: fact_customer_journey
  label: "Attribution Analysis"
  description: "Multi-touch attribution and customer journey analysis"
  
  # Date dimension for attribution
  join: attribution_date {
    from: dim_date
    type: left_outer
    sql_on: ${attribution_analysis.session_date_key} = ${attribution_date.date_key} ;;
    relationship: many_to_one
    fields: [attribution_date.date_actual_date, attribution_date.date_actual_week, 
             attribution_date.date_actual_month, attribution_date.date_actual_quarter, 
             attribution_date.date_actual_year, attribution_date.calendar_date]
  }
  
  # Channel dimension for touchpoints
  join: touchpoint_channels {
    from: dim_channels
    type: left_outer
    sql_on: ${attribution_analysis.channel_key} = ${touchpoint_channels.channel_key} ;;
    relationship: many_to_one
  }
  
  # Customer dimension
  join: customers {
    from: dim_customers
    type: left_outer
    sql_on: ${attribution_analysis.customer_key} = ${customers.customer_key} ;;
    relationship: many_to_one
  }
  
  # Order dimension
  join: orders {
    from: fact_orders
    type: left_outer
    sql_on: ${attribution_analysis.order_key} = ${orders.order_key} ;;
    relationship: many_to_one
  }
}

# Customer Journey Explore (keep for backward compatibility)
explore: fact_customer_journey {
  label: "Attribution Analysis"
  description: "Multi-touch attribution and customer journey analysis"
  
  # Date dimension for attribution
  join: attribution_date {
    from: dim_date
    type: left_outer
    sql_on: ${fact_customer_journey.session_date_key} = ${attribution_date.date_key} ;;
    relationship: many_to_one
    fields: [attribution_date.date_actual_date, attribution_date.date_actual_week, 
             attribution_date.date_actual_month, attribution_date.date_actual_quarter, 
             attribution_date.date_actual_year, attribution_date.calendar_date]
  }
  
  # Channel dimension for touchpoints
  join: touchpoint_channels {
    from: dim_channels
    type: left_outer
    sql_on: ${fact_customer_journey.channel_key} = ${touchpoint_channels.channel_key} ;;
    relationship: many_to_one
  }
  
  # Customer dimension
  join: customers {
    from: dim_customers
    type: left_outer
    sql_on: ${fact_customer_journey.customer_key} = ${customers.customer_key} ;;
    relationship: many_to_one
  }
  
  # Order dimension
  join: orders {
    from: fact_orders
    type: left_outer
    sql_on: ${fact_customer_journey.order_key} = ${orders.order_key} ;;
    relationship: many_to_one
  }
}

# Executive Overview Explore - Combines key metrics
explore: executive_overview {
  from: fact_orders
  label: "Executive Overview"
  description: "High-level business performance overview"
  
  # Date dimension
  join: exec_order_date {
    from: dim_date
    type: left_outer
    sql_on: ${executive_overview.order_date_key} = ${exec_order_date.date_key} ;;
    relationship: many_to_one
  }
  
  # Customer dimension
  join: exec_customers {
    from: dim_customers
    type: left_outer
    sql_on: ${executive_overview.customer_key} = ${exec_customers.customer_key} ;;
    relationship: many_to_one
  }
  
  # Channel dimension
  join: exec_channels {
    from: dim_channels
    type: left_outer
    sql_on: ${executive_overview.channel_key} = ${exec_channels.channel_key} ;;
    relationship: many_to_one
  }
  
  # Marketing performance
  join: exec_marketing {
    from: fact_marketing_performance
    type: left_outer
    sql_on: ${exec_order_date.date_actual_date} = DATE(${exec_marketing.activity_raw}) ;;
    relationship: many_to_many
  }
  
  # Sessions
  join: exec_sessions {
    from: fact_sessions
    type: left_outer
    sql_on: ${executive_overview.order_date_key} = ${exec_sessions.session_date_key} ;;
    relationship: many_to_many
  }
}
