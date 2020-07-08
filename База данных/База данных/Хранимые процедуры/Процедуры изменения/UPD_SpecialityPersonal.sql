use [Life_of_Bionic] -- изменение специальности персонала
go
create procedure [UPD_SpecialityPersonal]
@id_SpecialityPersonal int,
@Name_SpecialityPersonal varchar (50)
as
Update [dbo].[SpecialityPersonal]
set
	Name_SpecialityPersonal = @Name_SpecialityPersonal
where
	id_SpecialityPersonal = @id_SpecialityPersonal