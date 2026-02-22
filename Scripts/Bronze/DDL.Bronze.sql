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

--T-SQL Auto create command if table doesn't exists
IF OBJECT_ID('Bronze.crm_cust_info','U' )IS NOT NULL
	DROP TABLE Bronze.crm_cust_info;
--BRONZE LAYER (CRM)
CREATE TABLE Bronze.crm_cust_info(
	country NVARCHAR(50),
	country_code NVARCHAR(10),
	continent NVARCHAR(20),
	public_cs BIGINT,
	fast_chg_stn BIGINT,
	cs_per_100km DECIMAL(6,2),
	avg_ev_price_usd DECIMAL(10,2),
	year INT,
	population_2024 DECIMAL(12,2),
	ev_stock_2024 BIGINT,
	gdp_per_capita_usd_2024 DECIMAL(12,2)
	);
IF OBJECT_ID('Bronze.crm_manufacturer','U' )IS NOT NULL
	DROP TABLE  Bronze.crm_manufacturer;
CREATE TABLE Bronze.crm_manufacturer(
	manufacturer_id INT,
	manufacturer NVARCHAR(50),
	hq_country_code NVARCHAR(10),
	primary_type NVARCHAR(10),
	global_sales_2024 BIGINT,
	global_sales_2025_estimate BIGINT,
	market_share_2024_pct DECIMAL(4,2),
	india_sales_2024 BIGINT,
	india_sales_2025_estimate BIGINT ,
	india_market_share_2024_pct DECIMAL(5,2)
	);

--T-SQL Auto create command if table doesn't exists
IF OBJECT_ID('Bronze.erp_car_sales','U' )IS NOT NULL
	DROP TABLE Bronze.erp_car_sales;
--BRONZE LAYER (ERP)
CREATE TABLE Bronze.erp_car_sales(
	Country NVARCHAR(50),
	Code NVARCHAR(10),
	Year INT,
	Electric_cars BIGINT,
	Non_electric_cars BIGINT
	);
IF OBJECT_ID('Bronze.erp_dim_date','U' )IS NOT NULL
	DROP TABLE Bronze.erp_dim_date;
CREATE TABLE Bronze.erp_dim_date(
	year INT,
	year_key INT,
	year_name NVARCHAR(10),
	is_current_year BIT,
	is_previous_year BIT,
	is_forecast BIT,
	has_brand_detail BIT
	);
IF OBJECT_ID('Bronze.erp_ev_sales_brand','U' )IS NOT NULL
	DROP TABLE Bronze.erp_ev_sales_brand;
CREATE TABLE Bronze.erp_ev_sales_brand(
	year INT,
	country_code NVARCHAR(10),
	manufacturer NVARCHAR(50),
	ev_sales BIGINT
	);


