use [Life_of_Bionic] -- изменение графика персонала
go
create procedure [UPD_WorkSchedule]
@id_WorkSchedule int,
@weekdays varchar (16)
as
Update [dbo].[WorkSchedule]
set
	weekdays = @weekdays
where
	id_WorkSchedule = @id_WorkSchedule