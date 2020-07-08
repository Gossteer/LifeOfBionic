use [Life_of_Bionic]  --удаление типа выписки
go
create procedure [del_TypeDischarge]
@id_TypeDischarge int
as
delete from [dbo].[TypeDischarge]
where
id_TypeDischarge = @id_TypeDischarge