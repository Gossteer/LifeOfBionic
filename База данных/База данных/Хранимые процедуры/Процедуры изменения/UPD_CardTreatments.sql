use [Life_of_Bionic] -- изменение карты лечения
go
create procedure [UPD_CardTreatments]
@id_card int,
@id_WriteAppointment int,
@id_Diagnoz int,
@Cured bit,
@MedicalDepartament int
as
Update [dbo].[CardTreatments]
set
	id_WriteAppointment = @id_WriteAppointment,
	id_Diagnoz = @id_Diagnoz,
	Cured = @Cured,
	MedicalDepartament = @MedicalDepartament
where
ID_card = @ID_card