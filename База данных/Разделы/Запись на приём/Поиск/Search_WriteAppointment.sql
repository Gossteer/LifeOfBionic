use Life_of_Bionic
go

create procedure Search_WriteAppointment
@Name_DateCitizen varchar (100)
as
SELECT dbo.DataCitizen.id_Citizen, dbo.Personal.id_worker, dbo.WriteAppointment.id_WriteAppointment, dbo.FormWrite.id_FormWrite, dbo.DataCitizen.SurnameCit + ' ' + dbo.DataCitizen.NameCit + ' ' + dbo.DataCitizen.PatronymicCit AS 'ФИО', 
                  dbo.WriteAppointment.times AS 'Время записи', dbo.WriteAppointment.visit AS 'Посетил', dbo.WriteAppointment.SentToTreatment AS 'Положили', 
				  dbo.TypeWrite.Name_Write AS 'Тип записи', dbo.Personal.SurnamePers + ' ' + dbo.Personal.NamePers + ' ' + dbo.Personal.PatronymicPers AS 'Регистратор'
FROM     dbo.TypeWrite INNER JOIN
                  dbo.FormWrite ON dbo.TypeWrite.id_TypeWrite = dbo.FormWrite.id_TypeWrite INNER JOIN
                  dbo.WriteAppointment ON dbo.FormWrite.id_FormWrite = dbo.WriteAppointment.id_FormWrite INNER JOIN
                  dbo.DataCitizen ON dbo.WriteAppointment.id_Citizen = dbo.DataCitizen.id_Citizen INNER JOIN
                  dbo.Personal ON dbo.FormWrite.id_worker = dbo.Personal.id_worker
				  where SurnameCit  + ' ' + NameCit + ' ' + PatronymicCit like '%' + @Name_DateCitizen +'%'