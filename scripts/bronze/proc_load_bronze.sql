/*
================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
================================================================================
Script Purpose:
This stored procedure loads data into the 'bronze' schema from external CSV files.
It performs following actons:
- Truncate the bronze table before loading the data.
- Uses the bulk insert command to load data from csv files to bronze tables.

Perimeters:
 None.
This stored procedure dose not accept any perimeters or return any values.

Usage example:
 EXEC bronze.load bronze;
================================================================================
*/




CREATE OR ALTER PROCEDURE bronze.lode_bronze
AS
BEGIN

DECLARE @start_time DATETIME, @end_time DATETIME;

BEGIN TRY


SET @start_time=GETDATE(); 
        PRINT '===========================================';
		PRINT 'Loading Bronze layer';
		PRINT '===========================================';
		
		PRINT '-------------------------------------------';
		PRINT 'Loading crm files';
		PRINT '-------------------------------------------';

		SET @start_time =GETDATE();
		PRINT '>>Truncating table:bronze.crm_cust_info <<'
		TRUNCATE TABLE bronze.crm_cust_info;
		
		PRINT '>>Inserting table:bronze.crm_cust_info <<'
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\DELL\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH 
		(
		FIRSTROW=2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+ 'seconds';
		PRINT '------------------------';


		SET @start_time =GETDATE();
		PRINT '>>Truncating table:bronze.crm_prd_info<<'
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>>Inserting table:bronze.crm_cust_info <<'

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\DELL\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH 
		(
		FIRSTROW=2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) +'seconds';
		PRINT '----------------';


		SET @start_time =GETDATE();
		PRINT '>>Truncating table:bronze.crm_sales_details <<'
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>>Truncating table:bronze.crm_sales_details <<'

		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\DELL\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH 
		(
		FIRSTROW=2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		SET @end_time= GETDATE();
		PRINT '>>Load duration:' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) +'seconds';
		PRINT '---------------------';




		PRINT '-------------------------------------------';
		PRINT 'Loading ERP files';
		PRINT '-------------------------------------------';

		
		SET @start_time= GETDATE();
		PRINT '>>Truncating table:bronze.erp_cust_az12 <<';
		TRUNCATE TABLE bronze.erp_cust_az12;

		
		PRINT '>>Inserting table:bronze.erp_cust_az12 <<';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\DELL\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH 
		(
		FIRSTROW=2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		SET @end_time= GETDATE();
		PRINT 'LOADING DURARTION:'+ CAST(DATEDIFF(second,@start_time,@end_time)AS VARCHAR)+ 'SECONDS';
		PRINT '---------------------';


		SET @start_time= GETDATE();
		PRINT '>>Truncating table:bronze.erp_loc_a101 <<';
		TRUNCATE TABLE bronze.erp_loc_a101;
		
		PRINT '>>Inserting table:bronze.erp_loc_a101 <<';
		
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\DELL\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH 
		(
		FIRSTROW=2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		SET @end_time= GETDATE();
		PRINT 'LOADING DURARTION:'+ CAST(DATEDIFF(second,@start_time,@end_time)AS VARCHAR)+ 'SECONDS';
		PRINT '---------------------';



		SET @start_time= GETDATE();
		
		PRINT '>>Truncating table:bronze.erp_px_cat_g1v2 <<';
		
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		
		PRINT '>>Inserting table:bronze.erp_px_cat_g1v2 <<';

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\DELL\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH 
		(
		FIRSTROW=2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		SET @end_time= GETDATE();
		PRINT 'LOADING DURARTION:'+ CAST(DATEDIFF(second,@start_time,@end_time)AS VARCHAR)+ 'SECONDS';
		PRINT '---------------------';

		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+ 'seconds';
		PRINT '------------------------';

		END TRY
		
		BEGIN CATCH 
		PRINT '=====================================================';
		PRINT 'ERROR OCCURED WHILE LOADIN A BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message'+ CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message'+ CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=====================================================';

		


		END CATCH
END
