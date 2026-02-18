/*
============================
CREATE DATABASE AND SCHEMAS
============================
DISCLAIMER:
This script is intended for learning and local development purposes only.
It forcefully drops and recreates the 'DataWarehouse' database, which will
permanently delete all existing data and close active connections.

DO NOT run this script on production or shared environments.
Use only in controlled, non-production setups.
*/

USE master;
GO

--Drop and Recreate 'DataWarehouse' Database
IF Exists (SELECT 1 FROM sys.databases WHERE name='DataWarehouse')
BEGIN
  ALTER DATABSE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABSE DataWarehouse;
END;
GO

--Create DBWH

CREATE DATABASE DataWarehouse;
USE Datawarehouse;

--Create Schemas
CREATE SCHEMA Bronze;
GO
CREATE SCHEMA Silver;
GO
CREATE SCHEMA Gold;
