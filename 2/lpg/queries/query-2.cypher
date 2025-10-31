// Employees hired by a shop that produced >1 of each (Coffee, Sandwich, Ice cream);
// return per-product counts & profits and total profit, ordered by counts.
OPTIONAL MATCH (shop:LocalBusiness)-[:HIRES]->(employee:Employee)
OPTIONAL MATCH (shop)-[ownsCoffee:OWNS]->(coffee:Product{name:'Coffee'})<-[:PRODUCES]-(employee)
OPTIONAL MATCH (shop)-[ownsSandwich:OWNS]->(sandwich:Product{name:'Sandwich'})<-[:PRODUCES]-(employee)
OPTIONAL MATCH (shop)-[ownsIceCream:OWNS]->(iceCream:Product{name:'Ice cream'})<-[:PRODUCES]-(employee)
WHERE (ownsCoffee.amount IS NOT NULL AND ownsCoffee.amount>1) OR (ownsSandwich.amount IS NOT NULL AND ownsSandwich.amount>1) OR (ownsIceCream.amount IS NOT NULL AND ownsIceCream.amount>1)
WITH employee,shop,
     ownsCoffee.amount AS coffeeQty,  coffee.price AS coffeePrice,
     ownsSandwich.amount AS sandwichQty, sandwich.price AS sandwichPrice,
     ownsIceCream.amount AS iceCreamQty, iceCream.price AS iceCreamPrice
RETURN employee.fullName AS employee,
       shop.legalName AS shop,
       coffeeQty AS coffees, sandwichQty AS sandwiches, iceCreamQty AS icecreams,
       coffeeQty*coffeePrice AS coffeeProfit,
       sandwichQty*sandwichPrice AS sandwichProfit,
       iceCreamQty*iceCreamPrice AS iceCreamProfit,
       coffeeQty*coffeePrice + sandwichQty*sandwichPrice + iceCreamQty*iceCreamPrice AS totalProfit
ORDER BY coffees DESC, sandwiches DESC, icecreams DESC;

