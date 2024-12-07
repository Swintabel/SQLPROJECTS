drop database if exists supermarket;

create database supermarket;

use supermarket;

----------------------------------------------
# create category table
----------------------------------------------
drop table if exists category;

CREATE TABLE category 
(ItemCode bigint unique, 
 ItemName varchar(255), 
 CategoryCode int, 
 CategoryName text,
primary key(ItemCode));

LOAD DATA infile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\category.csv"
INTO TABLE category
FIELDS terminated by ','
ignore 1 lines;



---------------------------------------------
# Create lossrate table
---------------------------------------------
drop table if exists lossrate;

CREATE TABLE lossrate
 (ItemCode bigint unique, 
  ItemName text, 
  `LossRate(%)` double,
 primary key(ItemCode),
 foreign key(ItemCode) references category(ItemCode));

LOAD DATA infile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\lossrate.csv"
INTO TABLE lossrate
FIELDS terminated by ','
ignore 1 lines;




---------------------------------------
# create Wholesale Price Table
---------------------------------------
drop table if exists wholesaleprice;

CREATE TABLE WholesalePrice 
(`Date` date, 
ItemCode bigint, 
`WholesalePrice(RMB/kg)` double,
primary key(`Date`, ItemCode),
FOREIGN KEY (ItemCode) REFERENCES Category(ItemCode),
FOREIGN KEY (ItemCode) REFERENCES lossrate(ItemCode));


LOAD DATA infile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\price.csv"
INTO TABLE WholesalePrice
FIELDS terminated by ','
ignore 1 lines;


# Create sales table
---------------------------------------------
drop table if exists sales;

CREATE TABLE Sales
(`Date` date, 
`Time` time, 
ItemCode bigint, 
`QuantitySold(kilo)` double, 
`UnitSellingPrice(RMB/kg)` double, 
SaleorReturn varchar(50), 
`Discount(Yes/No)` varchar(5),
FOREIGN KEY (ItemCode) REFERENCES Category(ItemCode),
FOREIGN KEY (ItemCode) REFERENCES lossrate(ItemCode),
FOREIGN KEY (ItemCode) REFERENCES WholesalePrice(ItemCode),
FOREIGN KEY (`Date`) REFERENCES WholesalePrice(`Date`));



# Load data from csv into sales table in DB
LOAD DATA infile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Sales.csv"
INTO TABLE sales
FIELDS terminated by ','
ignore 1 lines;

ALTER table sales
add column SalesID INT auto_increment PRIMARY KEY;



# Gave secure file error, removed path from my.ini file(run as admin) and restarted mysql in services
# SHOW VARIABLES LIKE "secure_file_priv";
------------------------------------------------------------------------------------------------------------------------------------------------

