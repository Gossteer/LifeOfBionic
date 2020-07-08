use [Life_of_Bionic]  -- логическое удаление роли
go
create procedure [SELECT_Regulation]
@User_Nick varchar (50)
as
SELECT        dbo.Regulation.id_Regulation, dbo.Regulation.TextRegulation
FROM            dbo.Personal INNER JOIN
                         dbo.Role ON dbo.Personal.id_Role = dbo.Role.id_Role INNER JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal INNER JOIN
                         dbo.Regulation ON dbo.SpecialityPersonal.id_SpecialityPersonal = dbo.Regulation.id_SpecialityPersonal
						 where Personal.User_Nick = @User_Nick and Regulation_Logical_Delete = 0