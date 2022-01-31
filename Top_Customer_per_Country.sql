WITH CustomerInvoice AS (
	SELECT Customer.CustomerId AS customer_id, Customer.FirstName, Customer.LastName, 
			Customer.Country, SUM(Invoice.Total) AS total_customer_spend
	FROM Customer
	JOIN Invoice
	ON Customer.CustomerId = Invoice.CustomerId
	GROUP BY 1)


SELECT CustomerInvoice.*
FROM CustomerInvoice
JOIN (
		SELECT Customer.Country, 
				MAX(CustomerInvoice.total_customer_spend) AS max_country_spend
		FROM Customer
		JOIN CustomerInvoice
		ON CustomerInvoice.customer_id = Customer.CustomerId
		GROUP BY 1
		ORDER BY 2 DESC) AS CustomerInvoiceMax

ON CustomerInvoice.Country = CustomerInvoiceMax.Country
WHERE CustomerInvoice.total_customer_spend = CustomerInvoiceMax.max_country_spend
ORDER BY Country;