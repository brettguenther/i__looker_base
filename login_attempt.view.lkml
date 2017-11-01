view: login_attempt {
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

  dimension: ip {
    sql: ${TABLE}.IP ;;
  }

  dimension: key {
    sql: ${TABLE}.KEY ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
