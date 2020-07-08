use [Life_of_Bionic]  --Добавление терапевтического отделения
go
create procedure [Add_TherapeuticDepartament]
@amountRooms int,
@id_worker int,
@id_CategoriesDisease int
as
insert into [dbo].[TherapeuticDepartament] (amountRooms,id_worker,id_CategoriesDisease)
values (@amountRooms,@id_worker,@id_CategoriesDisease)