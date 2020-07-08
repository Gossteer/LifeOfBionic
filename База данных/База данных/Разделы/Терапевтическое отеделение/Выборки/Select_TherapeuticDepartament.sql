use Life_of_Bionic
go

create procedure Select_TherapeuticDepartament
as
SELECT        dbo.TherapeuticDepartament.id_Room as '����� ���������', dbo.TherapeuticDepartament.amountRooms as '����� ����', 
dbo.TherapeuticDepartament.BusyRoom as '������ ����', dbo.CategoriesDisease.Name_CategoriesDisease as '��������� �������', dbo.Personal.NamePers+ ' ' + 
                         dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers as '����������',  dbo.SpecialityPersonal.Name_SpecialityPersonal as '�������������'
FROM            dbo.Role INNER JOIN
                         dbo.Personal ON dbo.Role.id_Role = dbo.Personal.id_Role INNER JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal INNER JOIN
                         dbo.TherapeuticDepartament ON dbo.Personal.id_worker = dbo.TherapeuticDepartament.id_worker INNER JOIN
                         dbo.CategoriesDisease ON dbo.TherapeuticDepartament.id_CategoriesDisease = dbo.CategoriesDisease.id_CategoriesDisease
						 WHERE TherapeuticDepartament.TherapeuticDepartament_Logical_Delete = 0

