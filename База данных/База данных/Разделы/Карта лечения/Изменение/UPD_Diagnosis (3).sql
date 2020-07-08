use [Life_of_Bionic] -- изменение диагноза
go
alter procedure [UPD_Diagnosis]
@id_Diagnoz int,
@TimeDisease int,
@Amount int,
@ID_Room int,
@id_TypeUse int,
@id_Medicament int,
@id_Disease int,
@Diagnosis_Logical_Deletebit bit
as
if (@id_Diagnoz != (Select Diagnosis.id_Diagnoz FROM [dbo].[Diagnosis] WHERE TimeDisease = @TimeDisease and Amount = @Amount 
and ID_Room = @ID_Room and id_TypeUse = @id_TypeUse and id_Medicament = @id_Medicament and id_Disease = @id_Disease and Diagnosis_Logical_Delete = 0))
THROW 50255, 'Данный диагноз уже существует',1
else if (@id_Diagnoz != (Select Diagnosis.id_Diagnoz FROM [dbo].[Diagnosis] WHERE TimeDisease = @TimeDisease and Amount = @Amount 
and ID_Room = @ID_Room and id_TypeUse = @id_TypeUse and id_Medicament = @id_Medicament and id_Disease = @id_Disease and Diagnosis_Logical_Delete = 1))
begin
Update [dbo].[Diagnosis]
set
	Diagnosis_Logical_Delete = 0
where
	id_Diagnoz = (Select Diagnosis.id_Diagnoz FROM [dbo].[Diagnosis] WHERE TimeDisease = @TimeDisease and Amount = @Amount 
and ID_Room = @ID_Room and id_TypeUse = @id_TypeUse and id_Medicament = @id_Medicament and id_Disease = @id_Disease and Diagnosis_Logical_Delete = 1)
Update [dbo].[Diagnosis]
set
	Diagnosis_Logical_Delete = 1
where
	id_Diagnoz = @id_Diagnoz
	end
	else
Update [dbo].[Diagnosis]
set
	TimeDisease= @TimeDisease,
	Amount = @Amount,
	id_Medicament = @id_Medicament,
	ID_Room = @ID_Room, 
	id_TypeUse = @id_TypeUse,
	id_Disease = @id_Disease,
	Diagnosis_Logical_Delete = @Diagnosis_Logical_Deletebit
	
where
	id_Diagnoz = @id_Diagnoz