view: user_attribute {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: edit_link {
    type: string
    sql: ${id} ;;
    html: <a href='/admin/user_attributes?userAttributeId={{value}}'>Edit</a>;;
  }

  dimension: key {
    sql: ${TABLE}.KEY ;;
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
