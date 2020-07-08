use [Life_of_Bionic]  --Добавление типп употребления
go 
create procedure [Add_TypeUse]
@NameUse varchar (50),
@TypeUse_Logical_Delete bit
as
insert into [dbo].[TypeUse] (Name_Use,TypeUse_Logical_Delete)
values (@NameUse,@TypeUse_Logical_Delete)