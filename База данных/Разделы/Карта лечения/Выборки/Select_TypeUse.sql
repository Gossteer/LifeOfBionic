USE [Life_of_Bionic]
GO
/****** Object:  StoredProcedure [dbo].[Select_TypeUse]    Script Date: 29.05.2019 8:59:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[Select_TypeUse]
as
SELECT TypeUse.id_TypeUse, TypeUse.Name_Use FROM TypeUse
WHERE TypeUse.TypeUse_Logical_Delete = 0