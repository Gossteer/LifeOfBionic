use [Life_of_Bionic]  --удаление склада
go
create procedure [del_Storage]
@id_Spot int
as
delete from [dbo].[Storage]
where
id_Spot = @id_Spot