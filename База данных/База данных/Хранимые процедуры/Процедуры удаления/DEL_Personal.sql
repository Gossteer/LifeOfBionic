use [Life_of_Bionic]  --удаление сотрудника
go
create procedure [del_Personal]
@id_worker int
as
delete from [dbo].[Personal]
where
id_worker = @id_worker