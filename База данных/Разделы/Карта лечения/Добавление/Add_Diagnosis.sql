USE [Life_of_Bionic]
GO
/****** Object:  StoredProcedure [dbo].[Add_Diagnosis]    Script Date: 29.05.2019 19:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Add_Diagnosis]
@TimeDisease int,
@Amount int,
@ID_Room int,
@id_TypeUse int,
@id_Medicament int,
@id_Disease int
as
DECLARE @id_Diagnosis int
if (EXISTS(Select Diagnosis.id_Diagnoz FROM [dbo].[Diagnosis] WHERE TimeDisease = @TimeDisease and Amount = @Amount 
and ID_Room = @ID_Room and id_TypeUse = @id_TypeUse and id_Medicament = @id_Medicament and id_Disease = @id_Disease and Diagnosis_Logical_Delete = 1))
begin
set @id_Diagnosis = (Select Diagnosis.id_Diagnoz FROM [dbo].[Diagnosis] WHERE TimeDisease = @TimeDisease and Amount = @Amount 
and ID_Room = @ID_Room and id_TypeUse = @id_TypeUse and id_Medicament = @id_Medicament and id_Disease = @id_Disease) 
exec UPD_Diagnosis @id_Diagnosis, @TimeDisease,@Amount,@ID_Room,@id_TypeUse,@id_Medicament,@id_Disease, 0
end
else if (EXISTS(Select Diagnosis.id_Diagnoz FROM [dbo].[Diagnosis] WHERE TimeDisease = @TimeDisease and Amount = @Amount 
and ID_Room = @ID_Room and id_TypeUse = @id_TypeUse and id_Medicament = @id_Medicament and id_Disease = @id_Disease and Diagnosis_Logical_Delete = 0))
THROW 50255, 'Данный диагноз уже существует',1
else
insert into [dbo].[Diagnosis] (TimeDisease,Amount,ID_Room,id_TypeUse,id_Medicament,id_Disease)
values (@TimeDisease,@Amount,@ID_Room,@id_TypeUse,@id_Medicament,@id_Disease)