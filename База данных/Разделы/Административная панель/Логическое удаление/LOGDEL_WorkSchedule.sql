use [Life_of_Bionic]  -- логическое удаление графика персонала
go
create procedure [logdel_WorkSchedule]
@id_WorkSchedule int
as
Update [dbo].[WorkSchedule]
set
	WorkSchedule_Logical_Delete = 1
where
id_WorkSchedule = @id_WorkSchedule

Update [dbo].[Personal]
set
	id_WorkSchedule = null
where
id_WorkSchedule = @id_WorkSchedule