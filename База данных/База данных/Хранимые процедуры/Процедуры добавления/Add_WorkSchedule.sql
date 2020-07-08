use [Life_of_Bionic]  --Добавление графика персонала
go
create procedure [Add_WorkSchedule]
@weekdays varchar (16),
@WorkSchedule_Logical_Delete bit
as
insert into [dbo].[WorkSchedule] (weekdays,WorkSchedule_Logical_Delete)
values (@weekdays,@WorkSchedule_Logical_Delete)