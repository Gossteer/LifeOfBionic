use [Life_of_Bionic]  -- логическое удаление графика персонала
go
create procedure [logdel_WriteAppointment]
@id_WriteAppointment int
as
Update [dbo].[WriteAppointment]
set
	WriteAppointment_Logical_Delete = 1
where
id_WriteAppointment = @id_WriteAppointment
