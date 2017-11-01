- view: event_attribute
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.ID

  - dimension: event_id
    type: number
    # hidden: true
    sql: ${TABLE}.EVENT_ID

  - dimension: name
    sql: ${TABLE}.NAME

  - dimension: value
    sql: ${TABLE}.VALUE

  - measure: count
    type: count
    drill_fields: [id, name, event.id, event.name]
