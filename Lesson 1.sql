SELECT   c.CustomerId,
         c.FirstName,
         c.LastName,
         --c.FirstName + ' ' + c.LastName AS "Customer Name",
         CONCAT(c.FirstName, ' ', c.LastName) AS "Customer Name 1",
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
         c.FirstName,
         c.LastName,
         CONCAT(c.FirstName, ' ', c.LastName) AS "Customer Name",
         SUM(i.Total) AS "Invoice Total",
         COUNT(*) AS "No of Invoices"
FROM     INVOICE AS i
         INNER JOIN
         Customer AS c
         ON i.CustomerId = c.CustomerId
GROUP BY i.CustomerId, c.FirstName, c.LastName, CONCAT(c.FirstName, ' ', c.LastName)
ORDER BY i.CustomerId;

--alternative way 
SELECT ibc.CustomerId,
       c.FirstName,
       c.LastName,
       CONCAT(c.FirstName, ' ', c.LastName) AS "Customer Name",
       ibc."Invoice Total",
       ibc."No of Invoices"
FROM   (SELECT   i.CustomerId,
                 SUM(i.Total) AS "Invoice Total",
                 COUNT(*) AS "No of Invoices"
        FROM     Invoice AS i
        GROUP BY i.CustomerId) AS ibc
       INNER JOIN
       Customer AS c
       ON ibc.CustomerId = c.CustomerId;

--Customers and Employees
SELECT *
FROM   Employee AS e;

SELECT   c.CustomerId,
         CONCAT(c.FirstName, ' ', c.LastName) AS "Customer Name",
         e.EmployeeId,
         e.FirstName,
         e.LastName,
         CONCAT(e.FirstName, ' ', e.LastName) AS "Employee Name"
FROM     Customer AS c
         INNER JOIN
         Employee AS e
         ON c.SupportRepId = e.EmployeeId
ORDER BY c.CustomerId;

--Customer invoices and support employees
SELECT   ibc.CustomerId,
         CONCAT(c.FirstName, ' ', c.LastName) AS "Customer Name",
         ibc."Invoice Total",
         ibc."No of Invoices",
         CONCAT(e.FirstName, ' ', e.LastName) AS "Employee Name"
FROM     (SELECT   i.CustomerId,
                   SUM(i.Total) AS "Invoice Total",
                   COUNT(*) AS "No of Invoices"
          FROM     Invoice AS i
          GROUP BY i.CustomerId) AS ibc
         INNER JOIN
         Customer AS c
         ON ibc.CustomerId = c.CustomerId
         INNER JOIN
         Employee AS e
         ON c.SupportRepId = e.EmployeeId
ORDER BY ibc.CustomerId;