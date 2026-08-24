CREATE DATABASE IF NOT EXISTS fintech_fraud_detection;
USE fintech_fraud_detection;

CREATE TABLE transactions (
    txn_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    merchant_name VARCHAR(50),
    amount DECIMAL(10,2),
    txn_timestamp DATETIME
);

INSERT INTO transactions (account_id, merchant_name, amount, txn_timestamp) VALUES 
(5501, 'Amazon', 150.00, '2026-08-22 08:30:00'),
(5501, 'Uber', 15.50, '2026-08-22 14:00:00'),
(5502, 'Steam Games', 2.00, '2026-08-22 10:05:00'), 
(5502, 'Spotify', 1.00, '2026-08-22 10:15:00'),      
(5502, 'Netflix', 1.50, '2026-08-22 10:30:00'),      
(5502, 'Rolex Store', 4500.00, '2026-08-22 11:00:00'),
(5503, 'Grocery', 85.00, '2026-08-22 12:00:00'),
(5503, 'Gas Station', 40.00, '2026-08-22 18:00:00'),
(5504, 'Test Auth', 1.00, '2026-08-22 21:00:00'),    
(5504, 'Test Auth', 0.50, '2026-08-22 21:10:00'),
(5504, 'Apple Store', 1200.00, '2026-08-22 21:25:00');

WITH txn AS (SELECT *,COUNT(txn_id) OVER(PARTITION BY account_id ORDER BY txn_timestamp RANGE BETWEEN INTERVAL 2 HOUR PRECEDING AND CURRENT ROW) AS Recent_Txn_Count,SUM(amount) OVER(PARTITION BY account_id ORDER BY txn_timestamp RANGE BETWEEN INTERVAL 2 HOUR PRECEDING AND CURRENT ROW) AS Recent_Total_Spent,avg(amount) OVER(PARTITION BY account_id ORDER BY txn_timestamp RANGE BETWEEN interval 2 HOUR PRECEDING AND current ROW) AS avg_spent 
 FROM transactions)
 
 SELECT *,  
 CASE  
 WHEN t.Recent_Txn_Count>3 AND t.Recent_Total_Spent > t.avg_spent THEN "Suspected Fraud"
 ELSE "Normal"
 END AS LABEL
 FROM txn t
 ;
