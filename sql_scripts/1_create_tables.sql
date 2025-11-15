USE neobank;

## creating table

CREATE TABLE banking_txns (
Txn_ID VARCHAR (100) PRIMARY KEY,
Acct_Number VARCHAR(50),
Txn_Date DATE, 
Txn_Amount DECIMAL(15,2),
Merchant_Name VARCHAR (255),
Txn_Type VARCHAR (50),
Category VARCHAR (50),
City VARCHAR (50),
Country VARCHAR (50),
Payment_Method VARCHAR (50),
Cus_Age INT,
Cus_Gender VARCHAR (10),
Cus_Occupation VARCHAR (100),
Cus_Income DECIMAL(15,2),
Acct_Balance DECIMAL(15,2),
Txn_Status VARCHAR (50),
Fraud_Flag VARCHAR (10),
Discount_Applied VARCHAR(10),
Loyalty_Pts_Earned INT,
Txn_Description TEXT
) ;

## import csv

LOAD DATA LOCAL INFILE 'C:/temp/bank_csv/Banking_Transactions_USA_2023_2024.csv'
INTO TABLE banking_txns
CHARACTER SET 'utf8mb4'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(Txn_ID, Acct_Number, @Txn_Date, Txn_Amount, Merchant_Name, Txn_Type, Category, City, Country, Payment_Method, Cus_Age, Cus_Gender, Cus_Occupation, Cus_Income, Acct_Balance, Txn_Status, Fraud_Flag, Discount_Applied, Loyalty_Pts_Earned, Txn_Description)
SET Txn_Date = STR_TO_DATE(@Txn_Date, '%Y-%m-%d %H:%i:%s');

select * 
from banking_txns
limit 25;










