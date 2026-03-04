# ForeverFitness
Month-over-Month (MoM) revenue analysis for an e-commerce sports supplements store
# ForeverFitness

![Power BI Visual](https://github.com/AdamLumbley/ForeverFitness/raw/main/ForeverFitness%20Power%20BI%20MoM%20%2B%20Cumulative%20Total.png)

## Overview
Month-over-Month (MoM) revenue analysis for an e-commerce sports supplements store.  
This project demonstrates the use of SQL, SQLite, and Power BI to track monthly revenue trends, cumulative totals, and growth rates.  

## Tools Used
- **SQL / SQLite** – for schema creation and querying revenue metrics  
- **Power BI** – to visualize MoM revenue and cumulative total trends  

## Database Schema
**Customers Table**
- `customer_id` (Primary Key)  
- `first_name`  
- `last_name`  
- `email`  

**Products Table**
- `product_id` (Primary Key)  
- `product_name`  
- `category`  
- `price`  

**Orders Table**
- `order_id` (Primary Key)  
- `customer_id` (Foreign Key → Customers)  
- `product_id` (Foreign Key → Products)  
- `quantity`  
- `order_date`  
- `total_amount`  

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
