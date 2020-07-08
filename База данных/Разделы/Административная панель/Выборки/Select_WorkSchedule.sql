use [Life_of_Bionic]  -- логическое удаление роли
go
create procedure [Select_WorkSchedule]
as
SELECT WorkSchedule.id_WorkSchedule,  WorkSchedule.weekdays as 'График' 
FROM WorkSchedule
WHERE WorkSchedule_Logical_Delete = 0