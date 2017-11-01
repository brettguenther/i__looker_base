view: dashboard_layout_component {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: column {
    type: number
    sql: ${TABLE}.COLUMN ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: dashboard_element_id {
    type: number
    hidden: yes
    sql: ${TABLE}.DASHBOARD_ELEMENT_ID ;;
  }

  dimension: dashboard_layout_id {
    type: number
    hidden: yes
    sql: ${TABLE}.DASHBOARD_LAYOUT_ID ;;
  }

  dimension_group: deleted {
    type: time
    sql: ${TABLE}.DELETED_AT ;;
  }

  dimension: height {
    type: number
    sql: ${TABLE}.HEIGHT ;;
  }

  dimension: row {
    type: number
    sql: ${TABLE}.ROW ;;
  }

  dimension: width {
    type: number
    sql: ${TABLE}.WIDTH ;;
  }

  measure: count {
    type: count
    drill_fields: [id, dashboard_layout.id, dashboard_element.id]
  }
}
