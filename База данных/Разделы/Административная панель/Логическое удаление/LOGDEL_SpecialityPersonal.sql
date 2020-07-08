use [Life_of_Bionic]  -- логическое удаление специальности
go
create procedure [logdel_SpecialityPersonal]
@id_SpecialityPersonal int
as
Update [dbo].[SpecialityPersonal]
set
	SpecialityPersonal_Logical_Delete = 1
where
id_SpecialityPersonal = @id_SpecialityPersonal

Update [dbo].[Role]
set
	id_SpecialityPersonal = (Select SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal WHERE Name_SpecialityPersonal = 'Неопределенный поьзователь')
where
id_SpecialityPersonal = @id_SpecialityPersonal


Update [dbo].[TherapeuticDepartament]
set
	id_worker = null
where
TherapeuticDepartament.id_worker IN (SELECT dbo.Personal.id_worker
FROM            dbo.Role INNER JOIN
                         dbo.Personal ON dbo.Role.id_Role = dbo.Personal.id_Role INNER JOIN
                         dbo.TherapeuticDepartament ON dbo.Personal.id_worker = dbo.TherapeuticDepartament.id_worker
						 WHERE Role.id_SpecialityPersonal = (Select SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal WHERE Name_SpecialityPersonal = 'Неопределенный поьзователь'))

