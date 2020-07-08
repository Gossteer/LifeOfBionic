create view DischargeOnSchoolCollege as
SELECT     
	[dbo].TypeDischarge.NameDischarge as '������������ �������',  
	[dbo].DataCitizen.SurnameCit as '�������',
	[dbo].DataCitizen.NameCit as '���', 
	[dbo].DataCitizen.PatronymicCit as '��������',
	[dbo].DataCitizen.DateBirthCit as '���� ��������', 
	[dbo].DirectoryDisease.Name_Disease as '�������', 
	[dbo].Diagnosis.TimeDisease as '���� �������',
	[dbo].CardTreatments.Cured as '������ �������',
	[dbo].WriteAppointment.times as '���� �����������', 
	[dbo].Discharge.DateDischarge as '���� �������', 
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
NameDischarge = '� ������� ���������'