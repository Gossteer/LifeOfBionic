use [Life_of_Bionic] -- изменение специальности персонала
go
create procedure [UPD_SpecialityPersonal]
@id_SpecialityPersonal int,
@Name_SpecialityPersonal varchar (50)
as
if (@id_SpecialityPersonal != (SELECT SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal 
WHERE SpecialityPersonal.Name_SpecialityPersonal = @Name_SpecialityPersonal and SpecialityPersonal_Logical_Delete = 0))
THROW 50665, 'Данная специализация уже создана', 1
else if (@id_SpecialityPersonal != (SELECT SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal 
WHERE SpecialityPersonal.Name_SpecialityPersonal = @Name_SpecialityPersonal and SpecialityPersonal_Logical_Delete = 1))
begin
Update [dbo].[SpecialityPersonal]
set
	SpecialityPersonal_Logical_Delete = 0
where
	id_SpecialityPersonal = (SELECT SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal 
WHERE SpecialityPersonal.Name_SpecialityPersonal = @Name_SpecialityPersonal and SpecialityPersonal_Logical_Delete = 1)
	Update [dbo].[SpecialityPersonal]
set
	SpecialityPersonal_Logical_Delete = 1
where
	id_SpecialityPersonal = @id_SpecialityPersonal
end
else
Update [dbo].[SpecialityPersonal]
set
	Name_SpecialityPersonal = @Name_SpecialityPersonal
where
	id_SpecialityPersonal = @id_SpecialityPersonal
