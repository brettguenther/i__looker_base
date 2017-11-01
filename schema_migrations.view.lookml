- view: schema_migrations
  fields:

  - dimension: filename
    sql: ${TABLE}.FILENAME

  - measure: count
    type: count
    drill_fields: [filename]
