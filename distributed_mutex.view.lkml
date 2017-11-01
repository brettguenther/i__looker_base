view: distributed_mutex {
  dimension_group: last_heartbeat {
    type: time
    sql: ${TABLE}.LAST_HEARTBEAT ;;
  }

  dimension: name {
    sql: ${TABLE}.NAME ;;
  }

  dimension: node_id {
    type: number
    # hidden: true
    sql: ${TABLE}.NODE_ID ;;
  }

  dimension: thread_id {
    type: number
    sql: ${TABLE}.THREAD_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [name, node.hostname, node.id]
  }
}
