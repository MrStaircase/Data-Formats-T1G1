[.Shops[] | (.Employees , .Visitors) | if . == null then null else .[] end] - [null] | unique | .[]
| { name: .fullname, has_phone_number: if .phone_numbers.length > 0 then "true" else "false" end, phone_number_count: .phone_numbers.length }
