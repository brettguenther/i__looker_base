view: thumbnail_image {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;

    link: {
      label: "View Content"
      url: "{{ content_url._value }}
      "
    }

    link: {
      label: "View Image"
      url: "{{ image_url._value }}
      "
    }

    link: {
      label: "View Debug JSON"
      url: "{{ debug_url._value }}
      "
    }
  }

  dimension: age {
    type: number
    #X# expression:"diff_minutes(${thumbnail_image.processing_finished_raw}, now())"
    value_format: "#,##0\" min\""
  }

  dimension: key {}

  dimension: last_rendering_user_id {
    type: number
    hidden: yes
  }

  dimension: view_count {
    type: number
  }

  dimension: age_tier {
    type: tier
    tiers: [
      0,
      5,
      10,
      15,
      30,
      60,
      120,
      720,
      1440,
      2880
    ]
    sql: ${age} ;;
    style: integer
  }

  dimension: content_type {
    case: {
      when: {
        sql: ${TABLE}.look_id is not null ;;
        label: "Look"
      }

      when: {
        sql: ${TABLE}.dashboard_id is not null ;;
        label: "Dashboard"
      }

      when: {
        sql: ${TABLE}.lookml_dashboard_id is not null ;;
        label: "LookML Dashboard"
      }
    }
  }

  dimension: image {
    sql: ${image_url} ;;
    html: <a href="{{ link }}" target="_self">
        <img src="{{ value }}" style="max-width: 100px;height:auto;">
      </a>
      ;;

      link: {
        label: "View Content"
        url: "{{ content_url._value }}
        "
      }

      link: {
        label: "View Image"
        url: "{{ image_url._value }}
        "
      }

      link: {
        label: "View Debug JSON"
        url: "{{ debug_url._value }}
        "
      }
    }

    dimension: image_url {
      sql: CASE
          WHEN ${look_id} is not null THEN
            CONCAT('/api/internal/thumbnail_images/look/', ${look_id})
          WHEN ${dashboard_id} is not null THEN
            CONCAT('/api/internal/thumbnail_images/dashboard/', ${dashboard_id})
          WHEN ${lookml_dashboard_id} is not null THEN
            CONCAT('/api/internal/thumbnail_images/dashboard/', ${lookml_dashboard_id})
          ELSE
            NULL
        END
         ;;
    }

    dimension: content_url {
      sql: CASE
          WHEN ${look_id} is not null THEN
            CONCAT('/looks/', ${look_id})
          WHEN ${dashboard_id} is not null THEN
            CONCAT('/dashboards/', ${dashboard_id})
          WHEN ${lookml_dashboard_id} is not null THEN
            CONCAT('/dashboards/', ${lookml_dashboard_id})
          ELSE
            NULL
        END
         ;;
    }

    dimension: debug_url {
      sql: CONCAT(${image_url}, '/json') ;;
    }

    dimension: run_status {
      case: {
        when: {
          sql: ${rendering_started_raw} is not null ;;
          label: "rendering"
        }

        when: {
          sql: ${processing_started_raw} is not null ;;
          label: "enqueued"
        }

        when: {
          sql: ${scheduled_raw} is not null ;;
          label: "scheduled"
        }

        when: {
          sql: 1 = 1 ;;
          label: "resting"
        }
      }
    }

    dimension: should_have_image {
      type: yesno
      sql: ${processing_finished_raw} is not null AND ${error_message} is null ;;
    }

    dimension: dashboard_id {
      type: number
      # hidden: yes
      sql: ${TABLE}.DASHBOARD_ID ;;
    }

    dimension: error_message {
      type: string
      sql: ${TABLE}.ERROR_MESSAGE ;;
      description: "Not cleared until the thumbnail renders successfully."
    }

    dimension: errored {
      type: yesno
      sql: ${error_message} is not null ;;
      description: "Not changed until the thumbnail renders successfully."
    }

    dimension: last_total_duration {
      type: number
      sql: ${TABLE}.LAST_DURATION ;;
      value_format: "#.0\" seconds\""
    }

    dimension: last_render_duration {
      type: number
      sql: ${TABLE}.LAST_RENDER_DURATION ;;
      value_format: "#.0\" seconds\""
    }

    dimension: last_queue_duration {
      type: number
      sql: ${TABLE}.LAST_QUEUE_DURATION ;;
      value_format: "#.0\" seconds\""
    }

    dimension: look_id {
      type: number
      # hidden: yes
      sql: ${TABLE}.LOOK_ID ;;
    }

    dimension: lookml_dashboard_id {
      type: string
      sql: ${TABLE}.LOOKML_DASHBOARD_ID ;;
    }

    dimension_group: processing_finished {
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year,
        minute,
        minute2,
        minute5,
        hour,
        hour_of_day,
        day_of_week
      ]
      sql: ${TABLE}.PROCESSING_FINISHED_AT ;;
      description: "Sticks around until the thumbnail re-renders (so this is also the freshness of the thumbnail)"
    }

    dimension_group: processing_started {
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year,
        minute,
        minute2,
        minute5,
        hour,
        hour_of_day,
        day_of_week
      ]
      sql: ${TABLE}.PROCESSING_STARTED_AT ;;
    }

    dimension_group: rendering_started {
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year,
        minute,
        minute2,
        minute5,
        hour,
        hour_of_day,
        day_of_week
      ]
      sql: ${TABLE}.RENDERING_STARTED_AT ;;
    }

    dimension_group: scheduled {
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year,
        minute,
        minute2,
        minute5,
        hour,
        hour_of_day,
        day_of_week
      ]
      sql: ${TABLE}.SCHEDULED_AT ;;
    }

    dimension_group: last_viewed {
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year,
        minute,
        minute2,
        minute5,
        hour,
        hour_of_day,
        day_of_week
      ]
      sql: ${TABLE}.LAST_VIEWED_AT ;;
    }

    dimension: user_id {
      type: number
      # hidden: yes
      sql: ${TABLE}.USER_ID ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    measure: count_with_image {
      type: count
      drill_fields: [detail*]

      filters: {
        field: should_have_image
        value: "Yes"
      }
    }

    measure: count_without_image {
      type: count
      drill_fields: [detail*]

      filters: {
        field: should_have_image
        value: "No"
      }
    }

    measure: average_total_duration {
      type: average
      sql: ${last_total_duration} ;;
      drill_fields: [detail*]
      value_format: "#.0\" seconds\""
    }

    measure: average_render_duration {
      type: average
      sql: ${last_render_duration} ;;
      drill_fields: [detail*]
      value_format: "#.0\" seconds\""
    }

    measure: average_queue_duration {
      type: average
      sql: ${last_queue_duration} ;;
      drill_fields: [detail*]
      value_format: "#.0\" seconds\""
    }

    measure: average_view_count {
      type: average
      sql: ${view_count} ;;
      drill_fields: [detail*]
    }

    # ----- Sets of fields for drilling ------
    set: detail {
      fields: [
        id,
        image,
        should_have_image,
        run_status,
        scheduled_time,
        processing_started_time,
        rendering_started_time,
        processing_finished_time,
        error_message
      ]
    }
  }
