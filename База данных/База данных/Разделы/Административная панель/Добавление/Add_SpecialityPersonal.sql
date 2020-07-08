use [Life_of_Bionic]  --Добавление специальности для персонала
go 
create procedure [Add_SpecialityPersonal]
@Name_SpecialityPersonal varchar (50)
as
if (Exists(SELECT SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal WHERE SpecialityPersonal.Name_SpecialityPersonal = @Name_SpecialityPersonal and SpecialityPersonal_Logical_Delete = 0))
THROW 50665, 'Данная специализация уже создана', 1
else if (Exists(SELECT SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal WHERE SpecialityPersonal.Name_SpecialityPersonal = @Name_SpecialityPersonal and SpecialityPersonal_Logical_Delete = 1))
UPDATE [SpecialityPersonal]
set
SpecialityPersonal_Logical_Delete = 0
where 
id_SpecialityPersonal = (SELECT SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal WHERE SpecialityPersonal.Name_SpecialityPersonal = @Name_SpecialityPersonal and SpecialityPersonal_Logical_Delete = 1)
else
insert into [dbo].[SpecialityPersonal] (Name_SpecialityPersonal)
values (@Name_SpecialityPersonal)