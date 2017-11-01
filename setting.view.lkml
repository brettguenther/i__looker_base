view: setting {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: key {
    sql: ${TABLE}.KEY ;;
  }

  dimension: value {
    sql: ${TABLE}.VALUE ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
