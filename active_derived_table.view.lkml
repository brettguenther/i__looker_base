view: active_derived_table {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: cache_value {
    sql: ${TABLE}.CACHE_VALUE ;;
  }

  dimension: dead_at {
    type: number
    sql: ${TABLE}.DEAD_AT ;;
  }

  dimension: min_reap_at {
    type: number
    sql: ${TABLE}.MIN_REAP_AT ;;
  }

  dimension: key {
    sql: ${TABLE}.KEY ;;
  }

  dimension: structure {
    sql: ${TABLE}.STRUCTURE ;;
  }

  dimension: mode {
    type: number
    sql: ${TABLE}.MODE ;;
  }

  dimension: name {
    sql: ${TABLE}.NAME ;;
  }

  dimension: connection {
    sql: ${TABLE}.CONNECTION ;;
  }

  dimension: trigger_at {
    type: number
    sql: ${TABLE}.TRIGGER_AT ;;
  }

  dimension: trigger_duration {
    type: number
    sql: ${TABLE}.TRIGGER_DURATION ;;
  }

  dimension: trigger_error {
    sql: ${TABLE}.TRIGGER_ERROR ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
