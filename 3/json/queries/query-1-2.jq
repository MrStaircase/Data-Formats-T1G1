.Shops.[] | { shop_name: .Name, products: [(.Products | if . == null then null else .[].name end)] - [null] }
