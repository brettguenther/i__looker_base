view: db_connection {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: edit_link {
    type: string
    sql: ${id} ;;
    html: <a href='/admin/connections/{{value}}/edit'>Edit</a>;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: database {
    sql: ${TABLE}.DATABASE ;;
  }

  dimension: db_timezone {
    sql: ${TABLE}.DB_TIMEZONE ;;
  }

  dimension: dialect {
    sql: ${TABLE}.DIALECT ;;
  }

  #   - dimension: encrypted_private_key
  #     sql: ${TABLE}.ENCRYPTED_PRIVATE_KEY

  dimension: example {
    type: yesno
    sql: ${TABLE}.EXAMPLE ;;
  }

  dimension: host {
    sql: ${TABLE}.HOST ;;
  }

  dimension: jdbc_additional_params {
    sql: ${TABLE}.JDBC_ADDITIONAL_PARAMS ;;
  }

  dimension: max_connections {
    type: number
    sql: ${TABLE}.MAX_CONNECTIONS ;;
  }

  dimension: name {
    sql: ${TABLE}.NAME ;;
  }

  #   - dimension: password
  #     sql: ${TABLE}.PASSWORD

  dimension: pool_timeout {
    type: number
    sql: ${TABLE}.POOL_TIMEOUT ;;
  }

  dimension: port {
    sql: ${TABLE}.PORT ;;
  }

  dimension: query_timezone {
    sql: ${TABLE}.QUERY_TIMEZONE ;;
  }

  dimension: schema {
    sql: ${TABLE}.SCHEMA ;;
  }

  dimension: ssh_forward {
    type: yesno
    sql: ${TABLE}.SSH_FORWARD ;;
  }

  dimension: ssh_host {
    sql: ${TABLE}.SSH_HOST ;;
  }

  dimension: ssh_port {
    type: number
    sql: ${TABLE}.SSH_PORT ;;
  }

  dimension: ssh_remote_host {
    sql: ${TABLE}.SSH_REMOTE_HOST ;;
  }

  dimension: ssh_remote_port {
    type: number
    sql: ${TABLE}.SSH_REMOTE_PORT ;;
  }

  dimension: ssh_username {
    sql: ${TABLE}.SSH_USERNAME ;;
  }

  dimension: ssl {
    type: yesno
    sql: ${TABLE}.SSL ;;
  }

  dimension: tmp_db_name {
    sql: ${TABLE}.TMP_DB_NAME ;;
  }

  dimension: user_id {
    type: number
    # hidden: true
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: username {
    sql: ${TABLE}.USERNAME ;;
  }

  dimension: verify_ssl {
    type: yesno
    sql: ${TABLE}.VERIFY_SSL ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      ssh_username,
      tmp_db_name,
      name,
      username,
      user.last_name,
      user.first_name,
      user.dev_mode_user_id
    ]
  }
}
