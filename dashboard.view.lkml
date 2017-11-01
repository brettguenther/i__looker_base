view: dashboard {
  dimension: id {
    primary_key: yes
    type: number
    description: "Includes only user defined dashboards"
    sql: {% if _dialect._name == 'hypersql' %} CONVERT(${TABLE}.ID, SQL_VARCHAR) {% else %} CAST(${TABLE}.id AS CHAR(256)) {% endif %}
      ;;
  }

  dimension: run_on_load {
    type: yesno
    sql: ${TABLE}.load_configuration is null ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension_group: deleted {
    type: time
    sql: ${TABLE}.DELETED_AT ;;
  }

  dimension: description {
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: hidden {
    type: yesno
    sql: ${TABLE}.HIDDEN ;;
  }

  dimension: space_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SPACE_ID ;;
  }

  dimension: refresh_interval {}

  dimension: title {
    sql: ${TABLE}.TITLE ;;
    html: <a href="/dashboards/{{dashboard.id._value }}">{{value}}</a>
      ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: link {
    sql: ${id} ;;
    html: [<a href="/dashboards/{{ value }}">Dashboard</a>]
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      space.name,
      space.id,
      user.last_name,
      user.first_name,
      user.dev_mode_user_id,
      dashboard_element.count,
      dashboard_layout.count
    ]
  }

  set: history_detail {
    fields: [
      run_on_load,
      description,
      hidden,
      link,
      title,
      count,
      refresh_interval,
      created_date,
      created_day_of_month,
      created_day_of_week,
      created_day_of_week_index,
      created_hour,
      created_hour_of_day,
      created_minute,
      created_month,
      created_month_num,
      created_quarter,
      created_quarter_of_year,
      created_time,
      created_time_of_day,
      created_week,
      created_week_of_year,
      created_year,
      deleted_date,
      deleted_day_of_month,
      deleted_day_of_week,
      deleted_day_of_week_index,
      deleted_hour,
      deleted_hour_of_day,
      deleted_minute,
      deleted_month,
      deleted_month_num,
      deleted_quarter,
      deleted_quarter_of_year,
      deleted_time,
      deleted_time_of_day,
      deleted_week,
      deleted_week_of_year,
      deleted_year
    ]
  }
}
