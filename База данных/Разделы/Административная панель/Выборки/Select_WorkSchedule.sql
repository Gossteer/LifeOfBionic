use [Life_of_Bionic]  -- ���������� �������� ����
go
create procedure [Select_WorkSchedule]
as
SELECT WorkSchedule.id_WorkSchedule,  WorkSchedule.weekdays as '������' 
FROM WorkSchedule
WHERE WorkSchedule_Logical_Delete = 0