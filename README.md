# ForeverFitness

Month-over-Month (MoM) revenue analysis for an e-commerce sports supplements store.

![Power BI Visual](https://github.com/AdamLumbley/ForeverFitness/raw/main/ForeverFitness%20Power%20BI%20MoM%20%2B%20Cumulative%20Total.png)
https://raw.githubusercontent.com/AdamLumbley/ForeverFitness/main/ForeverFitness%20Top%20Products%20By%20Revenue.png

## Overview

Month-over-Month (MoM) revenue analysis for an e-commerce sports supplements store.
This project demonstrates how SQL and Power BI can transform raw transaction data into business insights such as monthly revenue trends, cumulative revenue growth, and MoM performance.

## Tools Used

* **SQL / SQLite** – schema creation and revenue analysis queries
* **Power BI** – visualization of revenue trends and cumulative performance

## Database Schema

**Customers Table**

* `customer_id` (Primary Key)
* `first_name`
* `last_name`
* `email`

**Products Table**

* `product_id` (Primary Key)
* `product_name`
* `category`
* `price`

**Orders Table**

* `order_id` (Primary Key)
* `customer_id` (Foreign Key → Customers)
* `product_id` (Foreign Key → Products)
* `quantity`
* `order_date`
* `total_amount`

## Query

### Month-over-Month (MoM) Revenue Analysis

```sql
WITH monthly_revenue AS (
    SELECT strftime('%Y-%m', order_date) AS month,
           SUM(total_amount) AS revenue
    FROM Orders
    GROUP BY month
)
SELECT month,
       ROUND(revenue,0) AS revenue,
       ROUND(LAG(revenue) OVER (ORDER BY month),0) AS prev_revenue,
       ROUND(revenue - LAG(revenue) OVER (ORDER BY month),0) AS mom_change,
       ROUND((revenue - LAG(revenue) OVER (ORDER BY month)) * 100.0 / LAG(revenue) OVER (ORDER BY month),0) AS mom_percent_change,
       ROUND(SUM(revenue) OVER (ORDER BY month),0) AS cumulative_total
FROM monthly_revenue;
```

## Key Insights

* Monthly revenue aggregation highlights fluctuations in sales performance across the year.
* Month-over-Month (MoM) analysis measures short-term revenue growth by comparing each month to the previous one.
* SQL window functions (`LAG`) calculate revenue change and percentage growth between months.
* A cumulative revenue metric shows overall revenue progression over time.
* The resulting dataset feeds directly into a Power BI dashboard for visualization and business monitoring.

## Skills Demonstrated

* SQL data modeling and relational schema design
* Common Table Expressions (CTEs)
* SQL window functions (`LAG`, cumulative `SUM`)
* Time-based revenue analysis
* Month-over-Month (MoM) growth metrics
* Data visualization with Power BI
