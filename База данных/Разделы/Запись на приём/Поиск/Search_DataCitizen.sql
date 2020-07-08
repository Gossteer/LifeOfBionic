use Life_of_Bionic
go

create procedure Search_DataCitizen
@Name_DateCitizen varchar (100)
AS
SELECT id_Citizen, SurnameCit  + ' ' + NameCit + ' ' + PatronymicCit as 'ФИО', Snils as 'Снилс', 
CONVERT(VARCHAR, SeriesPassportCit) + ' ' + CONVERT(VARCHAR, NumberPassportCit) AS 'Серия и номер', DateBirthCit as 'День рождения'
FROM     dbo.DataCitizen
WHERE SurnameCit  + ' ' + NameCit + ' ' + PatronymicCit like '%' + @Name_DateCitizen +'%'