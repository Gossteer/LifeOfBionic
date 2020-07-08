use [Life_of_Bionic]  --���������� ������� ���������
go
create procedure [Add_WorkSchedule]
@weekdays varchar (16)
as
if (@weekdays not like '[0-7]/[0-7]' )
THROW 50684, '���������� ������� ������ � �������: 5/7. � ������ �� ����� 7 ����',1
else if (Exists(SELECT WorkSchedule.id_WorkSchedule FROM WorkSchedule WHERE WorkSchedule.weekdays = @weekdays and WorkSchedule.WorkSchedule_Logical_Delete = 0))
THROW 50666, '������ ������ ��� ������', 1
else if (Exists(SELECT WorkSchedule.id_WorkSchedule FROM WorkSchedule WHERE WorkSchedule.weekdays = @weekdays and WorkSchedule.WorkSchedule_Logical_Delete = 1))
UPDATE [WorkSchedule]
set
WorkSchedule_Logical_Delete = 0
where 
WorkSchedule.id_WorkSchedule = (SELECT WorkSchedule.id_WorkSchedule FROM WorkSchedule WHERE WorkSchedule.weekdays = @weekdays and WorkSchedule.WorkSchedule_Logical_Delete = 1)
else
insert into [dbo].[WorkSchedule] (weekdays)
values (@weekdays)