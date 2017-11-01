view: mail_job {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: attachment_file {
    sql: ${TABLE}.ATTACHMENT_FILE ;;
  }

  dimension: attachment_file_name {
    sql: ${TABLE}.ATTACHMENT_FILE_NAME ;;
  }

  dimension: attempts {
    type: number
    sql: ${TABLE}.ATTEMPTS ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: hash {
    sql: ${TABLE}.HASH ;;
  }

  dimension: html_body {
    sql: ${TABLE}.HTML_BODY ;;
  }

  dimension_group: last_attempted {
    type: time
    sql: ${TABLE}.LAST_ATTEMPTED_AT ;;
  }

  dimension: raw {
    sql: ${TABLE}.RAW ;;
  }

  dimension: reply_to {
    sql: ${TABLE}.REPLY_TO ;;
  }

  dimension: subject {
    sql: ${TABLE}.SUBJECT ;;
  }

  dimension: to {
    sql: ${TABLE}.TO ;;
  }

  dimension: type {
    sql: ${TABLE}.TYPE ;;
  }

  measure: count {
    type: count
    drill_fields: [id, attachment_file_name]
  }
}
