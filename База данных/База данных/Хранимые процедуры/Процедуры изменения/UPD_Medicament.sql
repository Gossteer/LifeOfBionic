use [Life_of_Bionic] -- изменение лекарств
go
create procedure [UPD_Medicament]
@id_Medicament int,
@Name_Medicament varchar (100),
@id_Manufacturer int,
@id_CategoryOfMedicament int
as
Update [dbo].[Medicament]
set
	Name_Medicament = @Name_Medicament,
	id_Manufacturer = @id_Manufacturer,
	id_CategoryOfMedicament = @id_CategoryOfMedicament
where
	id_Medicament = @id_Medicament