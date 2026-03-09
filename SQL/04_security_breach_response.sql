-- Scenario 2: Security Breach Response
-- Situation: Suspicious login detected for the finance_admin user.
-- Objective: Secure the account, audit privileges, reset credentials,
-- and restore access after verification.


-- Step 1: Create the finance_admin user (if not already created)
-- This user represents a finance department administrator.
CREATE USER 'finance_admin'@'%' IDENTIFIED BY 'Finance@123';


-- Step 2: Grant basic privileges required for finance operations
-- The user can read and modify data in the company_db database.
GRANT SELECT, INSERT, UPDATE ON company_db.* 
TO 'finance_admin'@'%';


-- Step 3: Lock the user account immediately
-- This prevents any further login attempts while the issue is investigated.
ALTER USER 'finance_admin'@'%' ACCOUNT LOCK;


-- Step 4: Check current privileges assigned to the user
-- This helps the DBA audit what level of access the account currently has.
SHOW GRANTS FOR 'finance_admin'@'%';


-- Step 5: Reset the user password with a stronger secure password
-- This ensures any compromised credentials become invalid.
ALTER USER 'finance_admin'@'%'
IDENTIFIED BY 'Secure@12345';


-- Step 6: Switch to a stronger authentication plugin
-- caching_sha2_password provides improved password security in MySQL 8.
ALTER USER 'finance_admin'@'%'
IDENTIFIED WITH caching_sha2_password
BY 'Secure@12345';


-- Step 7: Unlock the account after security verification
-- Once the investigation is complete, the user can safely access the system again.
ALTER USER 'finance_admin'@'%' ACCOUNT UNLOCK;