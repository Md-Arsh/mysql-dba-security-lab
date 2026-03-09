-- =====================================================
-- Scenario 8: Temporary Contractor Access
-- =====================================================
-- Situation:
-- A contractor needs temporary and limited database access.
--
-- Tasks:
-- 1. Create a user with limited privileges
-- 2. Restrict login to a specific host
-- 3. Set account expiration
-- 4. Add comment for identification
-- =====================================================


-- ==========================================
-- Step 1: Create Contractor User
-- ==========================================
-- The contractor can only login from localhost
-- (simulates host-based access restriction)

CREATE USER 'contractor_user'@'localhost'
IDENTIFIED BY 'Temp@123';


-- ==========================================
-- Step 2: Grant Limited Privileges
-- ==========================================
-- Contractor receives read-only access to sales_db

GRANT SELECT
ON sales_db.*
TO 'contractor_user'@'localhost';


-- ==========================================
-- Step 3: Set Password Expiry
-- ==========================================
-- Contractor access will expire after 30 days

ALTER USER 'contractor_user'@'localhost'
PASSWORD EXPIRE INTERVAL 30 DAY;


-- ==========================================
-- Step 4: Add Comment for Identification
-- ==========================================
-- Helps DBAs identify temporary accounts

ALTER USER 'contractor_user'@'localhost'
COMMENT 'Temporary contractor access for sales reporting project';


-- ==========================================
-- Step 5: Verify User Creation
-- ==========================================

SELECT user, host
FROM mysql.user
WHERE user = 'contractor_user';


-- ==========================================
-- Step 6: Verify Granted Privileges
-- ==========================================

SHOW GRANTS FOR 'contractor_user'@'localhost';


-- ==========================================
-- Step 7: Test Access (Manual Test)
-- ==========================================
-- Login as contractor_user and run:

-- Allowed query
SELECT * FROM sales_db.orders;

-- Blocked query (should fail)
INSERT INTO sales_db.orders VALUES
(106,'Arshlan','Laptop',50000.00);


-- ==========================================
-- Expected Result
-- ==========================================
-- SELECT queries → Allowed
-- INSERT queries → Access denied
-- Demonstrates read-only contractor access


-- ==========================================
-- Security Concepts Demonstrated
-- ==========================================
-- Temporary user account management
-- Host-based login restriction
-- Least privilege principle
-- Account lifecycle management
-- Access verification