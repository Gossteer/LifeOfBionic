use [Life_of_Bionic] -- изменение справочника болезней
go
create procedure [UPD_DirectoryDisease]
@id_Disease int,
@Name_Disease varchar (50)
as
Update [dbo].[DirectoryDisease]
set
	Name_Disease = @Name_Disease
where
	id_Disease = @id_Disease