use Life_of_Bionic
go

create procedure Search__Personal_For_Admin
@Name_Personal varchar (50)
as
SELECT       Role.id_Role, Personal.id_worker, dbo.Personal.SurnamePers + ' ' + dbo.Personal.NamePers + ' ' + dbo.Personal.PatronymicPers as 'ФИО', 
Convert(varchar,Personal.SeriesPassportPers) + ' ' + Convert(varchar,Personal.NumberPassportPers) as 'Серия и номер', dbo.Role.id_Role as 'Номер роли', dbo.SpecialityPersonal.Name_SpecialityPersonal as 'Специализация'
FROM            dbo.Role INNER JOIN
                         dbo.Personal ON dbo.Role.id_Role = dbo.Personal.id_Role INNER JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal
						 WHERE Personal.Personal_Logical_Delete = 0 and dbo.Personal.NamePers+ ' ' + 
                         dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers LIKE '%' + @Name_Personal + '%' 