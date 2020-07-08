create view RoomInfo as
SELECT        
dbo.TherapeuticDepartament.id_Room as '����� ������',
dbo.TherapeuticDepartament.amountRooms as '���������� ����', 
dbo.TherapeuticDepartament.BusyRoom as '���� ������', 
dbo.CategoriesDisease.Name_CategoriesDisease as '��������� �����������', 
dbo.Personal.SurnamePers + ' ' + dbo.Personal.NamePers  + ' '  + dbo.Personal.PatronymicPers 
+ ', ' + dbo.SpecialityPersonal.Name_SpecialityPersonal as '���, ������������� �����'
FROM            
dbo.CategoriesDisease INNER JOIN
dbo.TherapeuticDepartament ON dbo.CategoriesDisease.id_CategoriesDisease = dbo.TherapeuticDepartament.id_CategoriesDisease INNER JOIN
dbo.Personal ON dbo.TherapeuticDepartament.id_worker = dbo.Personal.id_worker INNER JOIN
dbo.Role ON dbo.Personal.id_Role = dbo.Role.id_Role INNER JOIN
dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal