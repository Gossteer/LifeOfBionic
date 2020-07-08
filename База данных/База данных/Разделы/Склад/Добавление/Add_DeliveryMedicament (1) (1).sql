use [Life_of_Bionic]  --Добавление новой поставки медикаментов
go
alter procedure [Add_DeliveryMedicament]
@Amount int,
@DateOfDelivery varchar (10),
@id_Medicament int,
@id_worker int,
@id_spot int
as
if (EXISTS(SELECT    DISTINCT    DeliveryMedicament.id_spot
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament
						 WHERE Medicament.Medicament_Logical_Delete = 0 and DeliveryMedicament.id_spot = @id_spot) 
						 and @id_Medicament NOT IN (SELECT    DISTINCT    DeliveryMedicament.id_Medicament
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament
						 WHERE Medicament.Medicament_Logical_Delete = 0 and DeliveryMedicament.id_spot = @id_spot))
THROW 50260, 'Данная ячейка склада занята другим лекарством', 1
else if (DATEDIFF (DAY,@DateOfDelivery,getDate())!=0)
THROW 50261, 'Дата поставки не совпадает с сегоднешней ', 1

insert into [dbo].[DeliveryMedicament] (Amount,DateOfDelivery,id_Medicament,id_worker,id_spot)
values (@Amount,@DateOfDelivery,@id_Medicament,@id_worker,@id_spot)

					

