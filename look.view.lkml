view: look {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension_group: deleted {
    type: time
    sql: ${TABLE}.DELETED_AT ;;
  }

  dimension: description {
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: public {
    type: yesno
    sql: ${TABLE}.PUBLIC ;;
  }

  dimension: public_slug {
    sql: ${TABLE}.PUBLIC_SLUG ;;
  }

  dimension: query_id {
    type: number
    hidden: yes
    sql: ${TABLE}.QUERY_ID ;;
  }

  dimension: space_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SPACE_ID ;;
  }

  dimension: title {
    sql: ${TABLE}.TITLE ;;
  }

  dimension: link {
    sql: ${id} ;;
    html: [<a href="/looks/{{ value }}">Look</a>]
      ;;
  }

  dimension: public_embed_link {
    sql: ${public_slug} ;;
    html: <a href="/embed/public/{{ value }}" target="_blank">[Public Embed Link]</a>
      ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.USER_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      user.last_name,
      user.first_name,
      user.dev_mode_user_id,
      query.id,
      space.name,
      space.id,
      dashboard_element.count,
      history.count,
      scheduled_look.count,
      scheduled_task_look.count
    ]
  }
}
