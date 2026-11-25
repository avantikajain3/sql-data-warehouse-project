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
create database DataWarehouse;

use DataWarehouse;

create schema bronze;
go
create schema silver;
go
create schema gold;
go
