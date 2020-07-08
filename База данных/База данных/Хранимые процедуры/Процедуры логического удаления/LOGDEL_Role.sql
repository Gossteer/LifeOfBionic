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
