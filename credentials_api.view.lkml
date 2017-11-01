view: credentials_api {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension_group: last_request {
    type: time
    sql: ${TABLE}.LAST_REQUEST_AT ;;
  }

  dimension: secret {
    sql: ${TABLE}.SECRET ;;
  }

  dimension: token {
    sql: ${TABLE}.TOKEN ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: is_api_1_user {
    type: yesno
    sql: ${id} IS NOT NULL ;;
  }

  measure: count {
    type: count
    drill_fields: [id, user.last_name, user.first_name, user.dev_mode_user_id]
  }
}
