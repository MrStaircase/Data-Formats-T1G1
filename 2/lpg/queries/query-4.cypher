// Find shops that have hired employees before 2020 and own more than 10 total items in stock.
// Return the shop name, total stock amount, and their employees with hire dates.

MATCH (shop:LocalBusiness)-[h:HIRES]->(emp:Employee)
WHERE date(h.since) < date('2020-01-01')
WITH shop, collect({employee: emp.fullName, hired_since: h.since}) AS employees
MATCH (shop)-[o:OWNS]->(prod:Product)
WITH shop, employees, sum(o.amount) AS total_stock
WHERE total_stock > 10
RETURN 
  shop.legalName AS shopName,
  total_stock AS totalInventory,
  employees
ORDER BY total_stock DESC;
