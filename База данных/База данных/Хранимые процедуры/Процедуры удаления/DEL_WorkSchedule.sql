use [Life_of_Bionic]  --удаление графика персонала
go
create procedure [del_WorkSchedule]
@id_WorkSchedule int
as
delete from [dbo].[WorkSchedule]
where
id_WorkSchedule = @id_WorkSchedule
