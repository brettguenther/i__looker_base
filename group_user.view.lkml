view: group_user {
  measure: count {
    type: count
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: group_id {
    type: number
    sql: ${TABLE}.GROUP_ID ;;
  }
}
