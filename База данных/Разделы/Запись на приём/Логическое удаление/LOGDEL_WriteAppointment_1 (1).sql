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
if (EXISTS(Select WriteAppointment.id_WriteAppointment FROM WriteAppointment WHERE WriteAppointment.id_WriteAppointment = @id_WriteAppointment and WriteAppointment.visit = 1 and WriteAppointment.SentToTreatment = 1))
begin
Update [dbo].[CardTreatments]
set
	CardTreatments_Logical_Delete = 1
where
id_WriteAppointment = @id_WriteAppointment
UPDATE Discharge
set
	Discharge_Logical_Delete = 1
where Discharge.id_WriteAppointment IN (Select id_card FROM CardTreatments WHERE CardTreatments.id_WriteAppointment = @id_WriteAppointment)
end

