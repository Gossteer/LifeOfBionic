use [Life_of_Bionic] -- изменение графика персонала
go
create procedure [UPD_WorkSchedule]
@id_WorkSchedule int,
@weekdays varchar (16)
as
if (@id_WorkSchedule != (SELECT WorkSchedule.id_WorkSchedule FROM WorkSchedule WHERE weekdays = @weekdays and WorkSchedule_Logical_Delete = 0))
THROW 50664, 'Данная роль уже существует', 1
else if (@id_WorkSchedule != (SELECT WorkSchedule.id_WorkSchedule FROM WorkSchedule WHERE weekdays = @weekdays and WorkSchedule_Logical_Delete = 1))
begin
Update [dbo].[WorkSchedule]
set
	WorkSchedule_Logical_Delete = 1
where
	id_WorkSchedule = @id_WorkSchedule

Update [dbo].[WorkSchedule]
set
	WorkSchedule_Logical_Delete = 0
where
	id_WorkSchedule = (SELECT WorkSchedule.id_WorkSchedule FROM WorkSchedule WHERE weekdays = @weekdays and WorkSchedule_Logical_Delete = 1)
end
else
Update [dbo].[WorkSchedule]
set
	weekdays = @weekdays
where
	id_WorkSchedule = @id_WorkSchedule
