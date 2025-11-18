jq '.[].Employees[] | { name: .fullname, has_phone_number: if .phone_numbers.length > 0 then "true" else "false" end, phone_number_count: .phone_numbers.length }'
