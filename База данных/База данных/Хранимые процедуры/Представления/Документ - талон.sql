SELECT        
dbo.DataCitizen.SurnameCit + dbo.DataCitizen.NameCit + dbo.DataCitizen.PatronymicCit as 'ФИО пациента', 
dbo.DataCitizen.Snils as 'Снилс',  
dbo.FormWrite.Adress as 'Адресс', 
dbo.FormWrite.Sites as 'Сайт', 
dbo.FormWrite.PhoneNumber as 'Номер телефона',
dbo.FormWrite.mail as 'Почтовый ящик',  
dbo.WriteAppointment.visit as 'Было ли посещение', 
dbo.WriteAppointment.times as 'Время записи'
FROM            dbo.DataCitizen INNER JOIN
                         dbo.WriteAppointment ON dbo.DataCitizen.id_Citizen = dbo.WriteAppointment.id_Citizen INNER JOIN
                         dbo.FormWrite ON dbo.WriteAppointment.id_FormWrite = dbo.FormWrite.id_FormWrite