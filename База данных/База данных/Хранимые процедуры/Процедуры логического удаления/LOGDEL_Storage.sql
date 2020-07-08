use [Life_of_Bionic]  -- логическое удаление склада
go
create procedure [logdel_Storage]
@id_Spot int
as
Update [dbo].[Storage]
set
	Storage_Logical_Delete = 1
where
id_Spot = @id_Spot
