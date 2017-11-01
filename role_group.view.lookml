
- view: role_group

  fields:
  - measure: count
    type: count

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.ID

  - dimension: group_id
    type: number
    sql: ${TABLE}.GROUP_ID

  - dimension: role_id
    type: number
    sql: ${TABLE}.ROLE_ID
