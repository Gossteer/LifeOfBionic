use [Life_of_Bionic]  -- ���������� �������� ����
go
create procedure [Select_SpecialityPersonal]
as
SELECT SpecialityPersonal.id_SpecialityPersonal, SpecialityPersonal.Name_SpecialityPersonal AS '�������������'
From SpecialityPersonal
WHERE SpecialityPersonal_Logical_Delete = 0 and SpecialityPersonal.Name_SpecialityPersonal != '�����' and SpecialityPersonal.Name_SpecialityPersonal != '������� ����'