view: model_set {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: built_in {
    type: yesno
    sql: ${TABLE}.BUILT_IN ;;
  }

  dimension: embed {
    type: yesno
    sql: ${TABLE}.EMBED ;;
  }

  dimension: models {
    sql: ${TABLE}.MODELS ;;
  }

  dimension: name {
    sql: ${TABLE}.NAME ;;
  }

  dimension: unlimited {
    type: yesno
    sql: ${TABLE}.UNLIMITED ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, role.count]
  }
}
