use [Life_of_Bionic]  --Добавление графика персонала
go
create procedure [Add_WorkSchedule]
@weekdays varchar (16)
as
if (Exists(SELECT WorkSchedule.id_WorkSchedule FROM WorkSchedule WHERE WorkSchedule.weekdays = @weekdays and WorkSchedule.WorkSchedule_Logical_Delete = 0))
THROW 50666, 'Данный график уже создан', 1
else if (Exists(SELECT WorkSchedule.id_WorkSchedule FROM WorkSchedule WHERE WorkSchedule.weekdays = @weekdays and WorkSchedule.WorkSchedule_Logical_Delete = 1))
UPDATE [WorkSchedule]
set
WorkSchedule_Logical_Delete = 0
where 
WorkSchedule.id_WorkSchedule = (SELECT WorkSchedule.id_WorkSchedule FROM WorkSchedule WHERE WorkSchedule.weekdays = @weekdays and WorkSchedule.WorkSchedule_Logical_Delete = 1)
else
insert into [dbo].[WorkSchedule] (weekdays)
values (@weekdays)