-- ==========================================
-- Scenario 5: Privilege Misuse
-- Situation: Developer accidentally deleted a table
-- Goal:
-- 1. Check developer privileges
-- 2. Simulate dangerous privilege
-- 3. Remove dangerous privilege
-- 4. Apply least privilege principle
-- 5. Create a safe developer role
-- ==========================================


-- Step 1: Check current privileges of Developer
SHOW GRANTS FOR 'Dev'@'%';


-- Step 2: Simulate dangerous privilege (DROP)
-- This shows how a developer could delete a table
GRANT DROP
ON DemoDatabase.*
TO 'Dev'@'%';


-- Step 3: Verify privileges again
SHOW GRANTS FOR 'Dev'@'%';


-- Step 4: Remove dangerous privilege
REVOKE DROP
ON DemoDatabase.*
FROM 'Dev'@'%';


-- Step 5: Verify dangerous privilege removed
SHOW GRANTS FOR 'Dev'@'%';


-- Step 6: Apply Least Privilege Principle
-- Developers should normally have only SELECT, INSERT, UPDATE
REVOKE DELETE
ON DemoDatabase.*
FROM 'Dev'@'%';


-- Step 7: Verify privileges again
SHOW GRANTS FOR 'Dev'@'%';


-- Step 8: Create a safe developer role
CREATE ROLE developer_role;


-- Step 9: Grant safe privileges to the role
GRANT SELECT, INSERT, UPDATE
ON DemoDatabase.*
TO developer_role;


-- Step 10: Assign role to developer
GRANT developer_role TO 'Dev'@'%';


-- Step 11: Set default role
SET DEFAULT ROLE developer_role TO 'Dev'@'%';


-- Step 12: Verify role assignment
SHOW GRANTS FOR 'Dev'@'%';

-- ==========================================================
-- End of Scenario 5
-- ==========================================================