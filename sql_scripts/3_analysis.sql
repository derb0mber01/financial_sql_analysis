select *
from banking_txns;

## monthly income vs spend

select
DATE_FORMAT(Txn_Date, '%Y-%m') AS txn_year_month,
count(*) as tx_count,
round(sum(case when Txn_Amount > 0 then Txn_Amount ELSE 0 END), 0) as monthly_spend,
round(sum(case when Cus_Income > 0 then Cus_Income ELSE 0 END), 0) as monthly_income
from banking_txns
group by txn_year_month
order by txn_year_month;

## monthly spend (by city)

select City,
count(*) as txn_count,
round(sum(Txn_Amount),0) as txn_total_amt
from banking_txns
group by City
order by txn_total_amt desc;

## top categories & merchants

select Category,
count(*) as txn_count,
round(sum(Txn_Amount),0) as total_spend,
round(avg(Txn_Amount),0) as avg_spend
from banking_txns
group by Category
order by total_spend desc;

select Merchant_Name,
count(*) as txn_count,
sum(Txn_Amount) as total_spend,
round(avg(Txn_Amount),2) as avg_spend
from banking_txns
group by Merchant_Name
order by total_spend desc
limit 10;

## KPIs

select
count(*) as total_txns,
round(sum(Txn_Amount), 0) as total_volume,
round(avg(Txn_Amount), 0) as avg_txn_amt,
round(sum(case when Txn_Type='Credit' then Txn_Amount else 0 end), 0) AS total_deposits,
round(sum(case when Txn_Type='Debit' then Txn_Amount else 0 end), 0) as total_withdrawals,
sum(Fraud_Flag) as fraud_count
from banking_txns;

## gender analysis

select
Cus_Gender,
count(*) as txn_count,
round(sum(Txn_Amount), 0) as total_spend,
round(avg(Txn_Amount), 0) as avg_spend,
round(avg(Cus_Income), 0) as avg_income
from banking_txns
group by Cus_Gender;

## R, F, M per account
WITH cust_agg AS (
  SELECT
    Acct_Number,
    MAX(Txn_Date) AS last_tx,
    COUNT(*) AS frequency,
    SUM(Txn_Amount) AS monetary
  FROM banking_txns
  GROUP BY Acct_Number
)
SELECT
  Acct_Number,
  DATEDIFF(CURDATE(), DATE(last_tx)) AS recency_days,
  frequency,
  monetary
FROM cust_agg
ORDER BY monetary DESC
LIMIT 50;
