view: node {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: cache_port {
    sql: ${TABLE}.CACHE_PORT ;;
  }

  dimension: clustered {
    type: yesno
    sql: ${TABLE}.CLUSTERED ;;
  }

  dimension: hostname {
    sql: ${TABLE}.HOSTNAME ;;
  }

  dimension: is_master {
    type: yesno
    sql: ${TABLE}.IS_MASTER ;;
  }

  dimension_group: last_heartbeat {
    type: time
    sql: ${TABLE}.LAST_HEARTBEAT ;;
  }

  dimension: mac_adress {
    sql: ${TABLE}.MAC_ADRESS ;;
  }

  dimension: new_secret {
    sql: ${TABLE}.NEW_SECRET ;;
  }

  dimension: node_cluster_version {
    type: number
    sql: ${TABLE}.NODE_CLUSTER_VERSION ;;
  }

  dimension: node_to_node_port {
    sql: ${TABLE}.NODE_TO_NODE_PORT ;;
  }

  dimension: old_secret {
    sql: ${TABLE}.OLD_SECRET ;;
  }

  dimension: port {
    sql: ${TABLE}.PORT ;;
  }

  dimension: version {
    sql: ${TABLE}.VERSION ;;
  }

  measure: count {
    type: count
    drill_fields: [id, hostname, cache_index.count, distributed_mutex.count]
  }
}
