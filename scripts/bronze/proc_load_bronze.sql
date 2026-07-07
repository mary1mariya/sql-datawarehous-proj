/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_t DATETIME, @end_t DATETIME, @start_batch DATETIME, @end_batch DATETIME;
	BEGIN TRY
		PRINT '==============================================================================================';
		PRINT 'LOADING BRONZE LAYER ';
		PRINT '==============================================================================================';

		PRINT '-----------------------------------------------';
		PRINT 'loading CRM tables';
		PRINT '-----------------------------------------------';

		SET @start_t = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\asus\OneDrive\Documentos\crs\DS trck\projects\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW= 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_t = GETDATE()
		PRINT 'load durat: ' + CAST(DATEDIFF(second, @start_t, @end_t) AS VARCHAR) + ' seconds';
		PRINT '--------------------';

		SET @start_t = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\asus\OneDrive\Documentos\crs\DS trck\projects\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW= 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		
		SET @end_t = GETDATE()
		PRINT 'load durat: ' + CAST(DATEDIFF(second, @start_t, @end_t) AS VARCHAR) + ' seconds';
		PRINT '--------------------';

		SET @start_t = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\asus\OneDrive\Documentos\crs\DS trck\projects\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW= 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_t = GETDATE()
		PRINT 'load durat: ' + CAST(DATEDIFF(second, @start_t, @end_t) AS VARCHAR) + ' seconds';
		PRINT '--------------------';

		PRINT '-----------------------------------------------';
		PRINT 'loading ERP tables';
		PRINT '-----------------------------------------------';

		SET @start_t = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\asus\OneDrive\Documentos\crs\DS trck\projects\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW= 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_t = GETDATE()
		PRINT 'load durat: ' + CAST(DATEDIFF(second, @start_t, @end_t) AS VARCHAR) + ' seconds';
		PRINT '--------------------';

		SET @start_t = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\asus\OneDrive\Documentos\crs\DS trck\projects\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW= 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_t = GETDATE()
		PRINT 'load durat: ' + CAST(DATEDIFF(second, @start_t, @end_t) AS VARCHAR) + ' seconds';
		PRINT '--------------------';

		SET @start_t = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\asus\OneDrive\Documentos\crs\DS trck\projects\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW= 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_t = GETDATE()
		PRINT 'load durat: ' + CAST(DATEDIFF(second, @start_t, @end_t) AS VARCHAR) + ' seconds';
		PRINT '--------------------';

		SET @end_batch = GETDATE();
		PRINT '--------------------------------';
		PRINT 'full bronze batch load durat: ' + CAST(DATEDIFF(second, @start_batch, @end_batch) AS VARCHAR) + ' seconds';
		PRINT '--------------------------------';
	END TRY
	BEGIN CATCH
		PRINT '=========================================';
		PRINT 'ERROR LOADING BRONZE LAYER';
		PRINT 'Error messag' + ERROR_MESSAGE();
		PRINT 'Error messag' + CAST(ERROR_NUMBER() AS NVARCHAR );
		PRINT 'Error messag' + CAST(ERROR_STATE() AS NVARCHAR );
		PRINT '=========================================';
	END CATCH
END

