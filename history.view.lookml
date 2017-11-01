- view: history
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.ID
    links:
    - label: Show in Admin
      url: /admin/queries/{{value}}

  - dimension: runtime
    label: Runtime in Seconds
    type: number
    sql: ${TABLE}.RUNTIME
    value_format: 0.###

  - dimension: runtime_tiers
    label: Runtime Tiers in Seconds
    type: tier
    tiers: [0,5,10,30,120,300]
    sql: ${runtime}
    style: integer

  - dimension: is_user_dashboard
    type: yesno
    sql: ${dashboard.id} IS NOT NULL

  - dimension: source
    sql_case:
      'API 3.0': ${TABLE}.source = 'api3'
      'Dashboard': ${TABLE}.source = 'dashboard' or ${TABLE}.source = 'run_async'
      'Dashboard Prefetch': ${TABLE}.source = 'dashboard_prefetch'
      'Explore': ${TABLE}.source = 'explore'
      'Private Embed': ${TABLE}.source = 'private_embed' or ${TABLE}.source = 'private_url'
      'Public Embed': ${TABLE}.source = 'public_embed' or ${TABLE}.source = 'public_url'
      'Scheduled Task': ${TABLE}.source = 'scheduled_task'
      'Saved Look': ${TABLE}.source like 'look%'
      'SQL Runner': ${TABLE}.source = 'sqlrunner'
      'Suggest Filter': ${TABLE}.source = 'suggest'
      'Query': ${TABLE}.source = 'query'
      'Renderer': ${TABLE}.source like 'render_manager%'
      'Other': True
    alpha_sort: true

  - dimension: raw_source
    sql: ${TABLE}.source
    hidden: true

  - dimension: node_id
    type: number
    sql: ${TABLE}.node_id

  - dimension: status
    sql: ${TABLE}.status

  - dimension: slug
    sql: ${TABLE}.slug

  - dimension: cache_key
    sql: ${TABLE}.cache_key

  - dimension: result_source
    sql: ${TABLE}.result_source

  - dimension: message
    sql: ${TABLE}.message

  - dimension: connection_name
    sql: ${TABLE}.connection_name

  - dimension: connection_id
    sql: ${TABLE}.connection_id

  - dimension: dialect
    sql: ${TABLE}.dialect

  - dimension: most_recent_length
    label: Most Recent Run Length in Seconds
    type: number
    sql: |
      (SELECT max_created.runtime
        FROM (SELECT query_id, runtime
              FROM history h,
                  (SELECT query_id
                  ,MAX(created_at) as max_created
                  from history
                  group by query_id) as hi
              where h.query_id = hi.query_id and h.created_at = hi.max_created
              and runtime is not null) as max_created
        WHERE ${TABLE}.query_id = max_created.query_id)
    value_format: 0.###

  - dimension_group: most_recent_run_at
    label: Most Recent Query Run at
    type: time
    sql: |
      (SELECT max_created
      FROM
        (SELECT query_id
        ,MAX(created_at) as max_created
        from history
        group by query_id) as hi
      where ${TABLE}.query_id = hi.query_id)

  - measure: query_run_count
    description: 'This field is best used in conjunction with a filter or pivot on history source.'
    label: Query Run Count
    type: count
    drill_fields: drill_for_dash*

  - dimension_group: created
    type: time
    sql: ${TABLE}.CREATED_AT

  - dimension: look_id
    type: number
    hidden: true
    sql: ${TABLE}.LOOK_ID

  - dimension: query_id
    type: number
    hidden: true
    sql: ${TABLE}.QUERY_ID

  - dimension: title
    sql: ${TABLE}.TITLE

  - dimension: user_id
    type: number
    hidden: true
    sql: ${TABLE}.USER_ID

  - dimension: dashboard_id
    type: number
    hidden: true
    sql: ${TABLE}.dashboard_id

  - dimension: real_dash_id
    view_label: 'Dashboard'
    label: 'Id'
    description: 'Includes both user defined dashboards and LookML dashboards'
    type: string
    sql: |
      COALESCE(${dashboard_id}, {% if _dialect._name == 'hypersql' %} CONVERT(${dashboard.id}, SQL_VARCHAR) {% else %} CAST(${dashboard.id} AS CHAR(256)) {% endif %})

  - dimension: dashboard_session

  - measure: first_query_date
    type: date
    sql: MIN(${TABLE}.CREATED_AT)

  - measure: most_recent_query_date
    type: date
    sql: MAX(${TABLE}.CREATED_AT)

  - measure: total_runtime
    type: sum
    sql: ${runtime}

  - measure: max_runtime
    type: max
    sql: ${runtime}

  - measure: min_runtime
    type: min
    sql: ${runtime}

  - measure: average_runtime
    type: average
    sql: NULLIF(${runtime},0)
    value_format_name: decimal_2

  - measure: approximate_usage_in_minutes
    label: 'Approximate Web Usage in Minutes'
    type: number
    sql: |
        COUNT(DISTINCT
          CASE WHEN ${TABLE}.source <> 'scheduled_task' THEN
            CONCAT(
             CAST(${TABLE}.user_id as CHAR(30)),
             FLOOR(UNIX_TIMESTAMP(${TABLE}.created_at)/(60*5))
          )
          ELSE NULL
          END
        )*5



  # ----- Detail ------
  sets:
    drill_for_dash:
    - history.id
    - history.created_time
    - user.name
    - query.model
    - query.view
    - history.source
    - query.formatted_fields
    - query.formatted_pivots
    - query.formatted_filters
    - query.limit
    - history.runtime

    user_dash_drill_fields:
    - history.created_time
    - dashboard.title
    - user.name
    - history.runtime

    drill_fields:
    - history.id
    - history.created_time
#     - user_email.email
    - user.email
    - query.model
    - query.view
    - query.formatted_fields
    - query.formatted_filters
    - query.limit
    - history.runtime

- view: dashboard_history_stats

  derived_table:
    sql: |
      SELECT dashboard_session, dashboard_id, COUNT(*) as total_queries, SUM(runtime) as total_runtime, MIN(runtime) as min_runtime, MAX(runtime) as max_runtime FROM history
        WHERE dashboard_session IS NOT NULL
        GROUP BY dashboard_session, dashboard_id

  fields:

  - dimension: dashboard_id
    type: number
    hidden: true
    sql: ${TABLE}.dashboard_id

  - dimension: real_dash_id
    view_label: 'Dashboard'
    label: 'Id'
    hidden: true
    type: string
    sql: |
      COALESCE(${dashboard_id}, {% if _dialect._name == 'hypersql' %} CONVERT(${dashboard.id}, SQL_VARCHAR) {% else %} CAST(${dashboard.id} AS CHAR(256)) {% endif %})

  - dimension: dashboard_session

  - dimension: max_runtime
    type: number

  - dimension: min_runtime
    type: number

  - dimension: total_queries

  - dimension: total_runtime

  - measure: avg_runtime
    sql: SUM(${total_runtime}) / SUM(${total_queries})

