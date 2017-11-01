view: query {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: column_limit {
    type: number
    sql: ${TABLE}.COLUMN_LIMIT ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: fields {
    hidden: yes
    sql: ${TABLE}.FIELDS ;;
  }

  dimension: formatted_fields {
    label: "Fields Used"
    sql: REPLACE (${fields}, ',', ', ') ;;
  }

  dimension: filter_config {
    sql: ${TABLE}.FILTER_CONFIG ;;
  }

  dimension: filters {
    hidden: yes
    sql: ${TABLE}.FILTERS ;;
  }

  dimension: formatted_filters {
    label: "Filters Used"
    sql: REPLACE (${filters}, ',', ', ') ;;
  }

  dimension: hash {
    sql: ${TABLE}.HASH ;;
  }

  dimension: limit {
    type: number
    sql: ${TABLE}.LIMIT ;;
  }

  dimension: link {
    sql: ${id} ;;
    html: {% if look.id._value != null %}
        [<a href="/looks/{{ look.id._value }}">Look</a>]
      {% else %}
        [<a href="/x/{{ query.slug._value }}">Query</a>]
      {% endif %}
      ;;
    required_fields: [look.id, query.model, query.view, query.slug]
  }

  #   remove required_fields once https://github.com/looker/helltool/issues/11419 is fixed

  dimension: model {
    sql: ${TABLE}.MODEL ;;
  }

  dimension: query_timezone {
    type: string
    sql: ${TABLE}.QUERY_TIMEZONE ;;
  }

  dimension: filter_expression {
    type: string
    sql: ${TABLE}.FILTER_EXPRESSION ;;
  }

  dimension: fill_fields {
    type: string
    sql: ${TABLE}.FILL_FIELDS ;;
  }

  dimension: client_id {
    type: string
    sql: ${TABLE}.CLIENT_ID ;;
  }

  dimension: pivots {
    hidden: yes
    sql: ${TABLE}.PIVOTS ;;
  }

  dimension: formatted_pivots {
    label: "Pivots Used"
    sql: REPLACE (${pivots}, ',', ', ') ;;
  }

  dimension: runtime {
    type: number
    sql: ${TABLE}.RUNTIME ;;
    value_format_name: decimal_2
  }

  dimension: runtime_tiers {
    type: tier
    sql: ${runtime} ;;
    tiers: [
      0,
      5,
      10,
      30,
      120,
      300
    ]
  }

  dimension: slug {
    sql: ${TABLE}.SLUG ;;
  }

  dimension: sorts {
    sql: ${TABLE}.SORTS ;;
  }

  dimension: total {
    type: yesno
    sql: ${TABLE}.TOTAL ;;
  }

  dimension: view {
    label: "Explore"
    sql: ${TABLE}.VIEW ;;
  }

  dimension: vis_config {
    sql: ${TABLE}.VIS_CONFIG ;;
  }

  dimension: dynamic_fields {
    label: "Table Calculations"
    type: string
    sql: ${TABLE}.DYNAMIC_FIELDS ;;
  }

  dimension: row_total {
    sql: ${TABLE}.ROW_TOTAL ;;
  }

  dimension: visible_ui_sections {
    sql: ${TABLE}.VISIBLE_UI_SECTIONS ;;
  }

  measure: first_query_at {
    sql: MIN(${TABLE}.CREATED_AT) ;;
  }

  measure: count {
    type: count
    drill_fields: [id, history.count, look.count]
  }
}
