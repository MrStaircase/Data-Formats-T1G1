// === SHOPS ===
MERGE (shop1:LocalBusiness { legalName: 'shop1', capacity: 10 })
MERGE (shop2:LocalBusiness { legalName: 'shop2', capacity: 20 })
MERGE (shop3:LocalBusiness { legalName: 'shop3', capacity: 30 })
MERGE (shop4:LocalBusiness { legalName: 'shop4', capacity: 42 })

// === CUSTOMERS ===
MERGE (cus1:Customer { nick: 'Al', numberOfVisits: 2, fullName: 'Alice' })
MERGE (cus2:Customer { nick: 'Bo', numberOfVisits: 3, fullName: 'Bob' })
MERGE (cus3:Customer { nick: 'Cha', numberOfVisits: 4, fullName: 'Charlie' })

// === EMPLOYEES ===
MERGE (emp1:Employee { identifier: '1', salary: 1000, fullName: 'Dave' })
MERGE (emp2:Employee { identifier: '2', salary: 1100, fullName: 'Eve' })
MERGE (emp3:Employee { identifier: '3', salary: 1200, fullName: 'Crank', phone: ['tel:+420123456789'] })
MERGE (emp4:Employee { identifier: '4', salary: 1300, fullName: 'Grace', phone: ['tel:+420987654321','tel:+420112233445'] })

// === PRODUCTS ===
MERGE (prod1:Product { name: 'Coffee', preparationTime: 100, price: 10 })
MERGE (prod2:Product { name: 'Sandwich', preparationTime: 120, price: 20 })
MERGE (prod3:Product { name: 'Ice cream', preparationTime: 140, price: 30 })

// === LOGOS ===
MERGE (logo1:ImageObject { image: 'http://example.com/image1', uploadDate: '2025-02-01'})
MERGE (logo2:ImageObject { image: 'http://example.com/image2', uploadDate: '2025-04-03'})
MERGE (logo3:ImageObject { image: 'http://example.com/image3', uploadDate: '2025-06-05'})

// === RELATIONSHIPS ===
MERGE (shop2)-[:SERVES]->(cus2)
MERGE (shop2)-[:SERVES]->(cus3)
MERGE (shop3)-[:SERVES]->(cus3)

MERGE (shop1)-[:HIRES { since: '2014-03-16'}]->(emp1)
MERGE (shop2)-[:HIRES { since: '2016-08-30'}]->(emp2)
MERGE (shop3)-[:HIRES { since: '2019-02-20'}]->(emp3)
MERGE (shop4)-[:HIRES { since: '2010-02-01'}]->(emp4)

MERGE (shop2)-[:OWNS {amount : 5}]->(prod1)
MERGE (shop2)-[:OWNS {amount : 12}]->(prod2)
MERGE (shop3)-[:OWNS {amount : 27}]->(prod3)

MERGE (shop2)-[:LOGO]->(logo2)
MERGE (shop3)-[:LOGO]->(logo3)
MERGE (shop4)-[:LOGO]->(logo3)

MERGE (prod1)-[:PRODUCES]->(emp2)
MERGE (prod1)-[:PRODUCES]->(emp3)
MERGE (prod2)-[:PRODUCES]->(emp4)
MERGE (prod3)-[:PRODUCES]->(emp2)
