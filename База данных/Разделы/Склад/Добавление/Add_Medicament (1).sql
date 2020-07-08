use [Life_of_Bionic]  --Добавление лекарства
go
create procedure [Add_Medicament]
@Name_Medicament varchar (100),
@id_Manufacturer int,
@id_CategoryOfMedicament int
as
if (EXISTS(Select Medicament.id_Medicament FROM Medicament WHERE Medicament.Name_Medicament = @Name_Medicament and Medicament.id_Manufacturer = @id_Manufacturer 
and Medicament.id_CategoryOfMedicament = @id_CategoryOfMedicament and Medicament.Medicament_Logical_Delete = 0 ))
THROW 50258, 'Данное лекарство уже существует',1
else if (EXISTS(Select Medicament.id_Medicament FROM Medicament WHERE Medicament.Name_Medicament = @Name_Medicament and Medicament.id_Manufacturer = @id_Manufacturer 
and Medicament.id_CategoryOfMedicament = @id_CategoryOfMedicament and Medicament.Medicament_Logical_Delete = 1 ))
Update [dbo].[Medicament]
set
	Medicament_Logical_Delete = 0
where
	id_Medicament = (Select Medicament.id_Medicament FROM Medicament WHERE Medicament.Name_Medicament = @Name_Medicament and Medicament.id_Manufacturer = @id_Manufacturer 
and Medicament.id_CategoryOfMedicament = @id_CategoryOfMedicament and Medicament.Medicament_Logical_Delete = 1 )
else
insert into [dbo].[Medicament] (Name_Medicament,id_Manufacturer,id_CategoryOfMedicament)
values (@Name_Medicament,@id_Manufacturer,@id_CategoryOfMedicament)
