use [Life_of_Bionic]  -- логическое удаление роли
go
create procedure [Select_SpecialityPersonal]
as
SELECT SpecialityPersonal.id_SpecialityPersonal, SpecialityPersonal.Name_SpecialityPersonal AS 'Специализация'
From SpecialityPersonal
WHERE SpecialityPersonal_Logical_Delete = 0 and SpecialityPersonal.Name_SpecialityPersonal != 'Админ' and SpecialityPersonal.Name_SpecialityPersonal != 'Главный Врач'