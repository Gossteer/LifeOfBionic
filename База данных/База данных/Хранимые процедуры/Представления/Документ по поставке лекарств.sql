create view DocumentForDeliveryMEdicament as
SELECT     
	dbo.Manufacturer.Name_Manufacturer as '�������������',
	dbo.Medicament.Name_Medicament as '������������ ���������',   
	dbo.CategoryOfMedicament.Name_MedCategory as '��������� ���������',
	dbo.DeliveryMedicament.Amount as '����������� ����������', 
	dbo.DeliveryMedicament.DateOfDelivery as '���� ��������', 
	dbo.Personal.NamePers as '��� ����������', 
	dbo.Personal.SurnamePers as '������� ����������', 
	dbo.Personal.PatronymicPers as '�������� ����������', 
	dbo.Storage.id_spot as '������ ������', 
	dbo.Storage.Amount as '����� � ������', 
	dbo.Storage.occupiedSpace as '������� �����',
	dbo.Manufacturer.id_Manufacturer , 
	dbo.Personal.id_worker, 
	dbo.Medicament.id_Medicament, 
	dbo.CategoryOfMedicament.id_CategoryOfMedicament, 
	dbo.DeliveryMedicament.id_DeliveryMedicament
FROM          
	dbo.CategoryOfMedicament INNER JOIN
	dbo.Medicament ON dbo.CategoryOfMedicament.id_CategoryOfMedicament = dbo.Medicament.id_CategoryOfMedicament INNER JOIN
	dbo.DeliveryMedicament ON dbo.Medicament.id_Medicament = dbo.DeliveryMedicament.id_Medicament INNER JOIN
	dbo.Manufacturer ON dbo.Medicament.id_Manufacturer = dbo.Manufacturer.id_Manufacturer INNER JOIN
	dbo.Personal ON dbo.DeliveryMedicament.id_worker = dbo.Personal.id_worker INNER JOIN
	dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot