create view DocumentForDeliveryMEdicament as
SELECT     
	dbo.Manufacturer.Name_Manufacturer as 'Производитель',
	dbo.Medicament.Name_Medicament as 'Наименование лекарства',   
	dbo.CategoryOfMedicament.Name_MedCategory as 'Категория лекарства',
	dbo.DeliveryMedicament.Amount as 'Поступившее количество', 
	dbo.DeliveryMedicament.DateOfDelivery as 'Дата поставки', 
	dbo.Personal.SurnamePers + ' ' + dbo.Personal.NamePers  + ' ' + dbo.Personal.PatronymicPers as 'ФИО сотрудника', 
	dbo.Storage.id_spot as 'Ячейка склада', 
	dbo.Storage.Amount as 'Места в ячейке', 
	dbo.Storage.occupiedSpace as 'Занятно места'
FROM          
	dbo.CategoryOfMedicament INNER JOIN
	dbo.Medicament ON dbo.CategoryOfMedicament.id_CategoryOfMedicament = dbo.Medicament.id_CategoryOfMedicament INNER JOIN
	dbo.DeliveryMedicament ON dbo.Medicament.id_Medicament = dbo.DeliveryMedicament.id_Medicament INNER JOIN
	dbo.Manufacturer ON dbo.Medicament.id_Manufacturer = dbo.Manufacturer.id_Manufacturer INNER JOIN
	dbo.Personal ON dbo.DeliveryMedicament.id_worker = dbo.Personal.id_worker INNER JOIN
	dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot