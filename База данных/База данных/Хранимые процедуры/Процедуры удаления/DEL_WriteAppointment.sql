use [Life_of_Bionic]  --�������� ������ �� ����
go
create procedure [del_WriteAppointment]
@id_WriteAppointment int
as
delete from [dbo].[WriteAppointment]
where
id_WriteAppointment = @id_WriteAppointment
