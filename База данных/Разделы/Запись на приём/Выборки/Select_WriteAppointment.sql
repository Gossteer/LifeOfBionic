use Life_of_Bionic
go

create procedure Select_WriteAppointment
as
SELECT dbo.DataCitizen.id_Citizen, dbo.Personal.id_worker, dbo.WriteAppointment.id_WriteAppointment, dbo.FormWrite.id_FormWrite, dbo.Day_of_the_week.id_Day_of_the_week , dbo.DataCitizen.SurnameCit + ' ' + dbo.DataCitizen.NameCit + ' ' + dbo.DataCitizen.PatronymicCit AS 'ФИО', 
                  convert(varchar,dbo.WriteAppointment.times)+ ' ' + dbo.Day_of_the_week.Record_Time AS 'Время записи', dbo.WriteAppointment.visit AS 'Посетил', dbo.WriteAppointment.SentToTreatment AS 'Положили', 
				  dbo.TypeWrite.Name_Write AS 'Тип записи', dbo.Personal.SurnamePers + ' ' + dbo.Personal.NamePers + ' ' + dbo.Personal.PatronymicPers AS 'Регистратор'
FROM            dbo.Day_of_the_week INNER JOIN
                         dbo.DataCitizen INNER JOIN
                         dbo.TypeWrite INNER JOIN
                         dbo.FormWrite ON dbo.TypeWrite.id_TypeWrite = dbo.FormWrite.id_TypeWrite INNER JOIN
                         dbo.WriteAppointment ON dbo.FormWrite.id_FormWrite = dbo.WriteAppointment.id_FormWrite ON dbo.DataCitizen.id_Citizen = dbo.WriteAppointment.id_Citizen ON 
                         dbo.Day_of_the_week.id_Day_of_the_week = dbo.WriteAppointment.id_Day_of_the_week INNER JOIN
                         dbo.Personal ON dbo.FormWrite.id_worker = dbo.Personal.id_worker
						 Where WriteAppointment_Logical_Delete = 0