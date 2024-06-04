IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'SALES')
BEGIN
CREATE DATABASE [SALES]
END
GO

USE [SALES];
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Sales_Data' and xtype='U')
BEGIN
	CREATE TABLE "Sales_Data" (
		"ORDERNUMBER" INT,
		"QUANTITYORDERED" INT,
		"PRICEEACH" Float,
		"ORDERLINENUMBER" INT,
		"SALES" Float,
		"ORDERDATE" datetime,
		"STATUS" varchar(50),
		"QTR_ID" INT,
		"MONTH_ID" INT,
		"YEAR_ID" INT,
		"PRODUCTLINE" varchar(50),
		"MSRP" Float,
		"PRODUCTCODE" varchar(50),
		"CUSTOMERNAME" varchar(50),
		"PHONE" varchar(50),
		"ADDRESSLINE1" varchar(50),
		"ADDRESSLINE2" varchar(50),
		"CITY" varchar(50),
		"STATE" varchar(50),
		"POSTALCODE" varchar(50),
		"COUNTRY" varchar(50),
		"TERRITORY" varchar(50),
		"CONTACTLASTNAME" varchar(50),
		"CONTACTFIRSTNAME" varchar(50),
		"DEALSIZE" varchar(50)
	)
END
Go
--------------
DROP TABLE IF EXISTS Customer_Dim
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Customer_Dim' and xtype='U')
BEGIN
    CREATE TABLE Customer_Dim (
        Cust_ID [INT] IDENTITY(1,1) primary key not null 
		,CUSTOMERNAME VARCHAR(50)    
		,PHONE  VARCHAR(50)
		,ADDRESSLINE1  VARCHAR(50)          
		,ADDRESSLINE2 VARCHAR(50) 
		,CITY VARCHAR(50) 
		,STATE VARCHAR(50) 
		,POSTALCODE VARCHAR(50) 
		,COUNTRY VARCHAR(50)
		,TERRITORY VARCHAR(50)
    )
END
Go
--------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Contract_Dim' and xtype='U')
BEGIN
    CREATE TABLE Contract_Dim (
        Contract_ID [INT] IDENTITY(1,1) primary key not null 
		,CONTACTLASTNAME VARCHAR(50)
		,CONTACTFIRSTNAME VARCHAR(50)
		,DEALSIZE VARCHAR(50)
	    )
END
Go
---------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Date_Dim' and xtype='U')
BEGIN
    CREATE TABLE Date_Dim (
		Date_ID [INT] IDENTITY(1,1) primary key not null 
		,QTR_ID INT
		,MONTH_ID INT
		,YEAR_ID INT
	    )
END
Go
--------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Product_Dim' and xtype='U')
BEGIN
    CREATE TABLE Product_Dim (
		Prod_ID [INT] IDENTITY(1,1) primary key not null
		,PRODUCTLINE VARCHAR(50)
		,MSRP  Float
		,PRODUCTCODE  VARCHAR(50)
	    )
END
Go		
-----------------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Order_Dim' and xtype='U')
BEGIN
    CREATE TABLE Order_Dim (
		Order_ID [INT] IDENTITY(1,1) primary key not null,
		ORDERNUMBER INT,
		QUANTITYORDERED INT,
		PRICEEACH Float,
		ORDERLINENUMBER INT,
		ORDERDATE datetime,
	)
END
Go	
-----------------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Sales_f' and xtype='U')
BEGIN
    CREATE TABLE Sales_f (
		Order_ID INT,
		Product_ID INT,
		Customer_ID INT,
		Contract_ID INT,
		Date_ID INT,
		SALES Float,
		Status varchar(50)
	)
END
Go	

TRUNCATE TABLE [dbo].[Sales_Data]
TRUNCATE TABLE [dbo].[Sales_f]
Go


