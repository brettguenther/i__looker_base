view: scheduled_job {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: crontab {
    type: string
    sql: ${TABLE}.crontab ;;
  }

  dimension: dashboard_id {
    type: number
    # hidden: true
    sql: ${TABLE}.dashboard_id ;;
  }

  dimension: data_signature {
    type: string
    sql: ${TABLE}.data_signature ;;
  }

  dimension: data_slug {
    type: string
    sql: ${TABLE}.data_slug ;;
  }

  dimension_group: finalized {
    type: time
    sql: ${TABLE}.finalized_at ;;
  }

  dimension: look_id {
    type: number
    # hidden: true
    sql: ${TABLE}.look_id ;;
  }

  dimension: lookml_dashboard_id {
    type: string
    sql: ${TABLE}.lookml_dashboard_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: require_change {
    type: yesno
    sql: ${TABLE}.require_change ;;
  }

  dimension: require_no_results {
    type: yesno
    sql: ${TABLE}.require_no_results ;;
  }

  dimension: require_results {
    type: yesno
    sql: ${TABLE}.require_results ;;
  }

  dimension: include_links {
    type: yesno
    sql: ${TABLE}.include_links ;;
  }

  dimension: row_limit_reached {
    type: yesno
    sql: ${TABLE}.row_limit_reached ;;
  }

  dimension: scheduled_plan_id {
    type: number
    # hidden: true
    sql: ${TABLE}.scheduled_plan_id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: status_detail {
    type: string
    sql: ${TABLE}.status_detail ;;
  }

  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
  }

  dimension: user_id {
    type: number
    # hidden: true
    sql: ${TABLE}.user_id ;;
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
      scheduled_plan.id,
      scheduled_plan.name,
      user.first_name,
      user.last_name,
      user.dev_mode_user_id,
      user.dev_branch_name,
      look.id,
      dashboard.id,
      scheduled_job_destination.count,
      scheduled_job_stage.count
    ]
  }
}

view: scheduled_job_most_recent {
  derived_table: {
    sql: SELECT
        created_at,
        scheduled_plan_id,
        data_signature,
        data_slug,
        finalized_at,
        status,
        status_detail
      FROM scheduled_job sj
      WHERE created_at =
        (SELECT MAX(created_at)
           FROM scheduled_job sj2
          WHERE sj.scheduled_plan_id=sj2.scheduled_plan_id
           GROUP BY scheduled_plan_id)
       ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: scheduled_plan_id {
    type: number
    # hidden: true
    sql: ${TABLE}.scheduled_plan_id ;;
  }

  dimension: data_signature {
    type: string
    sql: ${TABLE}.data_signature ;;
  }

  dimension: data_slug {
    type: string
    sql: ${TABLE}.data_slug ;;
  }

  dimension_group: finalized {
    type: time
    sql: ${TABLE}.finalized_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: status_detail {
    type: string
    sql: ${TABLE}.status_detail ;;
  }
}
