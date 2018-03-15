view: event {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: category {
    sql: ${TABLE}.CATEGORY ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: name {
    sql: ${TABLE}.NAME ;;
  }

  dimension: user_id {
    type: number
    # hidden: true
    sql: ${TABLE}.USER_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      user.last_name,
      user.first_name,
      user.dev_mode_user_id,
      event_attribute.count
    ]
  }
}

view: dashboard_page_event_stats {
  derived_table: {
    sql: SELECT
         dashboard_page_session
        ,MIN(loaded_at) AS first_event_at
        ,MAX(loaded_at) AS last_event_at
        ,MAX(controller_initialized_at) as controller_initialized_at
        ,MAX(metadata_loaded_at) as metadata_loaded_at
        ,MAX(dom_content_loaded) as dom_content_loaded
        FROM (
          SELECT
            event.created_at AS loaded_at
            ,MAX(CASE WHEN event_attribute.NAME = 'dom_content_loaded' AND event.NAME = 'dashboard.load.initialized'
                       THEN CAST(event_attribute.VALUE AS {% if _dialect._name == 'hypersql' %} FLOAT {% else %} decimal {% endif %})
                      ELSE NULL END) as dom_content_loaded

            ,MAX(CASE WHEN event_attribute.NAME = 'load_session_id' THEN event_attribute.VALUE
                      ELSE NULL END) as dashboard_page_session

            ,MAX(CASE WHEN event_attribute.NAME = 'controller_initialized_at' AND event.NAME = 'dashboard.load.initialized'
                        THEN CAST(event_attribute.VALUE AS {% if _dialect._name == 'hypersql' %} FLOAT {% else %} decimal {% endif %})
                      ELSE NULL END) as controller_initialized_at

            ,MAX(CASE WHEN event_attribute.NAME = 'metadata_loaded_at' AND event.NAME = 'dashboard.load.metadata'
                       THEN CAST(event_attribute.VALUE AS {% if _dialect._name == 'hypersql' %} FLOAT {% else %} decimal {% endif %})
                      ELSE NULL END) as metadata_loaded_at

          FROM event LEFT JOIN event_attribute
            ON event.ID = event_attribute.EVENT_ID
          WHERE event.CATEGORY = 'dashboard_performance'
            AND {% condition dashboard_performance.raw_data_timeframe %} event.created_at {% endcondition %}
          GROUP BY event.id, event.created_at
        ) aliased
        GROUP BY dashboard_page_session
       ;;
  }

  dimension: dashboard_page_session {
    primary_key: yes
    label: "_Page Session ID"
  }

  dimension_group: first_event_at {
    type: time
    label: "Page First Event"
  }

  dimension_group: last_event_at {
    type: time
    hidden: yes
  }

  dimension: seconds_until_controller_initialized {
    sql: ${TABLE}.controller_initialized_at / 1000 ;;
    value_format: "0.###"
    type: number
    hidden: yes
  }

  dimension: seconds_until_dom_content_loaded {
    sql: ${TABLE}.dom_content_loaded / 1000 ;;
    value_format: "0.###"
    type: number
    hidden: yes
  }

  dimension: seconds_until_metadata_loaded {
    sql: ${TABLE}.metadata_loaded_at / 1000 ;;
    value_format: "0.###"
    type: number
    hidden: yes
  }

  measure: average_time_to_metadata_loaded {
    label: "1) Metadata Prep"
    type: average
    value_format: "0.00"
    sql: ${seconds_until_metadata_loaded} ;;
  }

  measure: count_page_sessions {
    description: "Number of times a dashboard was opened"
    type: count_distinct
    sql: ${dashboard_page_session} ;;
  }
}

# Groups all relevant event attributes for a dashboard load together
# so they can be one-to-one joined with history stats about that dashboard load
# and aggregates will work on hypersql
view: dashboard_run_event_stats {
  derived_table: {
    sql: SELECT
         dashboard_run_session
        ,dashboard_page_session
        ,user_id
        ,MIN(ran_at) AS first_event_at
        ,MAX(ran_at) AS last_event_at
        ,MAX(dashboard_run_start) as dashboard_run_start
        ,MIN(received_at) as first_data_received_at
        ,MAX(received_at) as last_data_received_at
        ,MIN(rendered_at) as first_tile_finished_rendering
        ,MAX(rendered_at) as last_tile_finished_rendering
        ,MAX(is_allowed_cache) as is_allowed_cache
      FROM (
        SELECT
           event.created_at AS ran_at
          ,event.user_id
          ,MAX(CASE WHEN event_attribute.NAME = 'run_session_id'
                     THEN event_attribute.VALUE
                   ELSE NULL END) as dashboard_run_session

          ,MAX(CASE WHEN event_attribute.NAME = 'load_session_id'
                     THEN event_attribute.VALUE
                   ELSE NULL END) as dashboard_page_session

          ,MAX(CASE WHEN event_attribute.NAME = 'cache_run'
                     THEN event_attribute.VALUE
                   ELSE NULL END) as is_allowed_cache

          ,MAX(CASE WHEN event_attribute.NAME = 'started_at' AND event.NAME = 'dashboard.run.start'
                      THEN CAST(event_attribute.VALUE AS {% if _dialect._name == 'hypersql' %} FLOAT {% else %} decimal {% endif %})
                      ELSE NULL END) as dashboard_run_start

          ,MAX(CASE WHEN event_attribute.NAME = 'rendered_at' AND event.NAME = 'dashboard.run.data_rendered'
                      THEN CAST(event_attribute.VALUE AS {% if _dialect._name == 'hypersql' %} FLOAT {% else %} decimal {% endif %})
                    ELSE NULL END) as rendered_at

          ,MAX(CASE WHEN event_attribute.NAME = 'received_at' AND event.NAME = 'dashboard.run.data_received'
                      THEN CAST(event_attribute.VALUE AS {% if _dialect._name == 'hypersql' %} FLOAT {% else %} decimal {% endif %})
                    ELSE NULL END) as received_at

          FROM event LEFT JOIN event_attribute
            ON event.ID = event_attribute.EVENT_ID
          WHERE event.CATEGORY = 'dashboard_performance'
            AND {% condition dashboard_performance.raw_data_timeframe %} event.created_at {% endcondition %}
          GROUP BY event.id, event.created_at
      ) aliased
      WHERE dashboard_run_session IS NOT NULL
      GROUP BY dashboard_run_session, dashboard_page_session, user_id
       ;;
  }

  filter: raw_data_timeframe {
    type: date
  }

  dimension: dashboard_run_session {
    primary_key: yes
    label: "_Run Session ID"
  }

  dimension: dashboard_page_session {
    hidden: yes
  }

  dimension: user_id {
    hidden: yes
    type: number
  }

  dimension: is_force_skip_cache {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_allowed_cache != 'true' ;;
  }

  dimension: seconds_from_page_load_to_run_start {
    sql: ${TABLE}.dashboard_run_start / 1000 ;;
    value_format: "0.###"
    type: number
    hidden: yes
  }

  dimension: seconds_until_first_data_received {
    sql: (${TABLE}.first_data_received_at / 1000) - ${seconds_from_page_load_to_run_start} ;;
    value_format: "0.###"
    type: number
    hidden: yes
  }

  dimension: seconds_until_last_data_received {
    sql: (${TABLE}.last_data_received_at / 1000) - ${seconds_from_page_load_to_run_start} ;;
    value_format: "0.###"
    type: number
    hidden: yes
  }

  dimension: seconds_until_first_tile_finished_rendering {
    sql: (${TABLE}.first_tile_finished_rendering / 1000) - ${seconds_from_page_load_to_run_start} ;;
    value_format: "0.###"
    hidden: yes
    type: number
  }

  dimension: seconds_until_last_tile_finished_rendering {
    sql: (${TABLE}.last_tile_finished_rendering / 1000) - ${seconds_from_page_load_to_run_start} ;;
    value_format: "0.###"
    hidden: yes
    type: number
  }

  dimension: seconds_between_first_and_last_tile_rendering {
    value_format: "0.###"
    type: number
    sql: (${TABLE}.last_tile_finished_rendering - ${TABLE}.first_tile_finished_rendering) / 1000 ;;
    hidden: yes
  }

  dimension_group: first_event_at {
    type: time
    label: "Run First Event"
  }

  dimension_group: last_event_at {
    type: time
    hidden: yes
  }

  measure: count {
    label: "Count Runs"
    type: count
  }

  measure: average_time_until_first_data_received {
    label: "2) Time to first data"
    type: average
    sql: ${seconds_until_first_data_received} ;;
    value_format: "0.00"
    drill_fields: [detail*]
    description: "The average amount of time until data for the first query has been returned for a dashboard."
  }

  measure: average_time_until_first_tile_finished_rendering {
    label: "3) Time to first render"
    type: average
    sql: ${seconds_until_first_tile_finished_rendering} ;;
    value_format: "0.00"
    drill_fields: [detail*]
    description: "The average amount of time until the first visualization appears on the page."
  }

  measure: diff_between_first_data_and_first_render {
    label: "4) Δ first data to first render"
    type: number
    value_format: "0.00"
    sql: ${average_time_until_first_tile_finished_rendering} - ${average_time_until_first_data_received} ;;
  }

  measure: average_time_until_last_data_received {
    label: "5) Time to last data"
    type: average
    sql: ${seconds_until_last_data_received} ;;
    value_format: "0.00"
    drill_fields: [detail*]
    description: "The average amount of time until data for the last query has been returned for a dashboard."
  }

  measure: average_time_until_last_tile_finished_rendering {
    label: "6) Time to last render"
    type: average
    sql: ${seconds_until_last_tile_finished_rendering} ;;
    value_format: "0.00"
    drill_fields: [detail*]
    description: "The average amount of time until the last visualization appears on the page."
  }

  measure: aveage_time_between_first_and_last_tile_rendering {
    label: "7) Δ first render to last render"
    type: number
    sql: ${average_time_until_last_tile_finished_rendering} - ${average_time_until_first_tile_finished_rendering} ;;
    value_format: "0.00"
    drill_fields: [detail*]
    description: "The average amount of time between the first and the last visualizations appear on the page."
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      user.last_name,
      user.first_name,
      user.dev_mode_user_id,
      event_attribute.count,
      dashboard.*
    ]
  }
}
