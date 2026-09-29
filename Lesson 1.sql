SELECT   c.CustomerId,
         c.FirstName,
         c.LastName,
         c.City,
         c.Company
FROM     Customer AS c
WHERE    c.Company IS NOT NULL
--WHERE c.City IN ('London','Paris','Rome','Berlin')
--WHERE c.LastName LIKE '%R'
ORDER BY c.Company ASC;

SELECT   TOP 5 c.Country,
               COUNT(*) AS "Number of Customers"
FROM     Customer AS c
WHERE    c.Company IS NULL
GROUP BY c.Country
ORDER BY "Number of Customers" DESC;


--Looking at invoice
SELECT   i.InvoiceId,
         i.InvoiceDate,
         i.CustomerId,
         i.Total
FROM     INVOICE AS i
ORDER BY i.CustomerId;

SELECT   i.CustomerId,
         SUM(i.Total) AS "Invoice Total"
FROM     INVOICE AS i
GROUP BY i.CustomerId
ORDER BY i.CustomerId;