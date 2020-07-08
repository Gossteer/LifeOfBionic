use [Life_of_Bionic]  --удаление категории лекарств
go
create procedure [del_CategoryOfMedicament]
@id_CategoryOfMedicament int
as
delete from [dbo].[CategoryOfMedicament]
where
id_CategoryOfMedicament = @id_CategoryOfMedicament
