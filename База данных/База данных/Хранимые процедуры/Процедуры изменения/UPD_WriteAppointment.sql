use [Life_of_Bionic] -- изменение записи на приём
go
create procedure [UPD_WriteAppointment]
@id_WriteAppointment int,
@times datetime,
@visit bit,
@id_Citizen int,
@id_FormWrite int,
@SentToTreatment bit
as
Update [dbo].[WriteAppointment]
set
	times = @times,
	visit = @visit,
	id_Citizen = @id_Citizen,
	id_FormWrite = @id_FormWrite,
	SentToTreatment = @SentToTreatment
where
	id_WriteAppointment = @id_WriteAppointment