/*
========================================================
STORED PROCEDURE SCRIPT
(Load Bronze layer:source file-bronze)
========================================================
This stored procedure loads file  into bronze layer from csv.files
It perfoms:
-Truncates before loading
-'BULK' insert command to load files from source csv
*/

CREATE OR ALTER PROCEDURE Bronze.load_bronze AS
BEGIN
	--SET NOCOUNT ON;(ONLY WHEN YOU MEAN IT)
	DECLARE @start_time DATETIME,
			@end_time DATETIME,
			@rows INT
	BEGIN TRY
	PRINT '#============LOADING THE BRONZE LAYER===============#';
	
	--For crm(customers)
	PRINT '************************************';
	PRINT SPACE(5)+'Loading CRM Tables';
	PRINT '************************************';

	SET @start_time=GETDATE();
	PRINT '--> Truncating:Bronze.crm_cust_info';
	TRUNCATE TABLE Bronze.crm_cust_info;

	PRINT '--> Inserting:Bronze.crm_cust_info';
	BULK INSERT Bronze.crm_cust_info
	FROM 'C:\EV_Project_data_2024\crm\crm_cust_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK --locks the table while loading
	);
	SET @rows=@@ROWCOUNT;
	PRINT '--> Rows Inserted: ' + CAST(@rows AS NVARCHAR);

	PRINT '--> Truncating:Bronze.crm_manufacturer';
	TRUNCATE TABLE Bronze.crm_manufacturer;

	PRINT '--> Inserting:Bronze.crm_manufacturer';
	BULK INSERT Bronze.crm_manufacturer
	FROM 'C:\EV_Project_data_2024\crm\dim_manufacturer.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @rows=@@ROWCOUNT;
	PRINT '--> Rows Inserted: ' + CAST(@rows AS NVARCHAR);

	SET @end_time=GETDATE();
	PRINT '--> Load Duration :' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' Seconds';

	--For erp(sales)
	PRINT '************************************';
	PRINT SPACE(5)+'Loading ERP Tables';
	PRINT '************************************';
	SET @start_time=GETDATE();
	
	PRINT '--> Truncating:Bronze.erp_car_sales';
	TRUNCATE TABLE Bronze.erp_car_sales;

	PRINT '--> Inserting:Bronze.erp_car_sales';
	BULK INSERT Bronze.erp_car_sales
	FROM 'C:\EV_Project_data_2024\erp\erp_car_sales.csv'
	WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
	SET @rows=@@ROWCOUNT;
	PRINT '--> Rows Inserted: ' + CAST(@rows AS NVARCHAR);

	PRINT '--> Truncating:Bronze.erp_dim_date';
	TRUNCATE TABLE Bronze.erp_dim_date;

	PRINT '--> Inserting:Bronze.erp_dim_date';
	BULK INSERT Bronze.erp_dim_date
	FROM 'C:\EV_Project_data_2024\erp\dim_date.csv'
	WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
	SET @rows=@@ROWCOUNT;
	PRINT '--> Rows Inserted: ' + CAST(@rows AS NVARCHAR);

	PRINT '--> Truncating:Bronze.erp_ev_sales_brand';
	TRUNCATE TABLE Bronze.erp_ev_sales_brand;

	PRINT '--> Inserting:Bronze.erp_ev_sales_brand';
	BULK INSERT Bronze.erp_ev_sales_brand
	FROM 'C:\EV_Project_data_2024\erp\fact_ev_sales_brand.csv'
	WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
	SET @rows=@@ROWCOUNT;
	PRINT '--> Rows Inserted: ' + CAST(@rows AS NVARCHAR);

	SET @end_time=GETDATE();
	PRINT '--> Load Duration :' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' Seconds';

	END TRY
	BEGIN CATCH 
	PRINT '+++++++++++++++++++++++++++++++++++++++++';
	PRINT 'ERROR OCCURED DURING LOADING';
	PRINT 'Error Message :'+ ERROR_MESSAGE();
	PRINT 'Error Number :'+ CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error State :'+ CAST(ERROR_STATE() AS NVARCHAR);
	PRINT '+++++++++++++++++++++++++++++++++++++++++';
	END CATCH
END

