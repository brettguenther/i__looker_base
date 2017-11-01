view: user_direct_role {
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

  dimension: role_id {
    type: number
    sql: ${TABLE}.ROLE_ID ;;
  }
}
