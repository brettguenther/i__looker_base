view: sql_text {
  sql_table_name: sql_text ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.ID
      ;;
  }

  dimension: cache_key {
    type: string
    hidden: yes
    sql: ${TABLE}.CACHE_KEY
      ;;
  }

  dimension: text {
    label: "SQL Text"
    view_label: "Query"
    type: string
    sql: SUBSTR(${TABLE}.TEXT, INSTR(${TABLE}.TEXT, 'SELECT'), LENGTH(${TABLE}.TEXT))
      ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [id]
  }
}
