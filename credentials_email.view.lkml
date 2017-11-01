view: credentials_email {
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

  dimension: encrypted_password {
    sql: ${TABLE}.ENCRYPTED_PASSWORD ;;
  }

  dimension: last_login_attempt_id {
    type: number
    sql: ${TABLE}.LAST_LOGIN_ATTEMPT_ID ;;
  }

  dimension_group: logged_in {
    type: time
    sql: ${TABLE}.LOGGED_IN_AT ;;
  }

  dimension_group: password_reset_sent {
    type: time
    sql: ${TABLE}.PASSWORD_RESET_SENT_AT ;;
  }

  dimension: password_reset_token {
    sql: ${TABLE}.PASSWORD_RESET_TOKEN ;;
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
