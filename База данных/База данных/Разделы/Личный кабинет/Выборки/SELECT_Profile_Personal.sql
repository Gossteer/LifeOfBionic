use [Life_of_Bionic]
GO

create procedure [dbo].[SELECT_Profile_Personal]
@User_Nick varchar (50)
as
SELECT        dbo.Personal.NamePers, dbo.Personal.SurnamePers, dbo.Personal.PatronymicPers, dbo.Personal.SeriesPassportPers, dbo.Personal.NumberPassportPers, dbo.Personal.id_worker, dbo.Personal.User_Nick, 
                         dbo.WorkSchedule.weekdays, dbo.SpecialityPersonal.Name_SpecialityPersonal
FROM            dbo.Personal INNER JOIN
                         dbo.Role ON dbo.Personal.id_Role = dbo.Role.id_Role INNER JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal INNER JOIN
                         dbo.WorkSchedule ON dbo.Personal.id_WorkSchedule = dbo.WorkSchedule.id_WorkSchedule
						 WHERE Personal.User_Nick = @User_Nick