use Life_of_Bionic
go

create procedure Select_Personal
as
SELECT       Role.id_Role, Personal.id_worker, dbo.Personal.SurnamePers + ' ' + dbo.Personal.NamePers + ' ' + dbo.Personal.PatronymicPers as 'ФИО', 
Convert(varchar,Personal.SeriesPassportPers) + ' ' + Convert(varchar,Personal.NumberPassportPers) as 'Серия и номер', isnull(WorkSchedule.weekdays,'Не назначен') as 'Рабочий график',
dbo.Role.id_Role as 'Номер роли', isnull(dbo.SpecialityPersonal.Name_SpecialityPersonal, 'Не назначена') as 'Специализация'
FROM            dbo.Personal LEFT JOIN
                         dbo.Role ON dbo.Personal.id_Role = dbo.Role.id_Role LEFT JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal LEFT JOIN
                         dbo.WorkSchedule ON dbo.Personal.id_WorkSchedule = dbo.WorkSchedule.id_WorkSchedule
						 WHERE Personal.Personal_Logical_Delete = 0