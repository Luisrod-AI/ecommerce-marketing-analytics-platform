- dashboard: data_quality_monitoring
  title: Data Quality Monitoring
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Data pipeline health, quality metrics, and monitoring dashboard"
  
  refresh: 15 minutes
  
  filters:
  - name: date_range
    title: Date Range
    type: field_filter
    default_value: "7 days"
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
    model: ecommerce_demo
    explore: data_quality
    field: quality_date.date_actual_date
    
  - name: data_source_filter
    title: Data Source
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: ecommerce_demo
    explore: data_quality
    field: data_quality.data_source
    
  - name: data_layer_filter
    title: Data Layer
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: ecommerce_demo
    explore: data_quality
    field: data_quality.data_layer
    
  elements:
  
  # Data Quality KPIs
  - title: Overall Test Pass Rate
    name: overall_test_pass_rate
    model: ecommerce_demo
    explore: data_quality
    type: single_value
    fields: [data_quality.overall_test_pass_rate]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "0.0\"%\""
    conditional_formatting: [{type: greater than, value: 0.95, background_color: "#1f77b4",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: between, value: [0.9, 0.95],
        background_color: "#ff7f0e", font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: less than, value: 0.9, background_color: "#d62728",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    listen:
      date_range: quality_date.date_actual_date
      data_source_filter: data_quality.data_source
      data_layer_filter: data_quality.data_layer
    row: 0
    col: 0
    width: 4
    height: 4
    
  - title: Average Pipeline Health
    name: average_pipeline_health
    model: ecommerce_demo
    explore: data_quality
    type: single_value
    fields: [data_quality.average_pipeline_health]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "0.0\"%\""
    conditional_formatting: [{type: greater than, value: 80, background_color: "#1f77b4",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: between, value: [60, 80], background_color: "#ff7f0e",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: less than, value: 60, background_color: "#d62728",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    listen:
      date_range: quality_date.date_actual_date
      data_source_filter: data_quality.data_source
      data_layer_filter: data_quality.data_layer
    row: 0
    col: 4
    width: 4
    height: 4
    
  - title: Total Data Volume
    name: total_data_volume
    model: ecommerce_demo
    explore: data_quality
    type: single_value
    fields: [data_quality.total_data_volume]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "#,##0"
    listen:
      date_range: quality_date.date_actual_date
      data_source_filter: data_quality.data_source
      data_layer_filter: data_quality.data_layer
    row: 0
    col: 8
    width: 4
    height: 4
    
  - title: Sources with Issues
    name: sources_with_issues
    model: ecommerce_demo
    explore: data_quality
    type: single_value
    fields: [data_quality.sources_with_issues]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "#,##0"
    conditional_formatting: [{type: equal to, value: 0, background_color: "#1f77b4",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: greater than, value: 0, background_color: "#d62728",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    listen:
      date_range: quality_date.date_actual_date
      data_source_filter: data_quality.data_source
      data_layer_filter: data_quality.data_layer
    row: 0
    col: 12
    width: 4
    height: 4
    
  - title: Average Flow Efficiency
    name: average_flow_efficiency
    model: ecommerce_demo
    explore: data_quality
    type: single_value
    fields: [data_quality.average_flow_efficiency]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "0.0\"%\""
    conditional_formatting: [{type: greater than, value: 0.9, background_color: "#1f77b4",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: between, value: [0.75, 0.9],
        background_color: "#ff7f0e", font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: less than, value: 0.75, background_color: "#d62728",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    listen:
      date_range: quality_date.date_actual_date
      data_source_filter: data_quality.data_source
      data_layer_filter: data_quality.data_layer
    row: 0
    col: 16
    width: 4
    height: 4
    
  - title: Data Quality Score
    name: data_quality_score
    model: ecommerce_demo
    explore: data_quality
    type: single_value
    fields: [data_quality.data_quality_score]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "0.0\"%\""
    conditional_formatting: [{type: greater than, value: 0.9, background_color: "#1f77b4",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: between, value: [0.8, 0.9],
        background_color: "#ff7f0e", font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: less than, value: 0.8, background_color: "#d62728",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    listen:
      date_range: quality_date.date_actual_date
      data_source_filter: data_quality.data_source
      data_layer_filter: data_quality.data_layer
    row: 0
    col: 20
    width: 4
    height: 4
    
  # Pipeline Health Trend
  - title: Pipeline Health Trend
    name: pipeline_health_trend
    model: ecommerce_demo
    explore: data_quality
    type: looker_line
    fields: [quality_date.date_actual_date, data_quality.average_pipeline_health, 
             data_quality.overall_test_pass_rate, data_quality.average_flow_efficiency]
    sorts: [quality_date.date_actual_date desc]
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
    y_axes: [{label: Health Score, orientation: left, series: [{axisId: data_quality.average_pipeline_health,
            id: data_quality.average_pipeline_health, name: Average Pipeline Health}],
        showLabels: true, showValues: true, valueFormat: '0.0', unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}, {label: Percentage,
        orientation: right, series: [{axisId: data_quality.overall_test_pass_rate,
            id: data_quality.overall_test_pass_rate, name: Overall Test Pass Rate},
          {axisId: data_quality.average_flow_efficiency, id: data_quality.average_flow_efficiency,
            name: Average Flow Efficiency}], showLabels: true, showValues: true,
        valueFormat: '0.0"%"', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    listen:
      date_range: quality_date.date_actual_date
      data_source_filter: data_quality.data_source
      data_layer_filter: data_quality.data_layer
    row: 4
    col: 0
    width: 24
    height: 8
    
  # Data Source Health Status
  - title: Data Source Health Status
    name: data_source_health_status
    model: ecommerce_demo
    explore: data_quality
    type: looker_bar
    fields: [data_quality.data_source, data_quality.count, data_quality.health_status]
    pivots: [data_quality.health_status]
    sorts: [data_quality.data_source]
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
    series_colors:
      Healthy - data_quality.count: "#1f77b4"
      Warning - data_quality.count: "#ff7f0e"
      Critical - data_quality.count: "#d62728"
      Failed - data_quality.count: "#8b0000"
    listen:
      date_range: quality_date.date_actual_date
      data_source_filter: data_quality.data_source
      data_layer_filter: data_quality.data_layer
    row: 12
    col: 0
    width: 12
    height: 8
    
  # Data Flow Efficiency by Layer
  - title: Data Flow Efficiency by Layer
    name: data_flow_efficiency_layer
    model: ecommerce_demo
    explore: data_quality
    type: looker_column
    fields: [data_quality.data_layer, data_quality.source_to_staging_flow_pct, 
             data_quality.staging_to_integration_flow_pct, data_quality.integration_to_warehouse_flow_pct,
             data_quality.end_to_end_flow_pct]
    sorts: [data_quality.data_layer]
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
    value_format: "0\"%\""
    listen:
      date_range: quality_date.date_actual_date
      data_source_filter: data_quality.data_source
      data_layer_filter: data_quality.data_layer
    row: 12
    col: 12
    width: 12
    height: 8
    
  # Data Volume by Source
  - title: Data Volume by Source
    name: data_volume_by_source
    model: ecommerce_demo
    explore: data_quality
    type: looker_pie
    fields: [data_quality.data_source, data_quality.total_data_volume]
    sorts: [data_quality.total_data_volume desc]
    limit: 500
    value_labels: legend
    label_type: labPer
    inner_radius: 50
    start_angle: 90
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
    series_colors: {}
    value_format: "#,##0"
    listen:
      date_range: quality_date.date_actual_date
      data_source_filter: data_quality.data_source
      data_layer_filter: data_quality.data_layer
    row: 20
    col: 0
    width: 12
    height: 8
    
  # Error and Warning Summary
  - title: Error and Warning Summary
    name: error_warning_summary
    model: ecommerce_demo
    explore: data_quality
    type: looker_bar
    fields: [data_quality.data_source, data_quality.total_errors, data_quality.total_warnings]
    sorts: [data_quality.total_errors desc]
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
    series_colors:
      data_quality.total_errors: "#d62728"
      data_quality.total_warnings: "#ff7f0e"
    listen:
      date_range: quality_date.date_actual_date
      data_source_filter: data_quality.data_source
      data_layer_filter: data_quality.data_layer
    row: 20
    col: 12
    width: 12
    height: 8