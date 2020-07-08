create view DischargeOnWork as
SELECT        
	dbo.TypeDischarge.NameDischarge as '������������ �������', 
	dbo.DataCitizen.SurnameCit +' ' + dbo.DataCitizen.NameCit + ' ' +dbo.DataCitizen.PatronymicCit as '��� ��������', 
	convert(varchar,[dbo].DataCitizen.SeriesPassportCit) + ' ' + convert(varchar,[dbo].DataCitizen.NumberPassportCit) as '�����,����� ��������',  
	dbo.DataCitizen.DateBirthCit as '���� ��������', 
	dbo.DirectoryDisease.Name_Disease as '�������� �����������', 
	dbo.WriteAppointment.times as '���� �����������',
	dbo.Diagnosis.TimeDisease as '���� �������', 
	dbo.CardTreatments.Cured as '������ �������', 
	dbo.Discharge.DateDischarge as '���� �������',
	dbo.Personal.SurnamePers +' '+ dbo.Personal.namePers +' '+ dbo.Personal.PatronymicPers as '��� �����'
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
NameDischarge = '������� �������'