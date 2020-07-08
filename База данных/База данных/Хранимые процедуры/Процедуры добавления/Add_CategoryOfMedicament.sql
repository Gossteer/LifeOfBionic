use [Life_of_Bionic]  --Добавление Категории медикаментов
go 
create procedure [Add_CategoryOfMedicament]
@N_MedCategory varchar (2),
@CategoryOfMedicament_Logical_Delete bit
as
insert into [dbo].[CategoryOfMedicament] (Name_MedCategory,CategoryOfMedicament_Logical_Delete)
values (@N_MedCategory,@CategoryOfMedicament_Logical_Delete)