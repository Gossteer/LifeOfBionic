USE [Life_of_Bionic]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
aLTER procedure Select_Spesialization_For_Personal
@User_Nick varchar (50)
as	
SELECT        dbo.SpecialityPersonal.Name_SpecialityPersonal
FROM            dbo.Personal INNER JOIN
                         dbo.Role ON dbo.Personal.id_Role = dbo.Role.id_Role INNER JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal
						 WHERE dbo.Personal.User_Nick = @User_Nick

	

