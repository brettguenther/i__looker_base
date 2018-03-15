view: dashboard_filters {
  derived_table: {
    sql: SELECT
       event_attribute.value as run_session_id
       ,event_filters_json.filters_json as filters_json
         FROM (
           SELECT
             event_id
             ,CONCAT('{', GROUP_CONCAT(quoted_pair SEPARATOR ', '), '}') as filters_json
           FROM (
             SELECT
               event_id
               ,CONCAT('"', filter_name, '":"', filter_value, '"') as quoted_pair
             FROM (
               SELECT
                   event_attribute.EVENT_ID AS event_id
                   ,SUBSTRING(event_attribute.NAME, 8) AS filter_name
                   ,event_attribute.VALUE AS filter_value
               FROM event_attribute
               INNER JOIN event ON event_attribute.event_id = event.id
               WHERE
                   (event_attribute.NAME LIKE 'filter%')
                   AND
                   {% if _explore._name == "history" %}
                     {% condition history.created_date %} event.created_at {% endcondition %}
                   {% else %}
                     {% condition dashboard_performance.raw_data_timeframe %} event.created_at {% endcondition %}
                   {% endif %}
             ) clean_data
           ) make_pairs
           GROUP BY event_id
         ) event_filters_json
         LEFT JOIN event_attribute ON event_filters_json.event_id = event_attribute.event_id AND event_attribute.name = 'run_session_id'
       ;;
  }

  dimension: run_session_id {
    hidden: yes
    type: string
    sql: ${TABLE}.run_session_id ;;
  }

  dimension: filter_json {
    type: string
    sql: ${TABLE}.filters_json ;;
    html: <div style="width:200px;text-overflow:ellipsis;">{{ rendered_value }}</div>;;
  }

  measure: count_filter_combinations {
    type: count_distinct
    sql: ${filter_json} ;;
  }
}
