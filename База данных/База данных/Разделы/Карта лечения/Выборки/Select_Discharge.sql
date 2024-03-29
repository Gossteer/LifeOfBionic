USE [Life_of_Bionic]
GO
/****** Object:  StoredProcedure [dbo].[Select_Discharge]    Script Date: 29.05.2019 14:16:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[Select_Discharge]
@ID_WriteAppointment int
as
SELECT Discharge.id_Discharge, dbo.DataCitizen.NameCit + ' ' + dbo.DataCitizen.SurnameCit + ' ' + dbo.DataCitizen.PatronymicCit as 'ФИО' , 
dbo.DataCitizen.Snils as 'Снилс', dbo.TypeDischarge.NameDischarge as 'Тип выписки', dbo.Discharge.DateDischarge as 'Дата выписки'
FROM     dbo.Discharge INNER JOIN
                         dbo.TypeDischarge ON dbo.Discharge.id_TypeDischarge = dbo.TypeDischarge.id_TypeDischarge INNER JOIN
                         dbo.WriteAppointment ON dbo.Discharge.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment INNER JOIN
                         dbo.DataCitizen ON dbo.WriteAppointment.id_Citizen = dbo.DataCitizen.id_Citizen
WHERE dbo.WriteAppointment.id_WriteAppointment = @ID_WriteAppointment and Discharge.Discharge_Logical_Delete = 0