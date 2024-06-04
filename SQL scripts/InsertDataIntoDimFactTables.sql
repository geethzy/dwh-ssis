-------------------------
TRUNCATE TABLE Order_Dim;
DBCC CHECKIDENT('Order_Dim', RESEED, 1);
TRUNCATE TABLE Contract_Dim;
DBCC CHECKIDENT('Contract_Dim', RESEED, 1);
TRUNCATE TABLE Customer_Dim;
DBCC CHECKIDENT('Customer_Dim', RESEED, 1);
TRUNCATE TABLE Product_Dim;
DBCC CHECKIDENT('Product_Dim', RESEED, 1);
TRUNCATE TABLE Date_Dim;
DBCC CHECKIDENT('Date_Dim', RESEED, 1);


INSERT INTO [dbo].[Customer_Dim]([CUSTOMERNAME]
      ,[PHONE]
      ,[ADDRESSLINE1]
      ,[ADDRESSLINE2]
      ,[CITY]
      ,[STATE]
      ,[POSTALCODE]
      ,[COUNTRY]
      ,[TERRITORY])
SELECT DISTINCT
      [CUSTOMERNAME]
      ,[PHONE]
      ,[ADDRESSLINE1]
      ,[ADDRESSLINE2]
      ,[CITY]
      ,[STATE]
      ,[POSTALCODE]
      ,[COUNTRY]
      ,[TERRITORY]
	FROM [dbo].[Sales_Data];
Go
------------------------------------
INSERT INTO [dbo].[Order_Dim]([ORDERNUMBER]
      ,[QUANTITYORDERED]
      ,[PRICEEACH]
      ,[ORDERLINENUMBER]
      ,[ORDERDATE])
SELECT DISTINCT
		[ORDERNUMBER]
      ,[QUANTITYORDERED]
      ,[PRICEEACH]
      ,[ORDERLINENUMBER]
      ,[ORDERDATE]
FROM [dbo].[Sales_Data];
Go
-----------------------------------
INSERT INTO [dbo].[Date_Dim]([QTR_ID]
      ,[MONTH_ID]
      ,[YEAR_ID])
SELECT DISTINCT
	   [QTR_ID]
      ,[MONTH_ID]
      ,[YEAR_ID]
FROM [dbo].[Sales_Data]
Go;
-------------------------------------
INSERT INTO [dbo].[Contract_Dim]([CONTACTLASTNAME]
      ,[CONTACTFIRSTNAME]
      ,[DEALSIZE])
SELECT DISTINCT
		[CONTACTLASTNAME]
      ,[CONTACTFIRSTNAME]
      ,[DEALSIZE]
FROM [dbo].[Sales_Data];
Go
---------------------------------------
INSERT INTO [dbo].[Product_Dim]([PRODUCTLINE]
      ,[MSRP]
      ,[PRODUCTCODE])
SELECT DISTINCT
		[PRODUCTLINE]
      ,[MSRP]
      ,[PRODUCTCODE]
FROM [dbo].[Sales_Data];
Go
---------------------------------------------------
INSERT INTO [dbo].[Sales_f](
		[Order_ID],
		[Product_ID],
		[Customer_ID],
		[Contract_ID],
		[Date_ID],
		[SALES],
		[Status])
SELECT  o.[Order_ID],
		p.[Prod_ID],
		a.[Cust_ID],
		c.[Contract_ID],
		d.[Date_ID], 
		s.[SALES],
		s.[Status]
FROM   [dbo].[Sales_Data] as s
JOIN   [dbo].[Order_Dim] as o     ON s.[ORDERNUMBER]=o.[ORDERNUMBER] and s.[ORDERLINENUMBER]=o.[ORDERLINENUMBER]
JOIN	[dbo].[Product_Dim] as p  ON s.[PRODUCTCODE]=p.[PRODUCTCODE]
JOIN	[dbo].[Contract_Dim] as c ON s.[CONTACTLASTNAME]=c.[CONTACTLASTNAME] and s.[CONTACTFIRSTNAME]=c.[CONTACTFIRSTNAME] and s.[DEALSIZE]=c.[DEALSIZE]
JOIN	[dbo].[Date_Dim] as d     ON s.[QTR_ID]=d.[QTR_ID] and s.[MONTH_ID]=d.[MONTH_ID] and s.[YEAR_ID]=d.[YEAR_ID]
JOIN    [dbo].[Customer_Dim] as a ON s.[CUSTOMERNAME]=a.[CUSTOMERNAME]
Go