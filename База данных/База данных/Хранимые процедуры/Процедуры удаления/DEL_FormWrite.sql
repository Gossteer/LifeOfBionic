use [Life_of_Bionic]  --удаление формы записи
go
create procedure [del_FormWrite]
@id_FormWrite int
as
delete from [dbo].[FormWrite]
where
id_FormWrite = @id_FormWrite