USE [Life_of_Bionic]
GO

alter procedure Select_Medicament
as
SELECT dbo.Medicament.id_Medicament, dbo.Medicament.Name_Medicament + ' на складе: ' + CONVERT(varchar, Storage.occupiedSpace) As 'Лекарство'
FROM dbo.DeliveryMedicament
JOIN dbo.Medicament ON dbo.DeliveryMedicament.id_DeliveryMedicament = dbo.Medicament.id_Medicament
JOIN Storage ON dbo.DeliveryMedicament.id_DeliveryMedicament = Storage.id_spot
WHERE dbo.Medicament.Medicament_Logical_Delete = 0

exec Select_Medicament