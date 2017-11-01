view: role_user {
  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.ID ;;
  }

  dimension: role_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ROLE_ID ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.USER_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      role.name,
      role.id,
      user.last_name,
      user.first_name,
      user.dev_mode_user_id
    ]
  }
}
