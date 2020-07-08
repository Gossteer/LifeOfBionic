use [Life_of_Bionic]  -- логическое удаление поставки лекарств
go
create procedure [logdel_DeliveryMedicament]
@id_DeliveryMedicament int
as
Update [dbo].[DeliveryMedicament]
set
	DeliveryMedicament_Logical_Delete = 1
where
id_DeliveryMedicament = @id_DeliveryMedicament
