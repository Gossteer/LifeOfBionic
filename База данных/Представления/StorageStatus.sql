create view StorageStatus as
SELECT        
dbo.Storage.id_spot as '����� ������ ������', 
dbo.Medicament.Name_Medicament as '�������� �����������', 
dbo.Storage.Amount as '����� ���������� �����', 
dbo.Storage.occupiedSpace as '������ �����'
FROM            
dbo.DeliveryMedicament INNER JOIN
dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot