use [Life_of_Bionic]  --Добавление справочника болезней
go 
create procedure [Add_DirectoryDisease]
@Name_Disease varchar (50),
@DirectoryDisease_Logical_Delete bit
as
insert into [dbo].[DirectoryDisease] (Name_Disease,DirectoryDisease_Logical_Delete)
values (@Name_Disease,@DirectoryDisease_Logical_Delete)