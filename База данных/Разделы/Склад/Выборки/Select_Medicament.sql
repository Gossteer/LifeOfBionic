USE [Life_of_Bionic]
GO
/****** Object:  StoredProcedure [dbo].[Select_Medicament]    Script Date: 30.05.2019 22:35:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[Select_Medicament]
as
SELECT  dbo.Medicament.id_Medicament, dbo.Medicament.Name_Medicament
FROM            dbo.Medicament 
WHERE dbo.Medicament.Medicament_Logical_Delete = 0
