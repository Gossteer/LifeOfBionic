USE [Life_of_Bionic]
GO
/****** Object:  StoredProcedure [dbo].[Select_Medicament]    Script Date: 28.05.2019 19:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Select_Storage_Id]
as
SELECT Storage.id_spot, '№' + convert(varchar,Storage.id_spot) + '  мест: ' + CONVERT(VARCHAR,(Storage.Amount - Storage.occupiedSpace)) as 'Ячейка склада' From Storage
WHERE Storage.Storage_Logical_Delete = 0
