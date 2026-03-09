-- =========================================================
-- Scenario 6: Resource Abuse Protection
-- Situation:
-- A database user is running too many heavy queries which
-- slows down the database server.
--
-- Goal:
-- 1. Monitor running queries
-- 2. Limit queries per hour
-- 3. Limit updates per hour
-- 4. Limit connection attempts
-- 5. Limit concurrent connections
-- 6. Verify resource limits applied
-- =========================================================


-- ---------------------------------------------------------
-- Step 1: Monitor currently running queries
-- This command shows active sessions and running queries.
-- DBAs use this to detect heavy or long-running queries.
-- ---------------------------------------------------------

SHOW PROCESSLIST;



-- ---------------------------------------------------------
-- Step 2: Limit number of queries a user can execute per hour
-- This prevents users from flooding the database with queries.
-- ---------------------------------------------------------

ALTER USER 'Dev'@'%'
WITH MAX_QUERIES_PER_HOUR 100;



-- ---------------------------------------------------------
-- Step 3: Limit number of update operations per hour
-- Helps control heavy write operations.
-- ---------------------------------------------------------

ALTER USER 'Dev'@'%'
WITH MAX_UPDATES_PER_HOUR 50;



-- ---------------------------------------------------------
-- Step 4: Limit number of connections per hour
-- Prevents users from repeatedly connecting to the database.
-- ---------------------------------------------------------

ALTER USER 'Dev'@'%'
WITH MAX_CONNECTIONS_PER_HOUR 50;



-- ---------------------------------------------------------
-- Step 5: Limit concurrent connections
-- Restricts how many simultaneous sessions a user can open.
-- This protects the server from overload.
-- ---------------------------------------------------------

ALTER USER 'Dev'@'%'
WITH MAX_USER_CONNECTIONS 5;



-- ---------------------------------------------------------
-- Step 6: Monitor running queries again
-- This helps verify current activity after limits are applied.
-- ---------------------------------------------------------

SHOW PROCESSLIST;



-- ---------------------------------------------------------
-- Step 7: Verify resource limits applied to the user
-- The mysql.user table stores resource limits for accounts.
-- ---------------------------------------------------------

SELECT user, host,
       max_questions,
       max_updates,
       max_connections,
       max_user_connections
FROM mysql.user
WHERE user = 'Dev';



-- =========================================================
-- End of Scenario 6
-- =========================================================