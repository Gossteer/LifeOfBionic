use Life_of_Bionic
go

create procedure Cured_All_CardTreatmens
@id_WriteAppointment int
as
Update [dbo].[CardTreatments]
set
	Cured = 1
where
	CardTreatments.id_WriteAppointment = @id_WriteAppointment
