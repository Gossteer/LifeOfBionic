
USE [Life_of_Bionic]
GO

create procedure Select_Medicament_FOR_Storage
as
SELECT     DISTINCT    dbo.Medicament.id_Medicament, Storage.id_spot as 'Ячейка склада' , dbo.Medicament.Name_Medicament as 'Название', dbo.CategoryOfMedicament.Name_MedCategory as 'Категория'
, dbo.Storage.occupiedSpace as 'Количество в наличии', ISNULL(dbo.Manufacturer.Name_Manufacturer, 'Производитель не назначен') as 'Производитель', dbo.Manufacturer.Adress as 'Адрес отправки', dbo.Manufacturer.Mail as 'Mail компании'
FROM           dbo.CategoryOfMedicament INNER JOIN
                         dbo.Medicament ON dbo.CategoryOfMedicament.id_CategoryOfMedicament = dbo.Medicament.id_CategoryOfMedicament INNER JOIN
                         dbo.DeliveryMedicament ON dbo.Medicament.id_Medicament = dbo.DeliveryMedicament.id_Medicament INNER JOIN
                         dbo.Manufacturer ON dbo.Medicament.id_Manufacturer = dbo.Manufacturer.id_Manufacturer INNER JOIN
                         dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
						 WHERE dbo.Medicament.Medicament_Logical_Delete = 0