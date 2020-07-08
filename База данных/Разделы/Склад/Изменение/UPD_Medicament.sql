use [Life_of_Bionic] -- изменение лекарств
go
create procedure [UPD_Medicament]
@id_Medicament int,
@Name_Medicament varchar (100),
@id_Manufacturer int,
@id_CategoryOfMedicament int
as
if (@id_Medicament != (Select Medicament.id_Medicament FROM Medicament WHERE Medicament.Name_Medicament = @Name_Medicament and Medicament.id_Manufacturer = @id_Manufacturer 
and Medicament.id_CategoryOfMedicament = @id_CategoryOfMedicament and Medicament.Medicament_Logical_Delete = 0))
THROW 50657, 'ƒанный медикамент уже создан',1
else if (@id_Medicament != (Select Medicament.id_Medicament FROM Medicament WHERE Medicament.Name_Medicament = @Name_Medicament and Medicament.id_Manufacturer = @id_Manufacturer 
and Medicament.id_CategoryOfMedicament = @id_CategoryOfMedicament and Medicament.Medicament_Logical_Delete = 1))
begin
Update [dbo].[Medicament]
set
Medicament_Logical_Delete = 0
where
	id_Medicament = (Select Medicament.id_Medicament FROM Medicament WHERE Medicament.Name_Medicament = @Name_Medicament and Medicament.id_Manufacturer = @id_Manufacturer 
and Medicament.id_CategoryOfMedicament = @id_CategoryOfMedicament and Medicament.Medicament_Logical_Delete = 1)
	Update [dbo].[Medicament]
set
Medicament_Logical_Delete = 1
where
	id_Medicament = @id_Medicament
	end
	else
Update [dbo].[Medicament]
set
	Name_Medicament = @Name_Medicament,
	id_Manufacturer = @id_Manufacturer,
	id_CategoryOfMedicament = @id_CategoryOfMedicament
where
	id_Medicament = @id_Medicament
