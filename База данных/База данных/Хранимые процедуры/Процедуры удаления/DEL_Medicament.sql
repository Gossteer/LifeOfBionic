use [Life_of_Bionic]  --удаление лекарства
go
create procedure [del_Medicament]
@id_Medicament int
as
delete from [dbo].[Medicament]
where
id_Medicament = @id_Medicament