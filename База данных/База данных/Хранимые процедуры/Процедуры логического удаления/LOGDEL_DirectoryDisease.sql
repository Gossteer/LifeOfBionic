use [Life_of_Bionic]  -- логическое удаление справочника болезней
go
create procedure [logdel_DirectoryDisease]
@id_Disease int
as
Update [dbo].[DirectoryDisease]
set
	DirectoryDisease_Logical_Delete = 1
where
id_Disease = @id_Disease
