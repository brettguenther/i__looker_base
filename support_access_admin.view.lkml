include: "user.view"

view: support_access_admin {
  sql_table_name: user ;;
  extends: [user]

  dimension: name {
    sql: CASE
        WHEN ${first_name} IS NULL THEN 'TIMER EXPIRED'
        WHEN ${first_name} IS NOT NULL THEN CONCAT(first_name, ' ', last_name)
      END
       ;;

      link: {
        label: "Edit User"
        url: "/admin/users/{{id._value}}/edit"
      }
    }
  }
