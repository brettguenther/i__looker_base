view: field_usage {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: explore {
    alias: [field_usage.base_view]
    sql: ${TABLE}.BASE_VIEW ;;
  }

  dimension: field {
    sql: ${TABLE}.FIELD ;;
  }

  dimension: model {
    sql: ${TABLE}.MODEL ;;
  }

  dimension: times_used {
    type: number
    sql: ${TABLE}.TIMES_USED ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
