jq '.[] | { name: .Name, product_count: .Products | length }'
