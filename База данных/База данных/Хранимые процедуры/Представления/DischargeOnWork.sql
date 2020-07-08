create view DischargeOnWork as

SELECT     
	[dbo].TypeDischarge.NameDischarge as 'Наименование выписки',  
	[dbo].DataCitizen.SurnameCit + ' ' + [dbo].DataCitizen.NameCit + ' ' + [dbo].DataCitizen.NameCit as 'ФИО гражданина', 
	convert(varchar,[dbo].DataCitizen.SeriesPassportCit) + ' ' + convert(varchar,[dbo].DataCitizen.NumberPassportCit) as 'Серия,номер паспорта', 
	[dbo].DataCitizen.DateBirthCit as 'Дата рождения', 
	[dbo].DirectoryDisease.Name_Disease as 'Болезнь', 
	[dbo].Diagnosis.TimeDisease as 'Срок лечения',
	[dbo].CardTreatments.Cured as 'Статус лечения',
	convert(varchar,[dbo].WriteAppointment.times) as 'Дата поступления', 
	[dbo].Discharge.DateDischarge as 'Дата выписки', 
	[dbo].DirectoryDisease.id_Disease, 
	[dbo].Discharge.id_Discharge, 
	[dbo].TypeDischarge.id_TypeDischarge, 
	[dbo].DataCitizen.id_Citizen, 
	[dbo].CardTreatments.id_card, 
	[dbo].Diagnosis.id_Diagnoz 
FROM 
	dbo.CardTreatments INNER JOIN
	dbo.Discharge ON dbo.CardTreatments.id_card = dbo.Discharge.id_card INNER JOIN
	dbo.TypeDischarge ON dbo.Discharge.id_TypeDischarge = dbo.TypeDischarge.id_TypeDischarge INNER JOIN
	dbo.Diagnosis ON dbo.CardTreatments.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
	dbo.DirectoryDisease ON dbo.Diagnosis.id_Disease = dbo.DirectoryDisease.id_Disease INNER JOIN
	dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment INNER JOIN
	dbo.DataCitizen ON dbo.WriteAppointment.id_Citizen = dbo.DataCitizen.id_Citizen
where
NameDischarge = 'Рабочая выписка'