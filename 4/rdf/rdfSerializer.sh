rdf serialize \
  --input-format tabular \
  --minimal \
  --output-format turtle \
  --decode-uri \
  --prefixes \
ex:https://example.org/vocabulary/,\
emp:https://example.org/resource/employee/,\
cus:https://example.org/resource/customer/,\
foaf:https://xmlns.com/foaf/0.1/,\
shop:https://example.org/resource/shop/,\
logo:https://example.org/resource/logo/,\
prod:https://example.org/resource/product/,\
image:https://example.org/resource/image/ \
../csv/data.csv-metadata.json > data.ttl
