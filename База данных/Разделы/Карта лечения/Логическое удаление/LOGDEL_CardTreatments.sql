use [Life_of_Bionic]  -- логическое удаление карты лечения
go
alter procedure [logdel_CardTreatments]
@id_card int,
@Amount_Use int
as 
declare @id_WriteAppointment INT
SET @id_WriteAppointment = (Select CardTreatments.id_WriteAppointment FROM CardTreatments  WHERE CardTreatments.id_card = @id_card and CardTreatments.CardTreatments_Logical_Delete = 0 and CardTreatments.Cured = 0)
if (EXISTS(Select id_card FROM CardTreatments  WHERE CardTreatments.id_card = @id_card and CardTreatments.CardTreatments_Logical_Delete = 0 and CardTreatments.Cured = 0))
begin
if (@Amount_Use > (SELECT  Diagnosis.Amount FROM dbo.CardTreatments INNER JOIN
dbo.Diagnosis ON dbo.CardTreatments.id_Diagnoz = dbo.Diagnosis.id_Diagnoz
WHERE CardTreatments.id_card = @id_card))
THROW 50563, 'Использовано больше лекарств, чем положено', 1
Update [dbo].[Storage]
set
	occupiedSpace += ((Select Diagnosis.Amount FROM CardTreatments JOIN Diagnosis ON CardTreatments.id_Diagnoz = Diagnosis.id_Diagnoz WHERE CardTreatments.id_card = @id_card) - @Amount_Use)
where
id_spot = (SELECT    DISTINCT    Storage.id_spot
FROM           dbo.CardTreatments INNER JOIN
                         dbo.Diagnosis ON dbo.CardTreatments.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.DeliveryMedicament ON dbo.Medicament.id_Medicament = dbo.DeliveryMedicament.id_Medicament INNER JOIN
                         dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
						 WHERE CardTreatments.id_card = @id_card)
						 end

Update [dbo].[CardTreatments]
set
	CardTreatments_Logical_Delete = 1
where
id_card = @id_card

if (EXISTS(Select CardTreatments.id_card FROM CardTreatments WHERE CardTreatments.id_WriteAppointment = @id_WriteAppointment and CardTreatments.Cured = 0 and CardTreatments.CardTreatments_Logical_Delete = 0))
Update [dbo].[WriteAppointment]
set
	MedicalDepartament = NULL,
	СategoriesDisease = NULL
where
id_WriteAppointment = @id_WriteAppointment


