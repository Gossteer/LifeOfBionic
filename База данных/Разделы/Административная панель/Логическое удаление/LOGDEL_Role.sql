use [Life_of_Bionic]  -- логическое удаление роли
go
create procedure [logdel_Role]
@id_Role int
as
Update [dbo].[Role]
set
	Role_Logical_Delete = 1
where
id_Role = @id_Role
Update [dbo].[Personal]
set
	id_Role = null
where
id_Role = @id_Role

Update [dbo].[TherapeuticDepartament]
set
	id_worker = null
where
TherapeuticDepartament.id_worker IN (SELECT        dbo.Personal.id_worker
FROM            dbo.Personal INNER JOIN
                         dbo.TherapeuticDepartament ON dbo.Personal.id_worker = dbo.TherapeuticDepartament.id_worker
						 where Personal.id_Role = NULL and Personal_Logical_Delete = 0)
