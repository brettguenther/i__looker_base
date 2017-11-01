view: credentials_looker_openid {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: email {
    sql: ${TABLE}.EMAIL ;;
  }

  dimension_group: last_login {
    type: time
    sql: ${TABLE}.LAST_LOGIN_AT ;;
  }

  dimension: last_login_ip {
    sql: ${TABLE}.LAST_LOGIN_IP ;;
  }

  dimension: secret {
    sql: ${TABLE}.SECRET ;;
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
