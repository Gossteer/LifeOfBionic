use [Life_of_Bionic]  --ƒобавление справочника болезней
go 
create procedure [Add_DirectoryDisease]
@Name_Disease varchar (50),
@DirectoryDisease_Logical_Delete bit
as
DECLARE @id_DirectoryDisease int
if (EXISTS(Select DirectoryDisease.id_Disease FROM DirectoryDisease WHERE DirectoryDisease.Name_Disease = @Name_Disease and DirectoryDisease.DirectoryDisease_Logical_Delete = 1))
begin
set  @id_DirectoryDisease = (Select DirectoryDisease.id_Disease FROM DirectoryDisease WHERE DirectoryDisease.Name_Disease = @Name_Disease) 
exec UPD_DirectoryDisease @id_DirectoryDisease, @Name_Disease, 0
end
else if (EXISTS(Select DirectoryDisease.id_Disease FROM DirectoryDisease WHERE DirectoryDisease.Name_Disease = @Name_Disease and DirectoryDisease.DirectoryDisease_Logical_Delete = 0))
THROW 50254, 'ƒанное название болезни уже существует',1
else
insert into [dbo].[DirectoryDisease] (Name_Disease,DirectoryDisease_Logical_Delete)
values (@Name_Disease,@DirectoryDisease_Logical_Delete)