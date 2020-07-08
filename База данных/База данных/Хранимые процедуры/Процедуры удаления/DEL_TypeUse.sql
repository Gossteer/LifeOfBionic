use [Life_of_Bionic]  --удаление типа употребления
go
create procedure [del_TypeUse]
@id_TypeUse int
as
delete from [dbo].[TypeUse]
where
id_TypeUse = @id_TypeUse