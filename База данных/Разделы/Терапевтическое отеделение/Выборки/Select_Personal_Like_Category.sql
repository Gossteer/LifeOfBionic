use Life_of_Bionic
go

create procedure Select_Personal_Like_Category
as
SELECT         dbo.Personal.id_worker, dbo.Personal.NamePers+ ' ' + 
                         dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers as 'Сотрудник',  dbo.SpecialityPersonal.Name_SpecialityPersonal as 'Специализация'
FROM            dbo.Personal INNER JOIN
                         dbo.Role ON dbo.Personal.id_Role = dbo.Role.id_Role INNER JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal
						 WHERE SpecialityPersonal.Name_SpecialityPersonal not LIKE 'Админ' 
						 and SpecialityPersonal.Name_SpecialityPersonal not LIKE 'Подсобный рабочий'
						 and SpecialityPersonal.Name_SpecialityPersonal not LIKE 'Регистратор'
						 and SpecialityPersonal.Name_SpecialityPersonal not LIKE 'Неопределенный пользователь' and
						 Personal_Logical_Delete = 0
						 
