jq '.[] | if .Capacity > 20 then
  .Employees | .[] | ...list products
end'
