use [Life_of_Bionic]  -- логическое удаление сотрудника
go
create procedure [logdel_Personal]
@id_worker int
as
Update [dbo].[Personal]
set
	Personal_Logical_Delete = 1
where
id_worker = @id_worker
