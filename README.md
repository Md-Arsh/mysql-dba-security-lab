# MySQL DBA Security Lab

## Project Overview

This project is a hands-on MySQL administration lab focused on database security, access control, authentication management, and enterprise-level password enforcement.

It demonstrates practical Database Administrator (DBA) responsibilities including:

* Role-Based Access Control (RBAC)
* Privilege assignment and auditing
* Security breach response
* Strong password policy enforcement
* Account lock protection against brute-force attacks
* Authentication plugin migration (MySQL 5.7 → MySQL 8)
* Resource abuse protection
* Multi-database access control
* Temporary contractor access management
* Compliance auditing and privilege verification
* High-security database architecture

This lab simulates a real-world organizational database environment where different users require controlled access to databases and resources.

---

## ⚙️ Technologies Used

- MySQL 8.0
- SQL
- MySQL Security & Access Control
- Role-Based Access Control (RBAC)
- Password Policy Enforcement
- Linux Environment
- Git & GitHub

---

## Environment

MySQL Version: 8.0+
Operating System: Linux (Ubuntu)
Authentication Plugin: caching_sha2_password

---

## Project Structure

MYSQL_DBA_SECURITY_LAB/

SQL/
01_database_setup.sql
02_user_creation.sql
03_rbac_privileges.sql
04_security_breach_response.sql
05_password_policy_enforcement.sql
06_authentication_plugin_migration.sql
07_privilege_misuse_prevention.sql
08_resource_abuse_protection.sql
09_multi_database_access_control.sql
10_temporary_contractor_access.sql
11_compliance_audit.sql
12_bank_security_model.sql
13_verification_queries.sql

ProjectScreenshots/

README.md

---

## Databases Used

dev_db,
analytics_db,
DemoDatabase,
DemoDatabaseTwo,
sales_db,
test_db,
finance_db,

Example command

SHOW DATABASES;

---

## Users and Organizational Roles

Super_Admin – Full administrative control
DBA – Database administration tasks
Dev – Development operations
Analyst – Read-only analytical access
Intern – Limited training access
Finance_Admin – Finance department operations
contractor_user – Temporary contractor access

Example user creation

CREATE USER 'DBA'@'%' IDENTIFIED BY 'Dev@123';
CREATE USER 'Dev'@'%' IDENTIFIED BY 'Dev@123';
CREATE USER 'Analyst'@'%' IDENTIFIED BY 'Analyst@123';
CREATE USER 'Intern'@'localhost' IDENTIFIED BY 'Intern@123';

---

# Scenario 1 — Role-Based Privilege Assignment (RBAC)

GRANT SELECT, INSERT, UPDATE, DELETE
ON DemoDatabase.*
TO 'Dev'@'%';

GRANT SELECT
ON DemoDatabaseTwo.*
TO 'Analyst'@'%';

GRANT SELECT
ON DemoDatabase.*
TO 'Intern'@'localhost';

Verification

SHOW GRANTS FOR 'Dev'@'%';
SHOW GRANTS FOR 'Analyst'@'%';
SHOW GRANTS FOR 'Intern'@'localhost';

---

# Scenario 2 — Security Breach Response

CREATE USER 'Finance_Admin'@'%' IDENTIFIED BY 'Finance#123';

GRANT SELECT, INSERT, UPDATE
ON DemoDatabase.*
TO 'Finance_Admin'@'%';

ALTER USER 'Finance_Admin'@'%' ACCOUNT LOCK;

SHOW GRANTS FOR 'Finance_Admin'@'%';

ALTER USER 'Finance_Admin'@'%'
IDENTIFIED BY 'Adabc@456';

ALTER USER 'Finance_Admin'@'%'
IDENTIFIED WITH caching_sha2_password
BY 'Adabc@456';

ALTER USER 'Finance_Admin'@'%' ACCOUNT UNLOCK;

---

# Scenario 3 — Password Policy Enforcement

INSTALL COMPONENT 'file://component_validate_password';

SET GLOBAL validate_password.policy = STRONG;
SET GLOBAL validate_password.length = 12;

SET GLOBAL validate_password.mixed_case_count = 1;
SET GLOBAL validate_password.number_count = 1;
SET GLOBAL validate_password.special_char_count = 1;

ALTER USER 'Dev'@'%' PASSWORD EXPIRE INTERVAL 60 DAY;

SET GLOBAL password_history = 5;
SET GLOBAL password_reuse_interval = 365;

ALTER USER 'Dev'@'%'
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LOCK_TIME 1;

---

# Scenario 4 — Authentication Plugin Migration

SELECT user, host, plugin FROM mysql.user;

ALTER USER 'Dev'@'%'
IDENTIFIED WITH mysql_native_password
BY 'Raza#786';

SELECT user, host, plugin
FROM mysql.user
WHERE user='Dev';

ALTER USER 'Dev'@'%'
IDENTIFIED WITH caching_sha2_password
BY 'Raza#786';

---

# Scenario 5 — Privilege Misuse Prevention

SHOW GRANTS FOR 'Dev'@'%';

GRANT DROP ON DemoDatabase.* TO 'Dev'@'%';

REVOKE DROP ON DemoDatabase.* FROM 'Dev'@'%';

REVOKE DELETE ON DemoDatabase.* FROM 'Dev'@'%';

CREATE ROLE developer_role;

GRANT SELECT, INSERT, UPDATE
ON DemoDatabase.*
TO developer_role;

GRANT developer_role TO 'Dev'@'%';

SET DEFAULT ROLE developer_role TO 'Dev'@'%';

---

# Scenario 6 — Resource Abuse Protection

SHOW PROCESSLIST;

ALTER USER 'Dev'@'%' WITH MAX_QUERIES_PER_HOUR 100;
ALTER USER 'Dev'@'%' WITH MAX_UPDATES_PER_HOUR 50;
ALTER USER 'Dev'@'%' WITH MAX_CONNECTIONS_PER_HOUR 50;
ALTER USER 'Dev'@'%' WITH MAX_USER_CONNECTIONS 5;

SELECT user, host,
max_questions,
max_updates,
max_connections,
max_user_connections
FROM mysql.user
WHERE user='Dev';

---

# Scenario 7 — Multi Database Access Control

GRANT SELECT ON sales_db.* TO 'Dev'@'%';

GRANT SELECT, INSERT, UPDATE, DELETE
ON test_db.*
TO 'Dev'@'%';

Allowed

SELECT * FROM sales_db.orders;
SELECT * FROM test_db.test_data;

Blocked

SELECT * FROM finance_db.salaries;

Expected error

ERROR 1142 (42000): SELECT command denied

---

# Scenario 8 — Temporary Contractor Access

CREATE USER 'contractor_user'@'localhost' IDENTIFIED BY 'Temp@123';

GRANT SELECT ON sales_db.* TO 'contractor_user'@'localhost';

ALTER USER 'contractor_user'@'localhost'
PASSWORD EXPIRE INTERVAL 30 DAY;

ALTER USER 'contractor_user'@'localhost'
COMMENT 'Temporary contractor access for sales reporting project';

SHOW GRANTS FOR 'contractor_user'@'localhost';

Allowed

SELECT * FROM sales_db.orders;

Blocked

INSERT INTO sales_db.orders VALUES
(106,'Arshlan','Laptop',50000);

Expected result

ERROR 1142 (42000): INSERT command denied

---

# Scenario 9 — Compliance Audit

A database auditor requires a full compliance report of database users, privileges, authentication methods, and account status.

SELECT User, Host FROM mysql.user;

SELECT GRANTEE, PRIVILEGE_TYPE
FROM information_schema.user_privileges;

SELECT GRANTEE, TABLE_SCHEMA, PRIVILEGE_TYPE
FROM information_schema.schema_privileges;

SELECT User, Host, plugin
FROM mysql.user;

SELECT User, Host, account_locked, password_expired
FROM mysql.user;

SHOW GRANTS FOR 'root'@'localhost';

---

# Scenario 10 — High Security Banking Database

Situation: Design a bank-grade MySQL security model.

Tasks

* Enforce encrypted SSL login
* Disable remote root login
* Provide limited DBA access
* Apply strict password policy
* Enable monitoring and auditing

Verify SSL

SHOW VARIABLES LIKE '%ssl%';

Require encrypted connections

ALTER USER 'DBA'@'%' REQUIRE SSL;
ALTER USER 'Dev'@'%' REQUIRE SSL;

Check root login restriction

SELECT user, host FROM mysql.user WHERE user='root';

Create limited DBA role

CREATE ROLE limited_dba;

GRANT SELECT, INSERT, UPDATE, DELETE,
CREATE, ALTER, INDEX,
CREATE VIEW, SHOW VIEW,
CREATE ROUTINE, ALTER ROUTINE,
EVENT, TRIGGER
ON *.*
TO limited_dba;

Create secure DBA user

CREATE USER 'bank_dba'@'%' IDENTIFIED BY 'SecureDBA@123';

GRANT limited_dba TO 'bank_dba'@'%';

SET DEFAULT ROLE limited_dba FOR 'bank_dba'@'%';

SHOW GRANTS FOR 'bank_dba'@'%';

Apply strict password policy

SET GLOBAL validate_password.policy = STRONG;
SET GLOBAL validate_password.length = 14;
SET GLOBAL validate_password.number_count = 2;
SET GLOBAL validate_password.mixed_case_count = 1;
SET GLOBAL validate_password.special_char_count = 2;

SET GLOBAL password_history = 10;
SET GLOBAL password_reuse_interval = 365;

ALTER USER 'bank_dba'@'%'
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LOCK_TIME 2;

Enable monitoring and auditing

SET GLOBAL general_log = 'ON';
SET GLOBAL log_output = 'TABLE';

SELECT * FROM mysql.general_log
ORDER BY event_time DESC
LIMIT 10;

SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 2;

SHOW VARIABLES LIKE 'slow_query_log';

Security verification

SELECT user, host, plugin FROM mysql.user;

SELECT user, host, account_locked FROM mysql.user;

SHOW PROCESSLIST;

---

# Security Concepts Demonstrated

Role-Based Access Control (RBAC)
Least Privilege Principle
Privilege auditing
Security breach response
Password policy enforcement
Authentication plugin migration
Resource monitoring
Multi-database access control
Temporary access management
Compliance auditing and security verification
High-security banking database architecture

---

# Skills Demonstrated

MySQL User Management
Privilege Management
Database Security Configuration
Password Policy Implementation
Authentication Plugin Management
Query Monitoring and Resource Control
Multi-database access management
Temporary user access management
Incident response handling
Database compliance auditing
Enterprise database security implementation

---

# Conclusion

This MySQL DBA Security Lab demonstrates practical database administration tasks and security best practices through multiple real-world scenarios.

The project showcases how DBAs manage user access, enforce security policies, monitor system resources, and protect sensitive data across multiple databases.

This hands-on project provides practical experience in MySQL security, authentication, privilege management, monitoring, and enterprise-level database administration practices.

---
## 🔐 Security Scenarios Implemented

1. Database Setup and Environment Configuration
2. MySQL User Creation and Management
3. Role-Based Access Control (RBAC)
4. Security Breach Response
5. Password Policy Enforcement
6. Authentication Plugin Migration
7. Privilege Misuse Prevention
8. Resource Abuse Protection
9. Multi-Database Access Control
10. Temporary Contractor Access
11. Compliance Audit Logging
12. Bank-Grade Security Model
13. Security Verification Queries
