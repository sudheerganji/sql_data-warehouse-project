CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @batch_starttime DATETIME, @batch_endTime DATETIME;
		SET @batch_starttime=GETDATE();
		PRINT('============================================================')
		PRINT('Loading Bronze Layer')
		PRINT('============================================================')

		PRINT('------------------------------------------------------------')
		PRINT('Loading CRM TABLES')
		PRINT('------------------------------------------------------------')
		TRUNCATE TABLE bronze.crm_cust_info
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SELECT COUNT(*) FROM  bronze.crm_cust_info

		TRUNCATE TABLE bronze.crm_prd_info
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SELECT COUNT(*) FROM bronze.crm_prd_info

		TRUNCATE TABLE bronze.crm_sales_details
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SELECT COUNT(*) FROM bronze.crm_sales_details
		PRINT('------------------------------------------------------------')
		PRINT('Loading ERP TABLES')
		PRINT('------------------------------------------------------------')
		PRINT '>>Truncating erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SELECT COUNT(*) FROM bronze.erp_cust_az12


		TRUNCATE TABLE bronze.erp_loc_a101
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\SQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SELECT COUNT(*) FROM bronze.erp_loc_a101


		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\SQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2
	SET @batch_endtime=GETDATE();

	PRINT('Load Duration in Seconds'+ CAST(DATEDIFF(SECOND,@batch_endtime,@batch_starttime) AS NVARCHAR))+'Seconds'
END

EXEC bronze.load_bronze
