use [Life_of_Bionic]  --удаление роли
go
create procedure [del_Role]
@id_Role int
as
delete from [dbo].[Role]
where
id_Role = @id_Role