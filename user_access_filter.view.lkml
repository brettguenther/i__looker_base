view: user_access_filter {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: dictionary {
    sql: ${TABLE}.DICTIONARY ;;
  }

  dimension: field {
    sql: ${TABLE}.FIELD ;;
  }

  dimension: user_id {
    type: number
    # hidden: true
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: value {
    sql: ${TABLE}.VALUE ;;
  }

  measure: count {
    type: count
    drill_fields: [id, user.last_name, user.first_name, user.dev_mode_user_id]
  }
}
