use [Life_of_Bionic]  -- логическое удаление типа записи
go
create procedure [logdel_TypeWrite]
@id_TypeWrite int
as
Update [dbo].[TypeWrite]
set
	TypeWrite_Logical_Delete = 1
where
id_TypeWrite = @id_TypeWrite
