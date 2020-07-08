use [Life_of_Bionic] -- изменение поставки лекарств
go
create procedure [UPD_DeliveryMedicament]
@id_DeliveryMedicament int,
@Amount int,
@DateOfDelivery varchar (10),
@id_Medicament int,
@id_worker int,
@id_spot int
as
Update [dbo].[DeliveryMedicament]
set
	Amount = @Amount,
	DateOfDelivery = @DateOfDelivery,
	id_Medicament = @id_Medicament,
	id_worker =@id_worker, 
	id_spot = @id_spot
where
	id_DeliveryMedicament = @id_DeliveryMedicament