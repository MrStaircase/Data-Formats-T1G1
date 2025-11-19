[.Shops.[] | if .Capacity > 20 then . else null end] - [null] | .[].Employees.[].ProductRef | length
