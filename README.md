# ForeverFitness

ForeverFitness: SQL + Power BI Revenue Analytics Dashboard

![Power BI Visual](https://github.com/AdamLumbley/ForeverFitness/raw/main/ForeverFitness%20Power%20BI%20MoM%20%2B%20Cumulative%20Total.png)
![Top Products by Revenue](https://raw.githubusercontent.com/AdamLumbley/ForeverFitness/main/ForeverFitness%20Top%20Products%20By%20Revenue.png)

## Overview

This project analyzes sales data from a simulated e-commerce sports supplements store to demonstrate how SQL and Power BI can transform raw transaction data into business insights.

This dashboard also analyzes the top products by total revenue, ranking the top 5 products to highlight which items drive the most revenue for ForeverFitness.

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

## Sample Query

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
* Ranking top products by total revenue highlights which items drive the most sales, helping prioritize inventory and marketing focus.

## Skills Demonstrated

* SQL data modeling and relational schema design
* Common Table Expressions (CTEs)
* SQL window functions (`LAG`, cumulative `SUM`)
* Time-based revenue analysis
* Month-over-Month (MoM) growth metrics
* Data visualization with Power BI
