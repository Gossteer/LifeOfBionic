use [Life_of_Bionic]  --удаление поставки лекарств
go
create procedure [del_DeliveryMedicament]
@id_DeliveryMedicament int
as
delete from [dbo].[DeliveryMedicament]
where
id_DeliveryMedicament = @id_DeliveryMedicament