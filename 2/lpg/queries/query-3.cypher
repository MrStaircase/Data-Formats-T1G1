// Q3 — For every person (Employees and Customers) list their full name,
// a bool which is true if the person has at least one phone number,
// and a quantity of the phone numbers the person has.

MATCH
  (e:Employee|Customer)
RETURN
  e.fullName AS employeeName,
  e.phone IS NOT NULL AS hasPhone,
  CASE e.phone
    WHEN IS NULL THEN 0
    ELSE size(e.phone)
  END AS telephoneCount
ORDER BY
  e.fullName,
  telephoneCount
