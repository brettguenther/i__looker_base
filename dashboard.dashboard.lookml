- dashboard: looker_usage
  title: Looker Usage
  layout: grid
  tile_size: 80

  filters:

    - name: user_name
      title: User Name
      type: field_filter
      explore: history
      field: user.name

    - name: date
      title: Date
      type: date_filter
      default_value: 2 weeks

    - name: is_looker
      title: 'User is Looker Employee (Yes / No)'
      type: field_filter
      explore: history
      field: user.is_looker
      default_value: 'No'

  rows:
    - height: 400
      elements: [query_allocation_column]
    - height: 400
      elements: [active_users, look_who_is_asking]
    - height: 400
      elements: [query_runtime_performance]
    - height: 400
      elements: [scheduled_plan_performance, scheduled_plan_status]
    - height: 400
      elements: [public_looks, top_looks]
    - height: 400
      elements: [commonly_used_fields, dashboard_usage]


  elements:

    - name: dashboard_usage
      title: List of Top Dashboards
      type: table
      model: i__looker
      explore: history
      dimensions: [dashboard.title]
      measures: [history.query_run_count]
      filters:
        dashboard.title: -NULL
      sorts: [history.query_run_count desc]
      limit: '10'
      column_limit: '50'
      query_timezone: America/Los_Angeles
      show_view_names: false
      show_row_numbers: true
      truncate_column_names: false
      hide_totals: false
      hide_row_totals: false
      table_theme: editable
      limit_displayed_rows: false
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: '#808080'
      series_types: {}


    - name: query_allocation_column
      title: "Query by Source"
      type: looker_column
      explore: history
      dimensions: [history.created_date, history.source]
      pivots: [history.source]
      measures: [history.query_run_count]
      filters:
        history.source: -'Other', -'Suggest Filter'
      listen:
        user_name: user.name
        date: history.created_date
        is_looker: user.is_looker
      sorts: [history.created_date]
      total: false
      stacking: normal
      show_view_names: false
      colors: ["#8a7d9c", "#F6989D", "#7BCDC8", "#C4DF9B", "#7EA7D8", "#B4D1B6", "#9c947d"]
      limit: 500
      series_labels:
        'Dashboard': Dashboard Queries
        'Explore': Explore Queries
        'Scheduled Task': Scheduled Task Queries
        'Saved Look': Saved Look Queries
        'SQL Runner': SQL Runner Queries
        'Private Embed': Private Embed Queries
        'Public Embed': Public Embed Queries
      x_axis_scale: auto
      x_axis_label_rotation: -45
      legend_align:

    - name: look_who_is_asking
      title: "Top Users, Last 30 Days"
      type: table
      explore: history
      dimensions: [user.name]
      measures: [history.approximate_usage_in_minutes, history.query_run_count]
      sorts: [history.approximate_usage_in_minutes DESC]
      filters:
        history.created_date: 30 days
        history.source: -'scheduled_task'
      listen:
        is_looker: user.is_looker
      limit: 10
      x_axis_scale: auto
      show_view_names: false
      x_axis_label_rotation: -45

    - name: active_users
      title: "Active Users Per Day (Last 2 Weeks)"
      type: looker_column
      explore: history
      dimensions: [history.created_date]
      measures: [user.count]
      limit: 500
      sorts: [history.created_date]
      legend_align:
      stacking:
      x_axis_label:
      x_axis_label_rotation: -45
      y_axis_labels: "# of Users"
      filters:
        history.created_date: last 14 days
      listen:
        is_looker: user.is_looker
      reference_lines:
      - value: [median]
        label: Median
        color: black
      colors: ["#8a7d9c"]

    - name: top_looks
      title: "List of Top Looks"
      type: table
      explore: history
      dimensions: [user.name, look.created_date, look.title, look.link]
      measures: [history.query_run_count, history.average_runtime]
      filters:
        look.created_date: -null
        user.name: -null
        history.created_date: last 90 days
      sorts: [history.query_run_count desc]
      limit: 10

    - name: scheduled_plan_performance
      title: "Scheduled Plans Performance"
      type: table
      explore: scheduled_plan
      dimensions: [scheduled_plan.id, user.name, scheduled_plan.cron_schedule, scheduled_plan.content_link,
        scheduled_plan.look_id, scheduled_plan.lookml_dashboard_id, scheduled_plan.dashboard_id,
        scheduled_job.scheduled_plan_id]
      measures: [scheduled_job_stage.avg_runtime, scheduled_job.count]
      hidden_fields: [scheduled_plan.lookml_dashboard_id, scheduled_plan.look_id, scheduled_plan.dashboard_id,
        scheduled_job.scheduled_plan_id]
      filters:
        scheduled_job_stage.stage: execute
      listen:
        is_looker: user.is_looker
        date: scheduled_job.created_time
      sorts: [scheduled_job_stage.avg_runtime desc]
      limit: 10
      column_limit: 50
      show_view_names: true
      show_row_numbers: true
      truncate_column_names: false
      table_theme: editable
      limit_displayed_rows: false

    - name: scheduled_plan_status
      title: Scheduled Plan Status
      type: table
      explore: scheduled_plan
      dimensions: [scheduled_plan.id, user.name, scheduled_plan.cron_schedule, scheduled_plan.content_link,
        scheduled_plan.look_id, scheduled_plan.lookml_dashboard_id, scheduled_plan.dashboard_id,
        scheduled_job.scheduled_plan_id, scheduled_job.status]
      pivots: [scheduled_job.status]
      measures: [scheduled_job.count]
      hidden_fields: [scheduled_plan.lookml_dashboard_id, scheduled_plan.look_id, scheduled_plan.dashboard_id,
        scheduled_job.scheduled_plan_id]
      filters:
        scheduled_job_stage.stage: execute
      listen:
        is_looker: user.is_looker
        date: scheduled_job.created_time
      sorts: [scheduled_job.count desc]
      limit: 10
      column_limit: 50
      total: true
      row_total: right
      show_view_names: true
      show_row_numbers: true
      truncate_column_names: false
      table_theme: editable
      limit_displayed_rows: false

    - name: public_looks
      title: "List of Public Looks"
      type: table
      explore: look
      dimensions: [look.title, look.link, query.view, user.name, query.formatted_fields]
      filters:
        look.public: 'yes'
      listen:
        is_looker: user.is_looker
      sorts: [user.name]
      limit: 10

    - name: query_runtime_performance
      type: table
      explore: history
      dimensions: [query.model, query.view]
      pivots: [history.runtime_tiers]
      measures: [history.query_run_count, user.count]
      filters:
        query.model: "-empty"
        history.runtime: 'NOT NULL'
      listen:
        user_name: user.name
        date: history.created_date
        is_looker: user.is_looker
      sorts: [query.model, query.view] #history.query_run_count desc]
      limit: 10

    - name: commonly_used_fields
      title: Commonly Used Fields
      type: table
      explore: field_usage
      dimensions: [field_usage.model, field_usage.base_view, field_usage.field, field_usage.times_used]
      sorts: [field_usage.times_used desc]
      show_view_names: false
      limit: 10
