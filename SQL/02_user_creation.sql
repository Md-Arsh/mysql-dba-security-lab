-- User Creation

-- Super Admin (Full Control)
CREATE USER 'Super_Admin'@'%' IDENTIFIED BY 'Super@321'; 

-- DBA (Database Management)
CREATE USER 'DBA'@'%' IDENTIFIED BY 'DBA@421';

-- Developer (Development Work)
CREATE USER 'Dev'@'%' IDENTIFIED BY 'Dev@351';

-- Analyst (Read-only Data Analysis)
CREATE USER 'Analyst'@'%' IDENTIFIED BY 'Analyst@621';

-- Intern (Limited Access from Localhost)
CREATE USER 'Inter'@'localhost' IDENTIFIED BY 'Intern@121';