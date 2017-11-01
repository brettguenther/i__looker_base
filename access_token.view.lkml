view: access_token {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: credentials_api3_id {
    type: number
    # hidden: true
    sql: ${TABLE}.CREDENTIALS_API3_ID ;;
  }

  dimension: encrypted_code {
    sql: ${TABLE}.ENCRYPTED_CODE ;;
  }

  dimension: encrypted_token {
    sql: ${TABLE}.ENCRYPTED_TOKEN ;;
  }

  dimension_group: expires {
    type: time
    sql: ${TABLE}.EXPIRES_AT ;;
  }

  dimension: grant_type {
    sql: ${TABLE}.GRANT_TYPE ;;
  }

  dimension: resource_owner_id {
    type: number
    sql: ${TABLE}.RESOURCE_OWNER_ID ;;
  }

  dimension: role_id {
    type: number
    # hidden: true
    sql: ${TABLE}.ROLE_ID ;;
  }

  dimension: session_id {
    type: number
    # hidden: true
    sql: ${TABLE}.SESSION_ID ;;
  }

  dimension: user_id {
    type: number
    # hidden: true
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
      user.last_name,
      user.first_name,
      user.dev_mode_user_id,
      role.name,
      role.id,
      session.id,
      credentials_api3.id,
      session.count
    ]
  }
}
