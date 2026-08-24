# FinTech-Fraud-Velocity-Tracker
Real-time SQL pipeline to detect transaction velocity fraud using Rolling Windows and CTEs.

# 💳 FinTech Fraud Velocity Tracker

## 📌 The Business Problem
Financial institutions and digital wallets face massive losses due to "Velocity Fraud"—when a fraudster rapidly makes multiple transactions in a short time after stealing a card or account details. Detecting this in real-time requires looking at the immediate history of a user's transactions rather than just their overall daily limit.

## 🛠️ The Solution & Methodology
I engineered a dynamic SQL pipeline that acts as a real-time detection engine. It evaluates every new transaction against the user's spending behavior within a rolling 2-hour window.

**Techniques Used:**
*   **Rolling Windows (`RANGE BETWEEN`):** To restrict the data analysis specifically to the preceding 2 hours for every single row.
*   **Advanced Aggregation (`SUM`, `COUNT`, `AVG` OVER):** To calculate the recent transaction frequency and compare current spend against the rolling average.
*   **Automated Flagging (`CASE WHEN`):** To instantly label a transaction as "Suspected Fraud" if it breaches both the frequency (count > 3) and spending threshold (amount > avg).

## 📊 The Output (Actionable Insights)

The query successfully simulated a real-time risk engine. Here is a snapshot of the detection results:

### 🚨 Suspicious Activity Flagged
* **Transaction ID: 6 | Merchant: Rolex Store**
  * **Amount Attempted:** $4500.00
  * **Recent 2-Hour Velocity:** 4 transactions made totaling $4504.50
  * **Average Spend:** $1126.12
  * **System Decision:** **Suspected Fraud** (Action: Block Transaction / Require OTP)

### 🟢 Normal Activity Authorized
* **Transaction ID: 11 | Merchant: Apple Store**
  * **Amount Attempted:** $1200.00
  * **Recent 2-Hour Velocity:** 3 transactions made (below risk threshold of >3)
  * **System Decision:** Normal (Action: Processed Successfully)
