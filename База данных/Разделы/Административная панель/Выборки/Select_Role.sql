use [Life_of_Bionic]  -- ���������� �������� ����
go
create procedure [Select_Role]
as
SELECT        dbo.Role.id_Role as '����� ����', dbo.Role.Write as '������', dbo.Role.CardDesign as '���������� ����', 
dbo.Role.AcceptanceMedication as '���� ��������',  dbo.Role.ResolutionStatement as '������� ���������', dbo.Role.AdmissionPatient as '���� ���������', 
                         dbo.SpecialityPersonal.Name_SpecialityPersonal as '�������������'
FROM            dbo.Role INNER JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal
						 WHERE Role_Logical_Delete = 0