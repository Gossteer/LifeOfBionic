use [Life_of_Bionic] -- изменение терапевтического отделения
go
create procedure [UPD_TherapeuticDepartament]
@id_Room int,
@amountRooms int,
@BusyRoom int,
@id_worker int,
@id_CategoriesDisease int
as
Update [dbo].[TherapeuticDepartament]
set
	amountRooms = @amountRooms,
	BusyRoom = @BusyRoom,
	id_worker = @id_worker,
	id_CategoriesDisease = @id_CategoriesDisease
where
	id_Room = @id_Room