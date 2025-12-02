[.Shops[] | (.Employees , .Visitors) | if . == null then null else .[] end] - [null] | unique | .[]
| { name: .fullname, has_phoneNumber: if .phoneNumbers | length > 0 then "true" else "false" end, phoneNumber_count: .phoneNumbers | length }
