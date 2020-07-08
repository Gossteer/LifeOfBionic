use [Life_of_Bionic] -- изменение диагноза
go
create procedure [UPD_Diagnosis]
@id_Diagnoz int,
@TimeDisease int,
@Amount int,
@ID_Room int,
@id_TypeUse int,
@id_Medicament int,
@id_Disease int
as
Update [dbo].[Diagnosis]
set
	TimeDisease= @TimeDisease,
	Amount = @Amount,
	id_Medicament = @id_Medicament,
	ID_Room = @ID_Room, 
	id_TypeUse = @id_TypeUse,
	id_Disease = @id_Disease
where
	id_Diagnoz = @id_Diagnoz