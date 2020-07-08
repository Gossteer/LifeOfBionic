use [Life_of_Bionic] -- изменение склада
go
create procedure [UPD_Storage]
@id_Spot int,
@Amount int,
@occupiedSpace int
as
Update [dbo].[Storage]
set
	Amount = @Amount,
	occupiedSpace = @occupiedSpace
where
	id_Spot = @id_Spot