view: space {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: creator_id {
    type: number
    sql: ${TABLE}.CREATOR_ID ;;
  }

  dimension_group: deleted {
    type: time
    sql: ${TABLE}.DELETED_AT ;;
  }

  dimension: is_personal {
    type: yesno
    sql: ${TABLE}.IS_PERSONAL ;;
  }

  dimension: name {
    sql: ${TABLE}.NAME ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, dashboard.count, look.count, space_user.count]
  }
}
