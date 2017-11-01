view: space_user {
  dimension: space_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SPACE_ID ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.USER_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [space.name, space.id, user.last_name, user.first_name, user.dev_mode_user_id]
  }
}
