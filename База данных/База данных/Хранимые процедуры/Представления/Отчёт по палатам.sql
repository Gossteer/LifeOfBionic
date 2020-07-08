create view TherapeuiticDepartamentINFO AS
SELECT        
	dbo.TherapeuticDepartament.id_Room as 'Номер палаты', 
	dbo.TherapeuticDepartament.amountRooms as 'Количество мест', 
	dbo.TherapeuticDepartament.BusyRoom as 'Занято мест', 
	dbo.Personal.NamePers + ' ' + dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers as 'ФИО сотрудника', 
	dbo.CategoriesDisease.Name_CategoriesDisease as 'Категория заболеваний', 
	dbo.DataCitizen.NameCit + ' ' + dbo.DataCitizen.PatronymicCit  + ' ' + dbo.DataCitizen.SurnameCit as 'ФИО пациента', 
	dbo.CardTreatments.id_card as 'Номер карты'

FROM            
	dbo.CategoriesDisease INNER JOIN
	dbo.TherapeuticDepartament ON dbo.CategoriesDisease.id_CategoriesDisease = dbo.TherapeuticDepartament.id_CategoriesDisease INNER JOIN
	dbo.Personal ON dbo.TherapeuticDepartament.id_worker = dbo.Personal.id_worker INNER JOIN
	dbo.Diagnosis ON dbo.TherapeuticDepartament.id_Room = dbo.Diagnosis.ID_Room INNER JOIN
	dbo.CardTreatments ON dbo.Diagnosis.id_Diagnoz = dbo.CardTreatments.id_Diagnoz INNER JOIN
	dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment INNER JOIN
	dbo.DataCitizen ON dbo.WriteAppointment.id_Citizen = dbo.DataCitizen.id_Citizen
