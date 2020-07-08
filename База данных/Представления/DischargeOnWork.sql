create view DischargeOnWork as
SELECT        
	dbo.TypeDischarge.NameDischarge as 'Наименование выписки', 
	dbo.DataCitizen.SurnameCit +' ' + dbo.DataCitizen.NameCit + ' ' +dbo.DataCitizen.PatronymicCit as 'ФИО пациента', 
	convert(varchar,[dbo].DataCitizen.SeriesPassportCit) + ' ' + convert(varchar,[dbo].DataCitizen.NumberPassportCit) as 'Серия,номер паспорта',  
	dbo.DataCitizen.DateBirthCit as 'Дата рождения', 
	dbo.DirectoryDisease.Name_Disease as 'Название заболевания', 
	dbo.WriteAppointment.times as 'Дата поступления',
	dbo.Diagnosis.TimeDisease as 'Срок лечения', 
	dbo.CardTreatments.Cured as 'Статус лечения', 
	dbo.Discharge.DateDischarge as 'Дата выписки',
	dbo.Personal.SurnamePers +' '+ dbo.Personal.namePers +' '+ dbo.Personal.PatronymicPers as 'ФИО врача'
FROM            
	dbo.DataCitizen INNER JOIN
	dbo.TypeDischarge INNER JOIN
	dbo.Discharge ON dbo.TypeDischarge.id_TypeDischarge = dbo.Discharge.id_TypeDischarge INNER JOIN
	dbo.DirectoryDisease INNER JOIN
	dbo.Diagnosis ON dbo.DirectoryDisease.id_Disease = dbo.Diagnosis.id_Disease INNER JOIN
	dbo.CardTreatments ON dbo.Diagnosis.id_Diagnoz = dbo.CardTreatments.id_Diagnoz INNER JOIN
	dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment ON dbo.Discharge.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment ON 
	dbo.DataCitizen.id_Citizen = dbo.WriteAppointment.id_Citizen INNER JOIN
	dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room INNER JOIN
	dbo.Personal ON dbo.TherapeuticDepartament.id_worker = dbo.Personal.id_worker
where
NameDischarge = 'Рабочая выписка'