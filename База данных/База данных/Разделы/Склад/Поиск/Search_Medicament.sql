use Life_of_Bionic
go

create Procedure Search_Medicament
@Name_Medicament varchar(50)
as
SELECT     DISTINCT    dbo.Medicament.id_Medicament, Storage.id_spot as '������ ������' , dbo.Medicament.Name_Medicament as '��������', dbo.CategoryOfMedicament.Name_MedCategory as '���������'
, dbo.Storage.occupiedSpace as '���������� � �������', ISNULL(dbo.Manufacturer.Name_Manufacturer, '������������� �� ��������') as '�������������', dbo.Manufacturer.Adress as '����� ��������', dbo.Manufacturer.Mail as 'Mail ��������'
FROM           dbo.CategoryOfMedicament INNER JOIN
                         dbo.Medicament ON dbo.CategoryOfMedicament.id_CategoryOfMedicament = dbo.Medicament.id_CategoryOfMedicament INNER JOIN
                         dbo.DeliveryMedicament ON dbo.Medicament.id_Medicament = dbo.DeliveryMedicament.id_Medicament INNER JOIN
                         dbo.Manufacturer ON dbo.Medicament.id_Manufacturer = dbo.Manufacturer.id_Manufacturer INNER JOIN
                         dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
						 WHERE dbo.Medicament.Medicament_Logical_Delete = 0 and Medicament.Name_Medicament like '%' + @Name_Medicament + '%' 