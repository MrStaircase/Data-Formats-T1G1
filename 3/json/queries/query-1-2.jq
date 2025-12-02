[.Shops[] | if .Products != null and .Products[].price > 20 then . else null end] - [null]
| .[] | { shop_name: .Name, products: [(.Products[] | if .price > 20 then .name else null end)] - [null] }
