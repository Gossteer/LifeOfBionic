use [Life_of_Bionic]  --Добавление типа записи
go 
create procedure [Add_TypeWrite]
@N_TypeWrite varchar (50),
@TypeWrite_Logical_Delete bit
as
insert into [dbo].[TypeWrite] (Name_Write,TypeWrite_Logical_Delete)
values (@N_TypeWrite,@TypeWrite_Logical_Delete)