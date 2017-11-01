view: schema_migrations {
  dimension: filename {
    sql: ${TABLE}.FILENAME ;;
  }

  measure: count {
    type: count
    drill_fields: [filename]
  }
}
