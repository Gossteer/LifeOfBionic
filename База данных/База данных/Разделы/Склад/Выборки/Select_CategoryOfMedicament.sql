USE [Life_of_Bionic]
GO
/****** Object:  StoredProcedure [dbo].[Select_Medicament]    Script Date: 28.05.2019 19:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Select_CategoryOfMedicament]
as
SELECT CategoryOfMedicament.id_CategoryOfMedicament, CategoryOfMedicament.Name_MedCategory FROM CategoryOfMedicament
WHERE CategoryOfMedicament.CategoryOfMedicament_Logical_Delete = 0
