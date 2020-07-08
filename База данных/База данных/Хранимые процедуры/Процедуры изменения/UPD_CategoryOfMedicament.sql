use [Life_of_Bionic] -- изменение категории лекарств
go
create procedure [UPD_CategoryOfMedicament]
@id_CategoryOfMedicament int,
@N_MedCategory varchar (2)
as
Update [dbo].[CategoryOfMedicament]
set
	Name_MedCategory = @N_MedCategory
where
id_CategoryOfMedicament = @id_CategoryOfMedicament