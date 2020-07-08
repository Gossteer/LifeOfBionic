use Life_of_Bionic
go

alter procedure [CardTreatments_Diagnoz_Select]
@id_WriteAppointment int
as

SELECT  dbo.CardTreatments.id_card, dbo.CardTreatments.id_WriteAppointment, dbo.CardTreatments.id_Diagnoz, dbo.DirectoryDisease.Name_Disease as 'Название болезни', dbo.Diagnosis.TimeDisease as 'Срок лечения', dbo.Medicament.Name_Medicament as 'Назначаемое лекарство', 
dbo.Diagnosis.Amount as 'Количество', dbo.TypeUse.Name_Use as 'Способ применения', dbo.Diagnosis.ID_Room as 'Номер палаты лечения', dbo.CardTreatments.Cured as 'Состояние'
FROM            dbo.CardTreatments INNER JOIN
                         dbo.Diagnosis ON dbo.CardTreatments.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment INNER JOIN
                         dbo.TypeUse ON dbo.Diagnosis.id_TypeUse = dbo.TypeUse.id_TypeUse INNER JOIN
                         dbo.DirectoryDisease ON dbo.Diagnosis.id_Disease = dbo.DirectoryDisease.id_Disease INNER JOIN
                         dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament
WHERE CardTreatments.id_WriteAppointment = @id_WriteAppointment and CardTreatments.CardTreatments_Logical_Delete = 0





