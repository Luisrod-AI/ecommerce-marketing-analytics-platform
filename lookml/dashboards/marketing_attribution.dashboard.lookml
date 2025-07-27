- dashboard: marketing_attribution
  title: Marketing & Attribution Analysis
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Marketing campaign performance, attribution analysis, and channel effectiveness"
  
  refresh: 1 hour
  
  filters:
  - name: date_range
    title: Date Range
    type: field_filter
    default_value: "30 days"
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
    model: ecommerce_demo
    explore: marketing_performance
    field: activity_date.date_actual_date
    
  - name: platform_filter
    title: Platform
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: ecommerce_demo
    explore: marketing_performance
    field: marketing_performance.platform
    
  - name: campaign_status
    title: Campaign Status
    type: field_filter
    default_value: "active"
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: ecommerce_demo
    explore: marketing_performance
    field: marketing_performance.campaign_status
    
  elements:
  
  # Marketing KPIs
  - title: Total Ad Spend
    name: total_ad_spend
    model: ecommerce_demo
    explore: marketing_performance
    type: single_value
    fields: [marketing_performance.total_spend]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "$#,##0"
    listen:
      date_range: activity_date.date_actual_date
      platform_filter: marketing_performance.platform
      campaign_status: marketing_performance.campaign_status
    row: 0
    col: 0
    width: 4
    height: 4
    
  - title: Total Conversions
    name: total_conversions
    model: ecommerce_demo
    explore: marketing_performance
    type: single_value
    fields: [marketing_performance.total_conversions]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "#,##0"
    listen:
      date_range: activity_date.date_actual_date
      platform_filter: marketing_performance.platform
      campaign_status: marketing_performance.campaign_status
    row: 0
    col: 4
    width: 4
    height: 4
    
  - title: Overall ROAS
    name: overall_roas
    model: ecommerce_demo
    explore: marketing_performance
    type: single_value
    fields: [marketing_performance.overall_roas]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "0.00x"
    conditional_formatting: [{type: greater than, value: 3, background_color: "#1f77b4",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: between, value: [2, 3], background_color: "#ff7f0e",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: less than, value: 2, background_color: "#d62728",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    listen:
      date_range: activity_date.date_actual_date
      platform_filter: marketing_performance.platform
      campaign_status: marketing_performance.campaign_status
    row: 0
    col: 8
    width: 4
    height: 4
    
  - title: Overall CPA
    name: overall_cpa
    model: ecommerce_demo
    explore: marketing_performance
    type: single_value
    fields: [marketing_performance.overall_cpa]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "$#,##0"
    listen:
      date_range: activity_date.date_actual_date
      platform_filter: marketing_performance.platform
      campaign_status: marketing_performance.campaign_status
    row: 0
    col: 12
    width: 4
    height: 4
    
  - title: Overall CTR
    name: overall_ctr
    model: ecommerce_demo
    explore: marketing_performance
    type: single_value
    fields: [marketing_performance.overall_ctr]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "0.00%"
    listen:
      date_range: activity_date.date_actual_date
      platform_filter: marketing_performance.platform
      campaign_status: marketing_performance.campaign_status
    row: 0
    col: 16
    width: 4
    height: 4
    
  - title: Conversion Rate
    name: conversion_rate
    model: ecommerce_demo
    explore: marketing_performance
    type: single_value
    fields: [marketing_performance.overall_conversion_rate]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "0.00%"
    listen:
      date_range: activity_date.date_actual_date
      platform_filter: marketing_performance.platform
      campaign_status: marketing_performance.campaign_status
    row: 0
    col: 20
    width: 4
    height: 4
    
  # Daily Marketing Performance
  - title: Daily Marketing Performance
    name: daily_marketing_performance
    model: ecommerce_demo
    explore: marketing_performance
    type: looker_line
    fields: [activity_date.date_actual_date, marketing_performance.total_spend, 
             marketing_performance.total_conversions, marketing_performance.overall_roas]
    fill_fields: [activity_date.date_actual_date]
    sorts: [activity_date.date_actual_date desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: Spend, orientation: left, series: [{axisId: marketing_performance.total_spend,
            id: marketing_performance.total_spend, name: Total Spend}], showLabels: true,
        showValues: true, valueFormat: '$#,##0', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: ROAS, orientation: right, series: [
          {axisId: marketing_performance.overall_roas, id: marketing_performance.overall_roas,
            name: Overall Roas}], showLabels: true, showValues: true, valueFormat: '0.00x',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    listen:
      date_range: activity_date.date_actual_date
      platform_filter: marketing_performance.platform
      campaign_status: marketing_performance.campaign_status
    row: 4
    col: 0
    width: 24
    height: 8
    
  # Platform Performance Comparison
  - title: Platform Performance Comparison
    name: platform_performance
    model: ecommerce_demo
    explore: marketing_performance
    type: looker_bar
    fields: [marketing_performance.platform, marketing_performance.total_spend, 
             marketing_performance.total_conversions, marketing_performance.overall_roas]
    sorts: [marketing_performance.total_spend desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: Spend, orientation: left, series: [{axisId: marketing_performance.total_spend,
            id: marketing_performance.total_spend, name: Total Spend}], showLabels: true,
        showValues: true, valueFormat: '$#,##0', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: ROAS, orientation: right, series: [
          {axisId: marketing_performance.overall_roas, id: marketing_performance.overall_roas,
            name: Overall Roas}], showLabels: true, showValues: true, valueFormat: '0.00x',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    listen:
      date_range: activity_date.date_actual_date
      platform_filter: marketing_performance.platform
      campaign_status: marketing_performance.campaign_status
    row: 12
    col: 0
    width: 12
    height: 8
    
  # Campaign Performance Scatter
  - title: Campaign Performance Matrix (Spend vs ROAS)
    name: campaign_performance_matrix
    model: ecommerce_demo
    explore: marketing_performance
    type: looker_scatter
    fields: [marketing_performance.campaign_name, marketing_performance.total_spend, 
             marketing_performance.overall_roas, marketing_performance.platform]
    sorts: [marketing_performance.total_spend desc]
    limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    size_by_field: marketing_performance.total_conversions
    series_colors:
      google_ads: "#1f77b4"
      facebook_ads: "#ff7f0e"
      klaviyo_emails: "#2ca02c"
      pinterest_ads: "#d62728"
      twitter_ads: "#9467bd"
    listen:
      date_range: activity_date.date_actual_date
      platform_filter: marketing_performance.platform
      campaign_status: marketing_performance.campaign_status
    row: 12
    col: 12
    width: 12
    height: 8
    
  # Channel Attribution Analysis
  - title: Channel Attribution Mix
    name: channel_attribution_mix
    model: ecommerce_demo
    explore: attribution_analysis
    type: looker_pie
    fields: [touchpoint_channels.channel_name, attribution_analysis.total_revenue]
    sorts: [attribution_analysis.total_revenue desc]
    limit: 10
    value_labels: legend
    label_type: labPer
    inner_radius: 40
    start_angle: 90
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
    series_colors: {}
    value_format: "$#,##0"
    listen:
      date_range: attribution_date.date_actual_date
    row: 20
    col: 0
    width: 12
    height: 8
    
  # Top Performing Campaigns
  - title: Top Performing Campaigns by ROAS
    name: top_campaigns_roas
    model: ecommerce_demo
    explore: marketing_performance
    type: looker_bar
    fields: [marketing_performance.campaign_name, marketing_performance.platform,
             marketing_performance.overall_roas, marketing_performance.total_spend,
             marketing_performance.total_conversions]
    filters:
      marketing_performance.overall_roas: ">1"
    sorts: [marketing_performance.overall_roas desc]
    limit: 15
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_format: "0.00x"
    series_colors:
      google_ads: "#1f77b4"
      facebook_ads: "#ff7f0e"
      klaviyo_emails: "#2ca02c"
    listen:
      date_range: activity_date.date_actual_date
      platform_filter: marketing_performance.platform
      campaign_status: marketing_performance.campaign_status
    row: 20
    col: 12
    width: 12
    height: 8