SELECT        
dbo.DataCitizen.SurnameCit + dbo.DataCitizen.NameCit + dbo.DataCitizen.PatronymicCit as '��� ��������', 
dbo.DataCitizen.Snils as '�����',  
dbo.FormWrite.Adress as '������', 
dbo.FormWrite.Sites as '����', 
dbo.FormWrite.PhoneNumber as '����� ��������',
dbo.FormWrite.mail as '�������� ����',  
dbo.WriteAppointment.visit as '���� �� ���������', 
dbo.WriteAppointment.times as '����� ������'
FROM            dbo.DataCitizen INNER JOIN
                         dbo.WriteAppointment ON dbo.DataCitizen.id_Citizen = dbo.WriteAppointment.id_Citizen INNER JOIN
                         dbo.FormWrite ON dbo.WriteAppointment.id_FormWrite = dbo.FormWrite.id_FormWrite