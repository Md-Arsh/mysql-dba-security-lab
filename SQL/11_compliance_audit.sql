-- ======================================================
-- Scenario 9: Compliance Audit
-- Situation:
-- A database auditor requires a full report of users,
-- privileges, authentication methods, and account status.
-- ======================================================


-- ------------------------------------------------------
-- Step 1: List all database users
-- ------------------------------------------------------

SELECT User, Host
FROM mysql.user;



-- ------------------------------------------------------
-- Step 2: Show global privileges of each user
-- ------------------------------------------------------

SELECT GRANTEE, PRIVILEGE_TYPE
FROM information_schema.user_privileges;



-- ------------------------------------------------------
-- Step 3: Show database-level privileges
-- ------------------------------------------------------

SELECT GRANTEE, TABLE_SCHEMA, PRIVILEGE_TYPE
FROM information_schema.schema_privileges;



-- ------------------------------------------------------
-- Step 4: Show authentication plugin used by each user
-- ------------------------------------------------------

SELECT User, Host, plugin
FROM mysql.user;



-- ------------------------------------------------------
-- Step 5: Identify locked and expired accounts
-- ------------------------------------------------------

SELECT User, Host, account_locked, password_expired
FROM mysql.user;



-- ------------------------------------------------------
-- Step 6: Check detailed privileges of a specific user
-- (Example: root user)
-- ------------------------------------------------------

SHOW GRANTS FOR 'root'@'localhost';



-- ======================================================
-- End of Scenario 9
-- Compliance Audit Report Generated
-- ======================================================