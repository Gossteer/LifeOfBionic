use [Life_of_Bionic]  -- ���������� �������� �������������
go
create procedure [logdel_SpecialityPersonal]
@id_SpecialityPersonal int
as
Update [dbo].[SpecialityPersonal]
set
	SpecialityPersonal_Logical_Delete = 1
where
id_SpecialityPersonal = @id_SpecialityPersonal
