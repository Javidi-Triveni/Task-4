-- Create Database 
CREATE DATABASE ecommerce;
USE ecommerce;

-- Creating Tables
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    country VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    discount DECIMAL(5,2),
    payment_method VARCHAR(50),
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(product_id) REFERENCES products(product_id)
);

-- Inserting sample data
INSERT INTO users VALUES
(1, 'Alice', 'alice@example.com', 'USA', '2024-01-10'),
(2, 'Bob', 'bob@example.com', 'India', '2024-03-15'),
(3, 'Charlie', 'charlie@example.com', 'UK', '2024-05-22'),
(4, 'Diana', 'diana@example.com', 'Canada', '2024-06-05');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 800, 20),
(102, 'Phone', 'Electronics', 500, 35),
(103, 'Headphones', 'Accessories', 50, 100),
(104, 'Tablet', 'Electronics', 300, 15);

INSERT INTO orders VALUES
(201, 1, 101, 1, '2025-09-01', 50, 'Credit Card'),
(202, 2, 102, 2, '2025-09-02', NULL, 'UPI'),
(203, 1, 103, 3, '2025-09-05', 10, 'PayPal'),
(204, 3, 101, 1, '2025-09-07', NULL, 'Debit Card'),
(205, 4, 104, 2, '2025-09-10', 20, 'Credit Card');


-- Queries

-- Simple SELECT
SELECT * FROM users;
SELECT * FROM products;
Select * FROM orders;

-- WHERE and ORDER BY
SELECT * FROM products WHERE price > 100 ORDER BY price DESC;

-- Aggregate Functions
SELECT 
    COUNT(*) AS total_orders,
    SUM(quantity) AS total_items,
    AVG(quantity) AS avg_items_per_order,
    MAX(price) AS max_price,
    MIN(price) AS min_price
FROM orders o
JOIN products p ON o.product_id = p.product_id;

-- JOINS
-- INNER JOIN
SELECT u.name, p.name AS product, o.quantity, o.order_date
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
INNER JOIN products p ON o.product_id = p.product_id;

-- LEFT JOIN
SELECT u.name, o.order_id, o.quantity
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id;

-- RIGHT JOIN 
SELECT u.name, o.order_id, o.quantity
FROM users u
RIGHT JOIN orders o ON u.user_id = o.user_id;

-- Subquery Example
SELECT name
FROM users
WHERE user_id IN (
    SELECT user_id
    FROM orders
    GROUP BY user_id
    HAVING SUM(quantity) > 2
);

-- HAVING Example
SELECT p.category, SUM(o.quantity) AS total_sold
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(o.quantity) > 2;

-- View Example
CREATE OR REPLACE VIEW revenue_per_user AS
SELECT u.user_id, u.name, SUM(p.price * o.quantity - COALESCE(o.discount, 0)) AS total_revenue
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN products p ON o.product_id = p.product_id
GROUP BY u.user_id, u.name;

-- Select from view
SELECT * FROM revenue_per_user;

-- Handling NULL values
SELECT order_id, COALESCE(discount, 0) AS discount_applied
FROM orders;

-- Indexing for optimization
CREATE INDEX idx_orders_userid ON orders(user_id);
CREATE INDEX idx_orders_productid ON orders(product_id);
-- This query will now be faster because of the index
SELECT order_id, order_date FROM Orders WHERE user_id = 1;