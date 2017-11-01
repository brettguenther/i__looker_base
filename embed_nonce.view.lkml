view: embed_nonce {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: external_user_id {
    sql: ${TABLE}.EXTERNAL_USER_ID ;;
  }

  dimension: nonce {
    sql: ${TABLE}.NONCE ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
