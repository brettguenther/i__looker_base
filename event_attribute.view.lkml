view: event_attribute {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: event_id {
    type: number
    # hidden: true
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: name {
    sql: ${TABLE}.NAME ;;
  }

  dimension: value {
    sql: ${TABLE}.VALUE ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, event.id, event.name]
  }
}
