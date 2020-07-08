use [Life_of_Bionic]  --удаление справочника болезней
go
create procedure [del_DirectoryDisease]
@id_Disease int
as
delete from [dbo].[DirectoryDisease]
where
id_Disease = @id_Disease