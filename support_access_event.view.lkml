include: "event.view"

view: support_access_event {
  sql_table_name: event ;;
  extends: [event]

  dimension: name {
    html: {% if value == 'support_access_disabled' %}
        <p style="color: black; background-color: #c3e5a1; margin: 0; font-size:100%; text-align:center">DISABLED</p>
      {% elsif value == 'support_access_enabled' %}
        <p style="color: black; background-color: #f9e26d; margin: 0; font-size:100%; text-align:center">ENABLED</p>
      {% endif %}
      ;;
  }

  dimension_group: login {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }
}
