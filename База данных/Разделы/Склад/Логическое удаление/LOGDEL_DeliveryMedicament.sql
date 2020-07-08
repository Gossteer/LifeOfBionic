use [Life_of_Bionic]  -- логическое удаление поставки лекарств
go
alter procedure [logdel_DeliveryMedicament]
@id_DeliveryMedicament int,
@id_Medicament int,
@Amount_Use int
as

if ( @Amount_Use > (
SELECT DISTINCT dbo.Storage.occupiedSpace
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
						 WHERE DeliveryMedicament.id_Medicament = @id_Medicament and Medicament.Medicament_Logical_Delete = 0))
						 THROW 50656,' На данный момент на складе отсутствует данное количество лекарственных средств',1

Update [dbo].[Storage]
set
	occupiedSpace -= @Amount_Use
where
id_spot = (SELECT DISTINCT dbo.Storage.id_spot
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
						 WHERE DeliveryMedicament.id_Medicament = @id_Medicament and Medicament.Medicament_Logical_Delete = 0)

Update [dbo].[DeliveryMedicament]
set
	DeliveryMedicament_Logical_Delete = 1
where
id_DeliveryMedicament = @id_DeliveryMedicament
