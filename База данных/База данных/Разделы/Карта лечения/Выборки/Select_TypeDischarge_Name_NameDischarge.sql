USE [Life_of_Bionic]
GO
/****** Object:  StoredProcedure [dbo].[Select_TypeDischarge_Name_NameDischarge]    Script Date: 29.05.2019 9:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[Select_TypeDischarge_Name_NameDischarge]
as
SELECT TypeDischarge.id_TypeDischarge, dbo.TypeDischarge.NameDischarge
FROM dbo.TypeDischarge
WHERE dbo.TypeDischarge.TypeDischarge_Logical_Delete = 0