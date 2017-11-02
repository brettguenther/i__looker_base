explore: pdt_log {
  extension: required
  join: table_to_view_map {
    foreign_key: table_name
  }
}

view: pdt_log {
  sql_table_name: pdt_event_log ;;
  dimension: id {}
  dimension: action {}
  dimension: action_data {}
  dimension: connection {}
  dimension: model_name {}

  dimension: sequence {
    sql: ${TABLE}.tseq ;;
  }

  dimension: view_name {
    sql: COALESCE(${TABLE}.view_name, table_to_view_map.map_view_name) ;;
    required_joins: [table_to_view_map]
  }

  dimension: table_name {
    sql: UPPER(${TABLE}.table_name) ;;
  }

  dimension: tid {
    sql: SUBSTRING(tid,1,8) ;;
  }

  dimension_group: occur {
    type: time
    sql: ${TABLE}.at ;;
    datatype: epoch
  }

  dimension_group: occur_utc_display {
    type: time
    sql: ${TABLE}.at ;;
    datatype: epoch
    convert_tz: no
  }

  dimension: short_hash {
    type: string
    sql: SUBSTRING(hash_key, 1, 8) ;;
  }

  dimension: hash {
    type: string
    sql: ${TABLE}.hash_key ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      action,
      action_data,
      connection,
      view_name,
      table_name,
      tid,
      occur_time
    ]
  }
}

# because drop table doesn't record the view name, but it is common
# to look at activity by view, we record the view so we can join it in
view: table_to_view_map {
  derived_table: {
    sql: SELECT
        UPPER(table_name) as map_table_name,
        view_name as map_view_name
      FROM pdt_event_log
      WHERE view_name is NOT NULL
      GROUP BY map_table_name,map_view_name
       ;;
  }

  dimension: map_table_name {
    primary_key: yes
    hidden: yes
  }
}
