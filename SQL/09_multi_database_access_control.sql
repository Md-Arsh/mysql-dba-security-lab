-- =====================================================
-- Scenario 7: Multi Database Access Control
-- Situation:
-- A user requires different permissions on multiple databases.
--
-- Tasks:
-- 1. Read-only access to sales_db
-- 2. Read-write access to test_db
-- 3. No access to finance_db
-- 4. Design secure privilege model
-- =====================================================


-- ==========================================
-- Step 1: Create Databases
-- ==========================================

CREATE DATABASE IF NOT EXISTS sales_db;
CREATE DATABASE IF NOT EXISTS test_db;
CREATE DATABASE IF NOT EXISTS finance_db;


-- ==========================================
-- Step 2: Create Tables
-- ==========================================

-- Sales database table
USE sales_db;

CREATE TABLE IF NOT EXISTS sales (
    order_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    amount DECIMAL(10,2)
);


-- Test database table
USE test_db;

CREATE TABLE IF NOT EXISTS test_data (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    status VARCHAR(20)
);


-- Finance database table
USE finance_db;

CREATE TABLE IF NOT EXISTS salaries (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    salary DECIMAL(10,2)
);


-- ==========================================
-- Step 3: Insert Sample Data
-- ==========================================

INSERT INTO sales_db.sales VALUES
(1,'Laptop',75000),
(2,'Mobile',25000),
(3,'Tablet',30000);


INSERT INTO test_db.test_data VALUES
(1,'TestUser1','Active'),
(2,'TestUser2','Inactive'),
(3,'TestUser3','Active');


INSERT INTO finance_db.salaries VALUES
(101,'Arshad',150000),
(102,'Aman',80000),
(103,'Suraj',75000),
(104,'Akash',70000),
(105,'Ahmar',800000);


-- ==========================================
-- Step 4: Grant Read-only Access to sales_db
-- ==========================================

GRANT SELECT
ON sales_db.*
TO 'Dev'@'%';


-- ==========================================
-- Step 5: Grant Read-Write Access to test_db
-- ==========================================

GRANT SELECT, INSERT, UPDATE, DELETE
ON test_db.*
TO 'Dev'@'%';


-- ==========================================
-- Step 6: No Access to finance_db
-- ==========================================

-- No privileges granted on finance_db
-- Sensitive financial data remains protected


-- ==========================================
-- Step 7: Verify Privileges
-- ==========================================

SHOW GRANTS FOR 'Dev'@'%';


-- ==========================================
-- Step 8: Test Access Control
-- ==========================================

-- Allowed: Read from sales_db
SELECT * FROM sales_db.sales;

-- Allowed: Read and write in test_db
SELECT * FROM test_db.test_data;

-- Blocked: No access to finance_db
SELECT * FROM finance_db.salaries;

-- ==========================================
-- End of Scenario 7
-- ==========================================