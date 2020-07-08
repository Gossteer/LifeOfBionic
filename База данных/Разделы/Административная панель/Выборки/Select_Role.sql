use [Life_of_Bionic]  -- логическое удаление роли
go
create procedure [Select_Role]
as
SELECT        dbo.Role.id_Role as 'Номер роли', dbo.Role.Write as 'Запись', dbo.Role.CardDesign as 'Оформление карт', 
dbo.Role.AcceptanceMedication as 'Приём лекарств',  dbo.Role.ResolutionStatement as 'Выписка пациентов', dbo.Role.AdmissionPatient as 'Приём пациентов', 
                         dbo.SpecialityPersonal.Name_SpecialityPersonal as 'Специализация'
FROM            dbo.Role INNER JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal
						 WHERE Role_Logical_Delete = 0