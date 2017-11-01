view: dashboard_element {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: refresh_interval {}

  dimension: dashboard_id {
    type: number
    hidden: yes
    sql: ${TABLE}.DASHBOARD_ID ;;
  }

  dimension_group: deleted {
    type: time
    sql: ${TABLE}.DELETED_AT ;;
  }

  dimension: look_id {
    type: number
    hidden: yes
    sql: ${TABLE}.LOOK_ID ;;
  }

  dimension: type {
    sql: ${TABLE}.TYPE ;;
  }

  measure: count {
    type: count
    drill_fields: [id, dashboard.id, look.id, dashboard_layout_component.count]
  }
}
