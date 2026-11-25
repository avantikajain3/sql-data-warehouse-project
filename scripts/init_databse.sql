/* 
================================================
create databse and schemas
================================================

Script purpose :
This script creats a new database named 'DataWarehouse' after checking if it already exists.
If the database exists, it is droped and recreated. Additionally, the script sets up three schemas within the databse: 'bronze', 'silver', and 'gold'.

Warning;
 Running this script will drop the entire "DataWarehouse' database if it exists.
All data in the database will be permanently deleted. proceed with caution and ensure you have proper backups before running this script.
*/


use master ;
go

 -- Drop and recreate data warehouse database

 if exists (select 1 from sys.databases where name ='DataWarehouse')
 begin 
 alter database DataWarehouse set single_user with rollback immidiate;
drop database DataWarehouse;
End;
go

 -- create database 'DataWarehouse'
create database DataWarehouse;
go
 
use DataWarehouse;
go

 -- create schemas
 create schema bronze;
go
create schema silver;
go
create schema gold;
go
