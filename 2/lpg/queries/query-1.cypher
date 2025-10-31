//return a compact profile for one shop: capacity, logo, and 
//counts of customers/employees/products it’s involved with.

MATCH (s:LocalBusiness {legalName:'shop2'})
OPTIONAL MATCH (s)-[:LOGO]->(lg:ImageObject)
OPTIONAL MATCH (s)-[:SERVES]->(c:Customer)
OPTIONAL MATCH (s)-[:HIRES]->(e:Employee)
OPTIONAL MATCH (s)-[:OWNS]->(p:Product)

RETURN s.legalName AS shop, s.capacity AS capacity,
       lg.image AS logoURL, lg.uploadDate AS logoUploaded,
       count(DISTINCT c) AS customers,
       count(DISTINCT e) AS employees,
       count(DISTINCT p) AS ownedProducts;




