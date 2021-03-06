USE [Life_of_Bionic]
GO
/****** Object:  StoredProcedure [dbo].[Select_Medicament]    Script Date: 28.05.2019 19:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Select_DeliveryMedicament]
as
SELECT dbo.DeliveryMedicament.id_DeliveryMedicament, Medicament.id_Medicament, dbo.Medicament.Name_Medicament as 'Лекарство', dbo.DeliveryMedicament.Amount as 'Количество', 
dbo.DeliveryMedicament.DateOfDelivery 'Дата поставки', dbo.Personal.NamePers + ' ' + dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers as 'Принял поставку'
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.Personal ON dbo.DeliveryMedicament.id_worker = dbo.Personal.id_worker
						 where DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0
