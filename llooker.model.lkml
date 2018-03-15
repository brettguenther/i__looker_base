connection: "bg_looker_app_db"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: support_access_event {
  extension: required
  view_name: support_access_event

  join: user {
    foreign_key: user_id
  }

  join: support_access_admin {
    type: left_outer
    sql_on: ${support_access_event.user_id} = ${support_access_admin.id} ;;
    relationship: many_to_one
  }

  join: support_access_event_attribute {
    type: inner
    sql_on: ${support_access_event.id} = ${support_access_event_attribute.event_id} ;;
    relationship: one_to_many
  }

  join: role_user {
    sql_on: role_user.user_id = ${user.id} ;;
    relationship: one_to_many
    fields: []
  }

  join: role {
    foreign_key: role_user.role_id
  }
}

explore: dashboard {
   extension: required
  view_name: dashboard_layout_component
  from: dashboard_layout_component
  label: "Dashboard"

  join: dashboard_layout {
    sql_on: ${dashboard_layout_component.dashboard_layout_id} = ${dashboard_layout.id}  ;;
    relationship: many_to_one
  }

  join: dashboard_element {
    sql_on: ${dashboard_layout_component.dashboard_element_id} = ${dashboard_element.id}  ;;
    relationship: many_to_one
  }

  join: dashboard {
    sql_on: ${dashboard_layout.dashboard_id} = ${dashboard.id} ;;
    relationship: many_to_one
  }

  join: space {
    sql_on: ${dashboard.space_id} = ${space.id} ;;
    relationship: one_to_one
  }

  join: user {
    sql_on: ${dashboard.user_id} = ${user.id} ;;
    relationship: one_to_one
  }

  join: role_user {
    sql_on: role_user.user_id = ${user.id} ;;
    relationship: one_to_many
    fields: []
  }

  join: role {
    foreign_key: role_user.role_id
  }

  join: look {
    foreign_key: dashboard_element.look_id
  }

  join: query {
    foreign_key: look.query_id
  }
}

explore: db_connection {
  extension: required
  fields: [ALL_FIELDS*, -user.roles]

  join: user {
    foreign_key: user_id
  }
}

explore: event {
  extension: required
  join: user {
    sql_on: ${event.user_id} = ${user.id} ;;
    relationship: many_to_one
  }

  join: role_user {
    sql_on: ${role_user.user_id} = ${user.id} ;;
    relationship: one_to_many
    fields: []
  }

  join: role {
    relationship: many_to_one
    sql_on: ${role_user.role_id} = ${role.id}  ;;
  }
}

explore: event_attribute {
  extension: required
  join: event {
    foreign_key: event_id
  }

  join: user {
    foreign_key: event.user_id
  }

  join: role_user {
    sql_on: role_user.user_id = ${user.id} ;;
    relationship: one_to_many
    fields: []
  }

  join: role {
    foreign_key: role_user.role_id
  }
}

explore: field_usage {
  extension: required
}

explore: history {
  extension: required
  join: look {
    foreign_key: look_id
  }

  join: query {
    foreign_key: query_id
  }

  join: user {
    relationship: many_to_one
    sql_on: ${history.user_id} = ${user.id} ;;
  }

  join: space {
    foreign_key: look.space_id
  }

  join: role_user {
    sql_on: history.user_id = role_user.user_id ;;
    relationship: many_to_one
    fields: []
  }

  join: user_direct_role {
    relationship: one_to_many
    sql_on: ${user.id} = ${user_direct_role.user_id} ;;
    fields: []
  }

  join: group_user {
    relationship: one_to_many
    sql_on: ${user.id} = ${group_user.user_id} ;;
    fields: []
  }

  join: group {
    relationship: one_to_many
    sql_on: ${group.id} = ${group_user.group_id} ;;
  }

  join: role_group {
    relationship: one_to_many
    sql_on: ${role_group.group_id} = ${group_user.group_id} ;;
    fields: []
  }

  join: role {
    relationship: one_to_many
    sql_on: ${role.id} = ${user_direct_role.role_id} or ${role_group.role_id} = ${role.id} ;;
  }

  join: permission_set {
    foreign_key: role.permission_set_id
  }

  join: model_set {
    foreign_key: role.model_set_id
  }

  join: dashboard {
    relationship: many_to_one
    sql_on: ${history.dashboard_id} = ${dashboard.id} ;;
    fields: [history_detail*]
  }

  join: credentials_api {
    sql_on: ${user.id} = credentials_api.user_id ;;
    relationship: many_to_one
  }

  join: credentials_api3 {
    sql_on: ${user.id} = credentials_api3.user_id ;;
    relationship: many_to_one
  }

  join: sql_text {
    sql_on: ${history.cache_key} = ${sql_text.cache_key} ;;
    relationship: many_to_one
  }
}

explore: look {
  extension: required
  fields: [ALL_FIELDS*, -user.roles]

  join: user {
    foreign_key: user_id
  }

  join: role_user {
    sql_on: role_user.user_id = ${user.id} ;;
    relationship: one_to_many
    fields: []
  }

  join: user_direct_role {
    relationship: one_to_many
    sql_on: ${user.id} = ${user_direct_role.user_id} ;;
    fields: []
  }

  join: group_user {
    relationship: one_to_many
    sql_on: ${user.id} = ${group_user.user_id} ;;
    fields: []
  }

  join: group {
    relationship: one_to_many
    sql_on: ${group.id} = ${group_user.group_id} ;;
  }

  join: role_group {
    relationship: one_to_many
    sql_on: ${role_group.group_id} = ${group_user.group_id} ;;
    fields: []
  }

  join: role {
    relationship: one_to_many
    sql_on: ${role.id} = ${user_direct_role.role_id} or ${role_group.role_id} = ${role.id} ;;
  }

  join: query {
    foreign_key: query_id
  }

  join: space {
    foreign_key: space_id
  }
}

explore: scheduled_plan {
  extension: required
  fields: [ALL_FIELDS*, -user.roles]

  conditionally_filter: {
    filters: {
      field: run_once
      value: "no"
    }

    unless: [run_once]
  }

  join: user {
    foreign_key: scheduled_plan.user_id
  }

  join: scheduled_plan_destination {
    sql_on: scheduled_plan_destination.scheduled_plan_id = scheduled_plan.id
      ;;
    relationship: one_to_many
  }

  join: look {
    foreign_key: scheduled_plan.look_id
  }

  join: dashboard {
    foreign_key: scheduled_plan.dashboard_id
  }

  join: query {
    foreign_key: look.query_id
  }

  join: scheduled_job {
    sql_on: scheduled_job.scheduled_plan_id = scheduled_plan.id
      ;;
    relationship: one_to_many
  }

  join: scheduled_job_stage {
    sql_on: ${scheduled_job.id} = scheduled_job_stage.scheduled_job_id
      ;;
    relationship: one_to_many
  }
}

explore: session {
  extension: required
  join: user {
    foreign_key: user_id
  }

  join: access_token {
    foreign_key: access_token_id
  }

  join: role {
    foreign_key: access_token.role_id
  }

  join: credentials_api3 {
    foreign_key: access_token.credentials_api3_id
  }

  join: permission_set {
    foreign_key: role.permission_set_id
  }

  join: model_set {
    foreign_key: role.model_set_id
  }
}

explore: user {
  extension: required
  join: credentials_api {
    sql_on: user.id = credentials_api.user_id ;;
    relationship: one_to_one
  }

  join: credentials_api3 {
    sql_on: user.id = credentials_api3.user_id ;;
    relationship: one_to_one
  }

  join: role_user {
    sql_on: role_user.user_id = user.id ;;
    relationship: one_to_many
    fields: []
  }

  join: embed_user {
    from: credentials_embed
    sql_on: user.id = embed_user.user_id ;;
    relationship: one_to_one
  }

  join: user_direct_role {
    relationship: one_to_many
    sql_on: ${user.id} = ${user_direct_role.user_id} ;;
    fields: []
  }

  join: group_user {
    relationship: one_to_many
    sql_on: ${user.id} = ${group_user.user_id} ;;
    fields: []
  }

  join: group {
    relationship: one_to_many
    sql_on: ${group.id} = ${group_user.group_id} ;;
  }

  join: role_group {
    relationship: one_to_many
    sql_on: ${role_group.group_id} = ${group_user.group_id} ;;
    fields: []
  }

  join: role {
    relationship: one_to_many
    sql_on: ${role.id} = ${user_direct_role.role_id} or ${role_group.role_id} = ${role.id} ;;
  }

  join: permission_set {
    foreign_key: role.permission_set_id
  }
}

explore: user_access_filter {
  extension: required
  join: user {
    foreign_key: user_id
  }

  join: role_user {
    sql_on: role_user.user_id = ${user.id} ;;
    relationship: one_to_many
    fields: []
  }

  join: role {
    foreign_key: role_user.role_id
  }
}

explore: thumbnail_image {
  extension: required
  join: dashboard {
    type: left_outer
    sql_on: ${thumbnail_image.dashboard_id} = ${dashboard.id} ;;
    relationship: many_to_one
  }

  join: look {
    type: left_outer
    sql_on: ${thumbnail_image.look_id} = ${look.id} ;;
    relationship: many_to_one
  }
}
