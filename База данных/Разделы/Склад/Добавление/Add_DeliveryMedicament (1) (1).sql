USE [Life_of_Bionic]
GO
/****** Object:  StoredProcedure [dbo].[Add_DeliveryMedicament]    Script Date: 31.05.2019 8:37:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter procedure [dbo].[Add_DeliveryMedicament]
@Amount int,
@DateOfDelivery varchar (10),
@id_Medicament int,
@id_worker int,
@id_spot int
as
declare @lol varchar (100)
SET @lol = 'Данный медикамент, назначен на другую ячейку склада: ' + convert(varchar,(SELECT        dbo.Storage.id_spot
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
						 WHere Storage_Logical_Delete = 0 and DeliveryMedicament_Logical_Delete = 0 and Medicament.id_Medicament = @id_Medicament))
if (EXISTS(SELECT    DISTINCT    DeliveryMedicament.id_spot
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament
						 WHERE Medicament.Medicament_Logical_Delete = 0 and DeliveryMedicament.id_spot = @id_spot) 
						 and @id_Medicament NOT IN (SELECT    DISTINCT    DeliveryMedicament.id_Medicament
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament
						 WHERE Medicament.Medicament_Logical_Delete = 0 and DeliveryMedicament.id_spot = @id_spot))
THROW 50260, 'Данная ячейка склада занята другим лекарством', 1
else if (EXISTS(SELECT        dbo.Storage.id_spot
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
						 WHere Storage_Logical_Delete = 0 and DeliveryMedicament_Logical_Delete = 0 and Medicament.id_Medicament = @id_Medicament)
						 and @id_spot NOT IN (SELECT    DISTINCT    DeliveryMedicament.id_spot
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament
						 WHERE Medicament.Medicament_Logical_Delete = 0 and DeliveryMedicament.id_Medicament = @id_Medicament and DeliveryMedicament_Logical_Delete = 0))
						 THROW 50681, @lol ,1
else if (DATEDIFF (DAY,@DateOfDelivery,getDate())!=0)
THROW 50261, 'Дата поставки не совпадает с сегоднешней ', 1
else if ((SELECT dbo.Storage.Amount
FROM  dbo.Storage where Storage.id_spot = @id_spot) - (SELECT dbo.Storage.occupiedSpace
FROM  dbo.Storage where Storage.id_spot = @id_spot) < @Amount)
				  throw 50565 , 'Количество медикаментов превышает допустимый размер ячейки',1
				  else

insert into [dbo].[DeliveryMedicament] (Amount,DateOfDelivery,id_Medicament,id_worker,id_spot)
values (@Amount,@DateOfDelivery,@id_Medicament,@id_worker,@id_spot)


					
