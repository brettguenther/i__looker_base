view: scheduled_plan {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;

    link: {
      label: "Show in Admin"
      url: "/admin/scheduled_jobs?scheduled_plan_id={{value}}"
    }
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: cron_schedule {
    type: string
    sql: ${TABLE}.crontab ;;
  }

  dimension: dashboard_id {
    type: number
    # hidden: true
    sql: ${TABLE}.dashboard_id ;;
  }

  dimension: enabled {
    type: yesno
    sql: ${TABLE}.enabled ;;
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

  dimension: lookml_dashboard_link {
    type: string
    sql: ${TABLE}.lookml_dashboard_id ;;
    html: [<a href="/dashboards/{{ value }}">Dashboard</a>]
      ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension_group: next_run {
    alias: [scheduled_plan.next_run_at]
    type: time
    sql: FLOOR(${TABLE}.NEXT_RUN_AT) ;;
    datatype: epoch
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

  dimension: requirements {
    sql: CASE
        WHEN ${require_results} AND NOT ${require_change} THEN 'Send if query has results'
        WHEN ${require_results} AND ${require_change} THEN 'Send if query has results AND results have changed'
        WHEN ${require_change} AND NOT ${require_results} THEN 'Send if query results have changed - includes empty result sets'
        WHEN ${require_no_results} THEN 'Send if Query has No Results'
      ELSE 'Always Send'
      END
       ;;
  }

  dimension: run_once {
    type: yesno
    sql: ${TABLE}.run_once ;;
  }

  dimension: content_link {
    sql: ${TABLE}.id ;;
    html: {% if scheduled_plan.look_id._value != nil %}
        [<a href="/looks/{{ scheduled_plan.look_id._value }}">Look</a>]
      {% elsif scheduled_plan.dashboard_id._value != nil %}
        [<a href="/dashboards/{{ scheduled_plan.dashboard_id._value }}">Dashboard</a>]
      {% elsif scheduled_plan.lookml_dashboard_id._value != nil %}
        [<a href="/dashboards/{{ scheduled_plan.lookml_dashboard_id._value }}">LookML Dashboard</a>]
      {% endif %}
      ;;
  }

  dimension: space_id {
    type: number
    sql: COALESCE(${look.space_id}, ${dashboard.space_id}) ;;
  }

  dimension: space_link {
    sql: COALESCE(${look.space_id}, ${dashboard.space_id}, -1) ;;
    html: {% if value == -1 %}
        [<a href="/spaces/lookml">Space</a>]
      {% else %}
        [<a href="/spaces/{{ value }}/">Space</a>]
      {% endif %}
      ;;
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

  measure: destination_addresses {
    sql: REPLACE(GROUP_CONCAT(DISTINCT ${scheduled_plan_destination.address}), ',', ', ') ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      user.first_name,
      user.last_name,
      user.dev_mode_user_id,
      user.dev_branch_name,
      look.id,
      dashboard.id,
      scheduled_job.count,
      scheduled_plan_destination.count
    ]
  }
}
