// A shop that owns more than 1 coffee that was produced by its employee
// return per-product count & profits and total profit, ordered by count.
MATCH (shop:LocalBusiness)-[:HIRES]->(employee:Employee)
MATCH (shop)-[ownsCoffee:OWNS]->(coffee:Product{name:'Coffee'})<-[:PRODUCES]-(employee)
WHERE (ownsCoffee.amount IS NOT NULL AND ownsCoffee.amount>1)
WITH employee, shop,
     ownsCoffee.amount AS coffeeQty,  coffee.price AS coffeePrice
RETURN employee.fullName AS employee,
       shop.legalName AS shop,
       coffeeQty AS coffees,
       coffeeQty*coffeePrice AS coffeeProfit,
       coffeeQty*coffeePrice AS totalProfit
ORDER BY coffees DESC;
