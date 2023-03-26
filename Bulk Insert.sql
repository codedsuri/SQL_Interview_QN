-- import the file
BULK INSERT Town1.dbo.Sales
FROM 'C:\Users\HP\OneDrive\Desktop\Int_Qs\Shastra\Sales.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO

BULK INSERT Town1.dbo.Customer
FROM 'C:\Users\HP\OneDrive\Desktop\Int_Qs\Shastra\Customer.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO

BULK INSERT Town1.dbo.Product
FROM 'C:\Users\HP\OneDrive\Desktop\Int_Qs\Shastra\Product.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO