
Task 4 - SQL for Data Analysis

 📌 Overview

The work includes:
- Creating a sample E-commerce database (`users`, `products`, `orders`).
- Writing SQL queries using `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`.
- Performing **JOINs** (INNER, LEFT, RIGHT, FULL OUTER).
- Using **aggregate functions** (`SUM`, `AVG`, `COUNT`, `MAX`, `MIN`).
- Writing **subqueries** and creating **views**.
- Handling **NULL values** with `COALESCE`.
- Optimizing queries using **indexes**.



🛠 Tools Used
- Database: MySQL 
- App:  
  - MySQL Workbench
 


🚀 Setup Instructions
1. Open your SQL tool (MySQL Workbench / DB Browser for SQLite).  
2. Create a new database (if MySQL/PostgreSQL):  
   ```sql
   CREATE DATABASE ecommerce_db;
   USE ecommerce_db;
   ```  
3. Run the script: `Task 4'.  



📊 Example Queries
- **Total orders and average items per order**  
  ```sql
  SELECT COUNT(*) AS total_orders, AVG(quantity) AS avg_items
  FROM orders;
  ```

- **Revenue per user (using View)**  
  ```sql
  SELECT * FROM revenue_per_user;
  ```

- **Users with more than 2 items purchased (Subquery)**  
  ```sql
  SELECT name
  FROM users
  WHERE user_id IN (
      SELECT user_id
      FROM orders
      GROUP BY user_id
      HAVING SUM(quantity) > 2
  );
  ```


