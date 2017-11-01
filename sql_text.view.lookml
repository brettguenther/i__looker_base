- view: sql_text
  sql_table_name: sql_text 
  fields:

  - dimension: id
    primary_key: true
    type: number
    hidden: true
    sql: |
      ${TABLE}.ID

  - dimension: cache_key
    type: string
    hidden: true
    sql: |
      ${TABLE}.CACHE_KEY

  - dimension: text
    label: 'SQL Text'
    view_label: 'Query'
    type: string
    sql: |
       SUBSTR(${TABLE}.TEXT, INSTR(${TABLE}.TEXT, 'SELECT'), LENGTH(${TABLE}.TEXT))

  - measure: count
    hidden: true 
    type: count
    drill_fields: [id]

 
