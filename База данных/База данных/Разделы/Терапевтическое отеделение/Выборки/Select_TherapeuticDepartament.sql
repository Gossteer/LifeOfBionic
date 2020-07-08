use Life_of_Bionic
go

create procedure Select_TherapeuticDepartament
as
SELECT        dbo.TherapeuticDepartament.id_Room as 'Номер отделения', dbo.TherapeuticDepartament.amountRooms as 'Всего мест', 
dbo.TherapeuticDepartament.BusyRoom as 'Занято мест', dbo.CategoriesDisease.Name_CategoriesDisease as 'Категория болезни', dbo.Personal.NamePers+ ' ' + 
                         dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers as 'Заведующий',  dbo.SpecialityPersonal.Name_SpecialityPersonal as 'Специализация'
FROM            dbo.Role INNER JOIN
                         dbo.Personal ON dbo.Role.id_Role = dbo.Personal.id_Role INNER JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal INNER JOIN
                         dbo.TherapeuticDepartament ON dbo.Personal.id_worker = dbo.TherapeuticDepartament.id_worker INNER JOIN
                         dbo.CategoriesDisease ON dbo.TherapeuticDepartament.id_CategoriesDisease = dbo.CategoriesDisease.id_CategoriesDisease
						 WHERE TherapeuticDepartament.TherapeuticDepartament_Logical_Delete = 0

