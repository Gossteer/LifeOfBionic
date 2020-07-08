use [Life_of_Bionic]  -- логическое удаление категории лекарств
go
create procedure [logdel_CategoryOfMedicament]
@id_CategoryOfMedicament int
as
Update [dbo].[CategoryOfMedicament]
set
	CategoryOfMedicament_Logical_Delete = 1
where
id_CategoryOfMedicament = @id_CategoryOfMedicament
