use [Life_of_Bionic]  --ƒобавление новой поставки медикаментов
go
create procedure [Add_DeliveryMedicament]
@Amount int,
@DateOfDelivery varchar (10),
@id_Medicament int,
@id_worker int,
@id_spot int,
@DeliveryMedicament_Logical_Delete bit
as
insert into [dbo].[DeliveryMedicament] (Amount,DateOfDelivery,id_Medicament,id_worker,id_spot,DeliveryMedicament_Logical_Delete)
values (@Amount,@DateOfDelivery,@id_Medicament,@id_worker,@id_spot,@DeliveryMedicament_Logical_Delete)