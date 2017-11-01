view: cache_index {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension_group: cache {
    type: time
    sql: ${TABLE}.CACHE_TIME ;;
  }

  dimension: encrypted {
    type: yesno
    sql: ${TABLE}.ENCRYPTED ;;
  }

  dimension_group: expiration {
    type: time
    sql: ${TABLE}.EXPIRATION ;;
  }

  dimension: hash {
    sql: ${TABLE}.HASH ;;
  }

  dimension_group: last_touched {
    type: time
    sql: ${TABLE}.LAST_TOUCHED_AT ;;
  }

  dimension: node_id {
    type: number
    # hidden: true
    sql: ${TABLE}.NODE_ID ;;
  }

  dimension: time_to_live_without_touch {
    type: number
    sql: ${TABLE}.TIME_TO_LIVE_WITHOUT_TOUCH ;;
  }

  measure: count {
    type: count
    drill_fields: [id, node.hostname, node.id]
  }
}
