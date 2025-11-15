## data cleaning

## check for duplicates

SELECT Txn_ID, COUNT(*) AS freq
FROM banking_txns
GROUP BY Txn_ID
HAVING freq > 1;

## check for nulls or blanks
SELECT 
  SUM(CASE WHEN Merchant_Name IS NULL OR Merchant_Name = '' THEN 1 ELSE 0 END) AS missing_merchants,
  SUM(CASE WHEN Txn_Amount IS NULL OR Txn_Amount = 0 THEN 1 ELSE 0 END) AS zero_amounts,
  SUM(CASE WHEN Txn_Date IS NULL THEN 1 ELSE 0 END) AS missing_dates
FROM banking_txns;

## convert text based booleans to 0s n 1s

UPDATE banking_txns
SET Fraud_Flag = CASE
WHEN Fraud_Flag IN ('Yes') THEN 1 ELSE 0
END;

