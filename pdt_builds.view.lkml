# - explore: pdt_builds
view: pdt_builds {
  derived_table: {
    sql: SELECT tid
        , connection
        , view_name
        , UPPER(table_name) as table_name
        , MAX(at) as end_at
        , MIN(at) as began_at
        , SUBSTRING(MAX(
            CASE action
              WHEN 'create begin' THEN '00-waiting dependencies'
              WHEN 'create ready' THEN '01-in process'
              WHEN 'create complete' THEN '02-done'
              ELSE CONCAT('01-',action) -- "create index error" or "create sql error"
            END), 4) as status
        FROM pdt_event_log
        WHERE action LIKE 'create%'
        GROUP BY tid
       ;;
  }

  dimension: connection {}
  dimension: view_name {}
  dimension: status {}
  dimension: table_name {}

  dimension: tid {
    sql: SUBSTRING(tid, 1, 8) ;;
  }

  dimension_group: began {
    type: time
    sql: began_at ;;
    datatype: epoch
    convert_tz: no
  }

  dimension: elapsed_minutes {
    type: number
    value_format_name: decimal_2
    sql: CASE WHEN status LIKE 'done' THEN (end_at - began_at) / 60.0 ELSE NULL END ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [view_name, table_name, elapsed_minutes]
  }
}
