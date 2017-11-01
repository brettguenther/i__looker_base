include: "event_attribute.view"

view: support_access_event_attribute {
  sql_table_name: event_attribute ;;
  extends: [event_attribute]

  dimension: login_purpose {
    label: "Login Purpose"
    type: string
    sql: ${TABLE}.VALUE ;;
  }
}
