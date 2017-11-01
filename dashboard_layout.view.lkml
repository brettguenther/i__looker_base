view: dashboard_layout {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: dashboard_id {
    type: number
    hidden: yes
    sql: ${TABLE}.DASHBOARD_ID ;;
  }

  dimension_group: deleted {
    type: time
    sql: ${TABLE}.DELETED_AT ;;
  }

  dimension: type {
    sql: ${TABLE}.TYPE ;;
  }

  measure: count {
    type: count
    drill_fields: [id, dashboard.id, dashboard_layout_component.count]
  }
}
