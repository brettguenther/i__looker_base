view: credentials_google {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: domain {
    sql: ${TABLE}.DOMAIN ;;
  }

  dimension: email {
    sql: ${TABLE}.EMAIL ;;
  }

  dimension: google_user_id {
    sql: ${TABLE}.GOOGLE_USER_ID ;;
  }

  dimension_group: logged_in {
    type: time
    sql: ${TABLE}.LOGGED_IN_AT ;;
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
