view: session {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: access_token_id {
    type: number
    # hidden: true
    sql: ${TABLE}.ACCESS_TOKEN_ID ;;
  }

  dimension: browser {
    sql: ${TABLE}.BROWSER ;;
  }

  dimension: city {
    sql: ${TABLE}.CITY ;;
  }

  dimension: country {
    sql: ${TABLE}.COUNTRY ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: credentials_type {
    sql: ${TABLE}.CREDENTIALS_TYPE ;;
  }

  dimension_group: expires {
    type: time
    sql: ${TABLE}.EXPIRES_AT ;;
  }

  dimension_group: extended {
    type: time
    sql: ${TABLE}.EXTENDED_AT ;;
  }

  dimension: extended_count {
    type: number
    sql: ${TABLE}.EXTENDED_COUNT ;;
  }

  dimension: ip_address {
    sql: ${TABLE}.IP_ADDRESS ;;
  }

  dimension: operating_system {
    sql: ${TABLE}.OPERATING_SYSTEM ;;
  }

  dimension: state {
    sql: ${TABLE}.STATE ;;
  }

  dimension: sudo_url {
    sql: ${TABLE}.SUDO_URL ;;
  }

  dimension: sudo_user_id {
    type: number
    sql: ${TABLE}.SUDO_USER_ID ;;
  }

  dimension: token {
    sql: ${TABLE}.TOKEN ;;
  }

  dimension: user_id {
    type: number
    # hidden: true
    sql: ${TABLE}.USER_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      user.last_name,
      user.first_name,
      user.dev_mode_user_id,
      access_token.id,
      access_token.count
    ]
  }
}
