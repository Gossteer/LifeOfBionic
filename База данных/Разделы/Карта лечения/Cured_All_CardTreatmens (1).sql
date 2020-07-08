use Life_of_Bionic
go

alter procedure Cured_All_CardTreatmens
@id_WriteAppointment int
as
Update [dbo].[CardTreatments]
set
	Cured = 1
where
	CardTreatments.id_WriteAppointment = @id_WriteAppointment and CardTreatments_Logical_Delete = 0 and Cured = 0

