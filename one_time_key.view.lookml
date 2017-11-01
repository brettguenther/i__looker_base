- view: one_time_key
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.ID

  - dimension_group: created
    type: time
    sql: ${TABLE}.CREATED_AT

  - dimension_group: expires
    type: time
    sql: ${TABLE}.EXPIRES_AT

  - dimension: token
    sql: ${TABLE}.TOKEN

  - measure: count
    type: count
    drill_fields: [id]
