use [Life_of_Bionic]  --�������� ����
go
create procedure [del_Role]
@id_Role int
as
delete from [dbo].[Role]
where
id_Role = @id_Role