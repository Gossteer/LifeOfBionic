use [Life_of_Bionic]  --удаление производителя
go
create procedure [del_Manufacturer]
@id_Manufacturer int
as
delete from [dbo].[Manufacturer]
where
id_Manufacturer = @id_Manufacturer