view: credentials_ldap {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: email {
    sql: ${TABLE}.EMAIL ;;
  }

  dimension: last_login_attempt_id {
    type: number
    sql: ${TABLE}.LAST_LOGIN_ATTEMPT_ID ;;
  }

  dimension: ldap_dn {
    sql: ${TABLE}.LDAP_DN ;;
  }

  dimension: ldap_id {
    sql: ${TABLE}.LDAP_ID ;;
  }

  dimension_group: logged_in {
    type: time
    sql: ${TABLE}.LOGGED_IN_AT ;;
  }

  dimension: user_id {
    type: number
    # hidden: true
    sql: ${TABLE}.USER_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [id, user.last_name, user.first_name, user.dev_mode_user_id]
  }
}
