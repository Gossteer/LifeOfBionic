use [Life_of_Bionic]  --�������� �������������
go
create procedure [del_SpecialityPersonal]
@id_SpecialityPersonal int
as
delete from [dbo].[SpecialityPersonal]
where
id_SpecialityPersonal = @id_SpecialityPersonal