[.Shops.[] | if .Capacity > 20 then . else null end] - [null] | .[].Employees.[] | { name: .fullname, product_count: .ProductRef | length }
