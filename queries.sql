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

-- Categories Ranked By Revenue
WITH product_revenue AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(o.total_amount) AS total_revenue
    FROM Orders o
    JOIN Products p ON o.product_id = p.product_id
    GROUP BY p.product_id, p.product_name, p.category
)
SELECT
    product_id,
    product_name,
    category,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM product_revenue;

-- Customer order totals, spending, AOV, and spending rank
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(order_id) AS total_orders,
        SUM(total_amount) AS total_spent
    FROM Orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_orders,
    total_spent,
    ROUND(total_spent * 1.0 / total_orders,2) AS avg_order_value,
    RANK() OVER (ORDER BY total_spent DESC) AS top_customer_rank
FROM customer_orders;
