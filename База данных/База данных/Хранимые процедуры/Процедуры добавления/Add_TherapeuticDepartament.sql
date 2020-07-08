use [Life_of_Bionic]  --Добавление терапевтического отделения
go
create procedure [Add_TherapeuticDepartament]
@amountRooms int,
@BusyRoom int,
@id_worker int,
@id_CategoriesDisease int,
@TherapeuticDepartament_Logical_Delete bit
as
insert into [dbo].[TherapeuticDepartament] (amountRooms,BusyRoom,id_worker,id_CategoriesDisease,TherapeuticDepartament_Logical_Delete)
values (@amountRooms,@BusyRoom,@id_worker,@id_CategoriesDisease,@TherapeuticDepartament_Logical_Delete)