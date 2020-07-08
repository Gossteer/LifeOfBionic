use [Life_of_Bionic]  -- ���������� �������� ����
go
create procedure [Search_Role_SpecialityPesonal]
@Name_SpecialityPersonal varchar (50)
as
SELECT        dbo.Role.id_Role as '����� ����', dbo.Role.Write as '������', dbo.Role.CardDesign as '���������� ����', 
dbo.Role.AcceptanceMedication as '���� ��������',  dbo.Role.ResolutionStatement as '������� ���������', dbo.Role.AdmissionPatient as '���� ���������', 
                         dbo.SpecialityPersonal.Name_SpecialityPersonal as '�������������'
FROM            dbo.Role INNER JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal
						 WHERE Role_Logical_Delete = 0 and SpecialityPersonal.Name_SpecialityPersonal like '%' + @Name_SpecialityPersonal + '%'