jq '.[].Employees | . | .[] | { name: .fullname, produces_products: .Products | length }'
