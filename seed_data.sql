-- Orders table
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    order_date TEXT,
    total_amount REAL,
    FOREIGN KEY(customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY(product_id) REFERENCES Products(product_id)
);

-- Insert customers
INSERT INTO Customers (first_name, last_name, email) VALUES
('Adam', 'Lumbley', 'adam@example.com'),
('John', 'Doe', 'john@example.com'),
('Jane', 'Smith', 'jane@example.com'),
('Mike', 'Johnson', 'mike@example.com'),
('Emily', 'Davis', 'emily@example.com');

-- Insert products
INSERT INTO Products (product_name, category, price) VALUES
('Whey Protein', 'Protein', 49.99),
('Whey Isolate', 'Protein', 59.99),
('Creatine Monohydrate', 'Supplements', 29.99),
('BCAA', 'Supplements', 34.99),
('Pre-Workout', 'Supplements', 39.99),
('Glutamine', 'Supplements', 24.99),
('Protein Bar', 'Snacks', 2.99),
('Omega-3 Fish Oil', 'Vitamins', 19.99);

-- Generate 600 random orders
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 600
),
random_orders AS (
    SELECT 
        n AS order_id,
        (ABS(RANDOM()) % 5) + 1 AS customer_id,  -- 5 customers
        (ABS(RANDOM()) % 8) + 1 AS product_id,   -- 8 products
        (ABS(RANDOM()) % 5) + 1 AS quantity,
        DATE('2026-01-01', '+' || (ABS(RANDOM()) % 365) || ' days') AS order_date
    FROM seq
)
