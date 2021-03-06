USE [Life_of_Bionic]
GO
/****** Object:  StoredProcedure [dbo].[Select_Id_Departament]    Script Date: 28.05.2019 23:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[Select_Id_Departament]
as
SELECT dbo.TherapeuticDepartament.id_Room, '№'+CONVERT(varchar, dbo.TherapeuticDepartament.id_Room) + ' свободных мест: ' + 
CONVERT(varchar,(TherapeuticDepartament.amountRooms - dbo.TherapeuticDepartament.BusyRoom)) as 'Терапевтическое отделение'
FROM dbo.TherapeuticDepartament
WHERE dbo.TherapeuticDepartament.amountRooms != dbo.TherapeuticDepartament.BusyRoom and dbo.TherapeuticDepartament.TherapeuticDepartament_Logical_Delete = 0
