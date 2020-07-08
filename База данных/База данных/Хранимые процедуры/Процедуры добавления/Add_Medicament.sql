use [Life_of_Bionic]  --Добавление лекарства
go
create procedure [Add_Medicament]
@Name_Medicament varchar (100),
@id_Manufacturer int,
@id_CategoryOfMedicament int,
@Medicament_Logical_Delete bit
as
insert into [dbo].[Medicament] (Name_Medicament,id_Manufacturer,id_CategoryOfMedicament,Medicament_Logical_Delete)
values (@Name_Medicament,@id_Manufacturer,@id_CategoryOfMedicament,@Medicament_Logical_Delete)