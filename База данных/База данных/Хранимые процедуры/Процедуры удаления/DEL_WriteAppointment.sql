use [Life_of_Bionic]  --удаление записи на приём
go
create procedure [del_WriteAppointment]
@id_WriteAppointment int
as
delete from [dbo].[WriteAppointment]
where
id_WriteAppointment = @id_WriteAppointment
