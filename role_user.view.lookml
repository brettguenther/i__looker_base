- view: role_user
  fields:

  - dimension: id
    primary_key: true
    type: number
    hidden: true
    sql: ${TABLE}.ID

  - dimension: role_id
    type: number
    hidden: true
    sql: ${TABLE}.ROLE_ID

  - dimension: user_id
    type: number
    hidden: true
    sql: ${TABLE}.USER_ID

  - measure: count
    type: count
    drill_fields: detail*


  # ----- Sets of fields for drilling ------
  sets:
    detail:
    - id
    - role.name
    - role.id
    - user.last_name
    - user.first_name
    - user.dev_mode_user_id
