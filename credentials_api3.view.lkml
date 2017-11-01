view: credentials_api3 {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: client_id {
    sql: ${TABLE}.CLIENT_ID ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: encrypted_client_secret {
    sql: ${TABLE}.ENCRYPTED_CLIENT_SECRET ;;
  }

  dimension_group: logged_in {
    type: time
    sql: ${TABLE}.LOGGED_IN_AT ;;
  }

  dimension: is_api_3_user {
    type: yesno
    sql: ${id} IS NOT NULL ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.USER_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [id, user.last_name, user.first_name, user.dev_mode_user_id, access_token.count]
  }
}
