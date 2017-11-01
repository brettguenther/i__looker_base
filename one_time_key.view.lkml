view: one_time_key {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension_group: expires {
    type: time
    sql: ${TABLE}.EXPIRES_AT ;;
  }

  dimension: token {
    sql: ${TABLE}.TOKEN ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
