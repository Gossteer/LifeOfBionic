use [Life_of_Bionic] -- изменение терапевтического отделени€
go
create procedure [UPD_TherapeuticDepartament]
@id_Room int,
@amountRooms int,
@id_worker int,
@id_CategoriesDisease int
as
DECLARE @Answer_UPD_TherapeuticDepartament_Amount bit
SET @Answer_UPD_TherapeuticDepartament_Amount = (select dbo.Answer_UPD_TherapeuticDepartament_Amount (@id_Room,@amountRooms))
if (@Answer_UPD_TherapeuticDepartament_Amount = 0)
THROW 50663, ' оличество мест не может быть меньше количества зан€тых', 1
else
Update [dbo].[TherapeuticDepartament]
set
	amountRooms = @amountRooms,
	id_worker = @id_worker,
	id_CategoriesDisease = @id_CategoriesDisease
where
	id_Room = @id_Room
