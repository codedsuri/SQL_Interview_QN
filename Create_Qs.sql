USE Town1;

CREATE TABLE Product
(
 ProductCode VARCHAR(10),
 ProductName VARCHAR(10),
 BrandName VARCHAR(10),
 UnitPrice VARCHAR(5),
 
 PRIMARY KEY (ProductCode)
 );

CREATE TABLE Customer
(
 CustomerCode VARCHAR(10),
 CustomerName VARCHAR(25),
 MembershipFlag INT,

 PRIMARY KEY(CustomerCode)
 );

USE Town1;

CREATE TABLE Sales
(
 CustomerCode VARCHAR(10),
 ProductCode VARCHAR(10),
 Date DATE,
 Sales VARCHAR(10),

 PRIMARY KEY(CustomerCode, ProductCode),
 FOREIGN KEY(CustomerCode) REFERENCES Customer(CustomerCode),
 FOREIGN KEY(ProductCode) REFERENCES Product(ProductCode)
 );