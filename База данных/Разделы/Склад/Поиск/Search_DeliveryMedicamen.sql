use Life_of_Bionic
go

create Procedure Search_DeliveryMedicamen
@Date_DeliveryMedicament varchar(10)
as
SELECT dbo.DeliveryMedicament.id_DeliveryMedicament, Medicament.id_Medicament, dbo.Medicament.Name_Medicament as '���������', dbo.DeliveryMedicament.Amount as '����������', 
dbo.DeliveryMedicament.DateOfDelivery '���� ��������', dbo.Personal.NamePers + ' ' + dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers as '������ ��������'
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.Personal ON dbo.DeliveryMedicament.id_worker = dbo.Personal.id_worker
						 where DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0 and DeliveryMedicament.DateOfDelivery like '%' + @Date_DeliveryMedicament + '%' 