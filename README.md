# ForeverFitness

ForeverFitness: SQL + Power BI Revenue Analytics Dashboard

![Power BI Visual](https://github.com/AdamLumbley/ForeverFitness/raw/main/ForeverFitness%20Power%20BI%20MoM%20%2B%20Cumulative%20Total.png)
![2025 Revenue by Location](ForeverFitness%20ArcGIS%202025%20Revenue%20By%20Location.png)
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

1. **Seasonal Revenue Trends**

   - Revenue starts moderate in January ($359.92) and steadily grows, peaking in May ($389.92).  
   - Slight dips occur mid-year (July/August) before rebounding toward the end of the year.  
   - Suggests seasonal patterns: spring promotions or new product launches might drive revenue spikes.

2. **Month-over-Month (MoM) Growth**

   - Biggest MoM increases happen in April → May, indicating strong mid-year growth.  
   - Negative or small growth occurs in July, signaling potential slow months or the need for marketing focus.

3. **Cumulative Revenue**

   - Total revenue steadily accumulates month-to-month, demonstrating consistent business growth over the year.  
   - By December, cumulative revenue reaches ~$1,230–$1,250, showing strong annual performance.

4. **Top-Selling Products**

   - Whey Protein appears frequently across months → consistently drives sales.  
   - Pre-Workout and Creatine Monohydrate also contribute significantly.  
   - Top 5 products generate the majority of total revenue, highlighting where inventory and marketing focus should go.

5. **Customer Behavior**

   - All 5 customers make repeated purchases throughout the year, showing customer retention.  
   - Certain products (protein powders) have higher quantities per order → product bundling or promotions could increase revenue further.

6. **Strategic Opportunities**

   - Mid-year slowdowns (July–August) could be targeted with promotions or marketing campaigns.  
   - Focus on top revenue-driving products for upselling, cross-selling, or bundles.  
   - Consider introducing seasonal supplements or limited-time offers to smooth revenue dips.

## Skills Demonstrated

* SQL data modeling and relational schema design
* Common Table Expressions (CTEs)
* SQL window functions (`LAG`, cumulative `SUM`)
* Time-based revenue analysis
* Month-over-Month (MoM) growth metrics
* Power BI dashboard development and KPI visualization

## How to Run

1. Load `schema.sql` and `seed_data.sql` into SQLite.  
2. Run queries from `queries.sql` to reproduce analysis.  
3. Open Power BI and connect to the database to visualize the dashboard.
