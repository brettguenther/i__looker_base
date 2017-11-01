view: user {
  dimension: dev_mode_user_id {
    type: number
    sql: ${TABLE}.DEV_MODE_USER_ID ;;
  }

  dimension: browser_count {
    type: number
    sql: ${TABLE}.BROWSER_COUNT ;;
  }

  dimension: chat_popover {
    type: yesno
    sql: ${TABLE}.CHAT_POPOVER ;;
  }

  dimension: dev_mode {
    type: yesno
    sql: ${TABLE}.DEV_MODE ;;
  }

  dimension: email {
    sql: ${TABLE}.EMAIL ;;
  }

  dimension: first_name {
    sql: ${TABLE}.FIRST_NAME ;;
  }

  dimension: id {
    type: number
    primary_key: yes
    sql: ${TABLE}.ID ;;
  }

  dimension: edit_link {
    type: string
    sql: ${id} ;;
    html: <a href='/admin/users/{{value}}/edit'>Edit</a>;;
  }

  #   - dimension: is_admin
  #     type: yesno
  #     sql: ${TABLE}.IS_ADMIN

  dimension: is_disabled {
    type: yesno
    sql: ${TABLE}.IS_DISABLED ;;
  }

  dimension: is_looker {
    type: yesno
    sql: ${TABLE}.IS_LOOKER_EMPLOYEE OR ${email} like '%@looker.com' ;;
  }

  dimension: last_name {
    sql: ${TABLE}.LAST_NAME ;;
  }

  dimension: marketing_email_updates {
    type: yesno
    sql: ${TABLE}.MARKETING_EMAIL_UPDATES ;;
  }

  #   - dimension: models
  #     sql: ${TABLE}.MODELS

  dimension: models_dir {
    sql: ${TABLE}.MODELS_DIR ;;
  }

  dimension: name {
    sql: CONCAT (${first_name}, ' ', ${last_name}) ;;
  }

  dimension: outgoing_access_token_id {
    type: number
    sql: ${TABLE}.OUTGOING_ACCESS_TOKEN_ID ;;
  }

  dimension: release_email_updates {
    type: yesno
    sql: ${TABLE}.RELEASE_EMAIL_UPDATES ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: roles {
    type: string
    sql: GROUP_CONCAT(DISTINCT ${role.name}) ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      dev_mode_user_id,
      last_name,
      first_name,
      access_token.count,
      api_nonce.count,
      credentials_api.count,
      credentials_api3.count,
      credentials_email.count,
      credentials_embed.count,
      credentials_ephemeral.count,
      credentials_google.count,
      credentials_ldap.count,
      credentials_looker_openid.count,
      credentials_totp.count,
      dashboard.count,
      db_connection.count,
      event.count,
      history.count,
      look.count,
      role_user.count,
      scheduled_look.count,
      scheduled_look_action.count,
      scheduled_task.count,
      scheduled_task_action_email.count,
      session.count,
      space_user.count,
      user_access_filter.count,
      user_attribute.count
    ]
  }
}
