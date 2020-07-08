USE [Life_of_Bionic]
GO
/****** Object:  StoredProcedure [dbo].[Select_CardTreatments]    Script Date: 27.05.2019 18:33:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter procedure [dbo].[Search_CardTreatments]
@Snils varchar(11)
as
SELECT  dbo.CardTreatments.id_WriteAppointment, dbo.DataCitizen.NameCit + ' ' + dbo.DataCitizen.SurnameCit+ ' ' + dbo.DataCitizen.PatronymicCit as 'ФИО', dbo.DataCitizen.Snils AS 'СНИЛС', COUNT(dbo.CardTreatments.id_Diagnoz) as 'Количество диагнозов',
 ISNULL(dbo.WriteAppointment.MedicalDepartament, 0) AS 'Палата лечения', ISNULL(WriteAppointment.СategoriesDisease, 'Пациенту не назначен активный диагноз') as 'Категория болезни'
FROM   dbo.CardTreatments INNER JOIN
                         dbo.Diagnosis ON dbo.CardTreatments.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment INNER JOIN
                         dbo.DataCitizen ON dbo.WriteAppointment.id_Citizen = dbo.DataCitizen.id_Citizen
				  
WHERE dbo.WriteAppointment.visit = 1 and dbo.WriteAppointment.SentToTreatment = 1 and dbo.CardTreatments.CardTreatments_Logical_Delete = 0 and dbo.DataCitizen.Snils = @Snils
GROUP BY dbo.CardTreatments.id_WriteAppointment,dbo.DataCitizen.NameCit, dbo.DataCitizen.SurnameCit, dbo.DataCitizen.PatronymicCit, dbo.DataCitizen.Snils,
 dbo.WriteAppointment.MedicalDepartament, WriteAppointment.СategoriesDisease







