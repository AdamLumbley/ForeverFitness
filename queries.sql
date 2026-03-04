-- Month-over-Month (MoM) Revenue Analysis (Rounded to 0 decimals)
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
