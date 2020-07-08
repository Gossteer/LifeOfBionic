create view StorageStatus as
SELECT        
dbo.Storage.id_spot as 'Номер ячейки склада', 
dbo.Medicament.Name_Medicament as 'Название медикамента', 
dbo.Storage.Amount as 'Общее количество места', 
dbo.Storage.occupiedSpace as 'Занято места'
FROM            
dbo.DeliveryMedicament INNER JOIN
dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot