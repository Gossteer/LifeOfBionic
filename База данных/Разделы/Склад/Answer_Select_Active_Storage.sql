use Life_of_Bionic
go


create function Answer_Select_Active_Storage
(@id_Storage int)
returns bit
as
BEGIN
if (EXISTS(SELECT     DISTINCT      dbo.Storage.id_spot
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
						 WHERE dbo.Medicament.Medicament_Logical_Delete = 0 and Storage.id_spot = @id_Storage and DeliveryMedicament_Logical_Delete = 0))
						 return (1)
						 return (0)

						 END