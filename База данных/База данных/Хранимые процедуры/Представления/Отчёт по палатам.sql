create view TherapeuiticDepartamentINFO AS
SELECT        
	dbo.TherapeuticDepartament.id_Room as '����� ������', 
	dbo.TherapeuticDepartament.amountRooms as '���������� ����', 
	dbo.TherapeuticDepartament.BusyRoom as '������ ����', 
	dbo.Personal.NamePers + ' ' + dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers as '��� ����������', 
	dbo.CategoriesDisease.Name_CategoriesDisease as '��������� �����������', 
	dbo.DataCitizen.NameCit + ' ' + dbo.DataCitizen.PatronymicCit  + ' ' + dbo.DataCitizen.SurnameCit as '��� ��������', 
	dbo.CardTreatments.id_card as '����� �����'

FROM            
	dbo.CategoriesDisease INNER JOIN
	dbo.TherapeuticDepartament ON dbo.CategoriesDisease.id_CategoriesDisease = dbo.TherapeuticDepartament.id_CategoriesDisease INNER JOIN
	dbo.Personal ON dbo.TherapeuticDepartament.id_worker = dbo.Personal.id_worker INNER JOIN
	dbo.Diagnosis ON dbo.TherapeuticDepartament.id_Room = dbo.Diagnosis.ID_Room INNER JOIN
	dbo.CardTreatments ON dbo.Diagnosis.id_Diagnoz = dbo.CardTreatments.id_Diagnoz INNER JOIN
	dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment INNER JOIN
	dbo.DataCitizen ON dbo.WriteAppointment.id_Citizen = dbo.DataCitizen.id_Citizen
