view: scheduled_job_stage {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: completed {
    type: time
    sql: ${TABLE}.completed_at ;;
  }

  dimension: node_id {
    type: number
    # hidden: true
    sql: ${TABLE}.node_id ;;
  }

  dimension: scheduled_job_id {
    type: number
    # hidden: true
    sql: ${TABLE}.scheduled_job_id ;;
  }

  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }

  dimension_group: started {
    type: time
    sql: ${TABLE}.started_at ;;
  }

  dimension: runtime {
    type: number
    sql: TIMESTAMPDIFF(SQL_TSI_SECOND, ${TABLE}.started_at, ${TABLE}.completed_at) ;;
  }

  measure: avg_runtime {
    type: number
    sql: AVG(TIMESTAMPDIFF(SQL_TSI_SECOND, ${TABLE}.started_at, ${TABLE}.completed_at))
      ;;
  }

  measure: count {
    type: count
    drill_fields: [id, scheduled_job.id, scheduled_job.name, node.id, node.hostname]
  }
}
