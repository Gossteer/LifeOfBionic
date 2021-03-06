use [Life_of_Bionic]  --Добавление справочника болезней
go 
alter procedure [Add_DirectoryDisease]
@Name_Disease varchar (50)
as
DECLARE @id_DirectoryDisease int
if (EXISTS(Select DirectoryDisease.id_Disease FROM DirectoryDisease WHERE DirectoryDisease.Name_Disease = @Name_Disease and DirectoryDisease.DirectoryDisease_Logical_Delete = 1))
begin
set  @id_DirectoryDisease = (Select DirectoryDisease.id_Disease FROM DirectoryDisease WHERE DirectoryDisease.Name_Disease = @Name_Disease and DirectoryDisease_Logical_Delete = 1) 
Update DirectoryDisease
set
DirectoryDisease_Logical_Delete = 0
where 
DirectoryDisease.Name_Disease = @Name_Disease
end
else if (EXISTS(Select DirectoryDisease.id_Disease FROM DirectoryDisease WHERE DirectoryDisease.Name_Disease = @Name_Disease and DirectoryDisease.DirectoryDisease_Logical_Delete = 0))
THROW 50254, 'Данное название болезни уже существует',1
else
insert into [dbo].[DirectoryDisease] (Name_Disease)
values (@Name_Disease)

