use [Life_of_Bionic]  -- ���������� �������� ������� ���������
go
create procedure [logdel_WorkSchedule]
@id_WorkSchedule int
as
Update [dbo].[WorkSchedule]
set
	WorkSchedule_Logical_Delete = 1
where
id_WorkSchedule = @id_WorkSchedule
