use [Life_of_Bionic] -- изменение справочника болезней
go
alter procedure [UPD_DirectoryDisease]
@id_Disease int,
@Name_Disease varchar (50)
as
if (@id_Disease != (Select DirectoryDisease.id_Disease FROM DirectoryDisease WHERE DirectoryDisease.Name_Disease = @Name_Disease and DirectoryDisease.DirectoryDisease_Logical_Delete = 0))
THROW 50254, 'Данное название болезни уже существует',1
else if (@id_Disease != (Select DirectoryDisease.id_Disease FROM DirectoryDisease WHERE DirectoryDisease.Name_Disease = @Name_Disease and DirectoryDisease.DirectoryDisease_Logical_Delete = 1))
begin
Update [dbo].[DirectoryDisease]
set
	DirectoryDisease_Logical_Delete = 0

where
	id_Disease = (Select DirectoryDisease.id_Disease FROM DirectoryDisease WHERE DirectoryDisease.Name_Disease = @Name_Disease and DirectoryDisease.DirectoryDisease_Logical_Delete = 1)
	Update [dbo].[DirectoryDisease]
set
	DirectoryDisease_Logical_Delete = 1

where
	id_Disease = @id_Disease
	end
	else 
Update [dbo].[DirectoryDisease]
set
	Name_Disease = @Name_Disease
where
	id_Disease = @id_Disease