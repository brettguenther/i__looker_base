view: credentials_ephemeral {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension_group: expires {
    type: time
    sql: ${TABLE}.EXPIRES_AT ;;
  }

  dimension: login_used {
    type: yesno
    sql: ${TABLE}.LOGIN_USED ;;
  }

  dimension: token {
    sql: ${TABLE}.TOKEN ;;
  }

  dimension: user_id {
    type: number
    # hidden: true
    sql: ${TABLE}.USER_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [id, user.last_name, user.first_name, user.dev_mode_user_id]
  }
}
