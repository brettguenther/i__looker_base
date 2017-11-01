view: role {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: edit_link {
    type: string
    sql: ${id} ;;
    html: <a href='/admin/roles/{{value}}/edit'>Edit</a>;;
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

  dimension: permissions {
    sql: ${TABLE}.PERMISSIONS ;;
  }

  dimension: model_set_id {
    type: number
    hidden: yes
    sql: ${TABLE}.MODEL_SET_ID ;;
  }

  dimension: permission_set_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PERMISSION_SET_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      permission_set.name,
      permission_set.id,
      model_set.id,
      model_set.name,
      access_token.count,
      role_user.count
    ]
  }
}
