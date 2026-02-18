/*
============================
CREATE BRONZE LAYER TABLES
============================
DISCLAIMER:
This script creates tables in bronze schema. It drops table if they already exists 
This redefines ddl structure of the table.
Written in SSMS with some part written in 'T-sql'
DO NOT run this script after checking if you dont want to lose data.
*/

-- T-SQL Auto create command if table doesn't exists

IF OBJECT_ID('Bronze.crm_cust_info','U' )IS NOT NULL
	DROP TABLE Bronze.crm_cust_info;
GO
--BRONZE LAYER (CRM)
CREATE TABLE Bronze.crm_cust_info(
	country NVARCHAR(50),
	country_code NVARCHAR(10),
	continent NVARCHAR(20),
	public_cs BIGINT,
	fast_chg_stn BIGINT,
	cs_per_100km DECIMAL(6,2),
	avg_ev_price_usd NUMERIC(10,2),
	year INT,
	population_2024 NUMERIC(12,2),
	ev_stock_2024 BIGINT,
	gdp_per_capita_usd_2024 DECIMAL(12,2)
);
--T-SQL Auto create command if table doesn't exists
IF OBJECT_ID('Bronze.erp_car_sales','U' )IS NOT NULL
	DROP TABLE Bronze.erp_car_sales;
GO
--BRONZE LAYER (ERP)
CREATE TABLE Bronze.erp_car_sales(
Country NVARCHAR(50),
Code NVARCHAR(10),
Year INT,
Electric_cars BIGINT,
Non_electric_cars BIGINT
);

