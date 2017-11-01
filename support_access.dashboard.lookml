- dashboard: support_audit
  title: Support Access
  layout: grid
  tile_size: 100

  elements:
    - name: support_access_audit_description
      type: text
      title_text: Support Access Audit
      body_text: |
        The "Recent Access" table below shows who from Looker has logged into
        your instance with additional detail on when and why they logged in.
        The "Changes to Support Access Settings" table shows who in your organization
        has changed the setting of the controls above to enable, extend, or
        revoke Support Access to your instance.

    - name: changes_to_support_access_settings
      title: Changes to Support Access Settings
      model: i__looker
      explore: support_access_event
      type: table
      fields: [support_access_event.name, support_access_admin.name, support_access_event.created_time]
      filters:
        support_access_event.category: support_access_toggle
      sorts: [support_access_event.created_time desc]
      limit: 500
      column_limit: 50
      query_timezone: user_timezone

    - name: recent_access
      model: i__looker
      explore: support_access_event
      type: table
      fields: [support_access_event.id, support_access_admin.name, support_access_event_attribute.login_purpose, support_access_event.login_date]
      filters:
        support_access_event.category: support_auth
        support_access_event_attribute.name: purpose
      sorts: [support_access_event.id desc]
      limit: 500
      column_limit: 50
      query_timezone: user_timezone


  filters:

  rows:
    - elements: [support_access_audit_description]
      height: 150
    - elements: [changes_to_support_access_settings, recent_access]
      height: 400
