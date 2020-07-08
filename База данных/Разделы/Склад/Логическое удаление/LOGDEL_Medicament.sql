use [Life_of_Bionic]  -- логическое удаление лекарства
go
Alter procedure [logdel_Medicament]
@id_Medicament int
as

Update [dbo].[Storage]
set
	occupiedSpace = 0
where
id_Spot = (SELECT DISTINCT DeliveryMedicament.id_spot
FROM dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament
						 WHERE Medicament.id_Medicament = @id_Medicament and Medicament.Medicament_Logical_Delete = 0 and DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0
						  )


Update [dbo].[Medicament]
set
	Medicament_Logical_Delete = 1
where
id_Medicament = @id_Medicament


						 
