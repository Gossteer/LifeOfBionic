use [Life_of_Bionic]  --Добавление производителя
go 
create procedure [Add_Manufacturer]
@N_Manufacturer varchar (100),
@Adress varchar (100),
@Mail varchar (50),
@Manufacturer_Logical_Delete bit
as
insert into [dbo].[Manufacturer] (Name_Manufacturer,Adress,Mail,Manufacturer_Logical_Delete)
values (@N_Manufacturer,@Adress,@Mail,@Manufacturer_Logical_Delete)