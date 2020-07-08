use [Life_of_Bionic] -- изменение поставки лекарств
go
alter procedure [UPD_DeliveryMedicament]
@id_DeliveryMedicament int,
@Amount int,
@DateOfDelivery varchar (10),
@id_Medicament int,
@id_worker int,
@id_spot int
as
if (DATEDIFF (DAY,@DateOfDelivery,getDate()) != 0)
THROW 50659, 'Невозможно изменить поставку передним или задним числом',1
else if (EXISTS(SELECT    DISTINCT    DeliveryMedicament.id_spot
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament
						 WHERE Medicament.Medicament_Logical_Delete = 0 and DeliveryMedicament.id_Medicament = @id_Medicament) 
						 and @id_spot NOT IN (SELECT    DISTINCT    DeliveryMedicament.id_spot
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament
						 WHERE Medicament.Medicament_Logical_Delete = 0 and DeliveryMedicament.id_Medicament = @id_Medicament))
THROW 50260, 'Данная ячейка склада занята другим лекарством', 1
else if ((SELECT dbo.Storage.Amount
FROM  dbo.Storage where Storage.id_spot = @id_spot) - (SELECT dbo.Storage.occupiedSpace
FROM  dbo.Storage where Storage.id_spot = @id_spot) < @Amount)
				  throw 50565 , 'Количество медикаментов превышает допустимый размер ячейки',1
				  else
Update [dbo].[DeliveryMedicament]
set
	Amount = @Amount,
	DateOfDelivery = @DateOfDelivery,
	id_Medicament = @id_Medicament,
	id_worker =@id_worker, 
	id_spot = @id_spot
where
	id_DeliveryMedicament = @id_DeliveryMedicament
