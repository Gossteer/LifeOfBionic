USE [Life_of_Bionic]
GO
/****** Object:  StoredProcedure [dbo].[UPD_CardTreatments]    Script Date: 28.05.2019 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter procedure [dbo].[UPD_CardTreatments]
@id_WriteAppointment int,
@id_Diagnoz int,
@Cured bit
as
DECLARE @id_card int
SET @id_card = (Select CardTreatments.id_card FROM CardTreatments WHERE CardTreatments.id_Diagnoz = @id_Diagnoz and 
CardTreatments.id_WriteAppointment = @id_WriteAppointment and CardTreatments.Cured = 0 and CardTreatments_Logical_Delete = 0)
Update [dbo].[CardTreatments]
set
	Cured = @Cured
where
ID_card = @ID_card

if (EXISTS(Select CardTreatments.id_card FROM CardTreatments WHERE CardTreatments.id_WriteAppointment = @id_WriteAppointment and CardTreatments.Cured = 0 and CardTreatments.CardTreatments_Logical_Delete = 0))
Update [dbo].[WriteAppointment]
set
	MedicalDepartament = NULL,
	СategoriesDisease = NULL
where
id_WriteAppointment = @id_WriteAppointment



