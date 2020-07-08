use Life_of_Bionic
go

create procedure Select_DataCitizen
as
SELECT id_Citizen, SurnameCit  + ' ' + NameCit + ' ' + PatronymicCit as 'ФИО', Snils as 'Снилс', 
CONVERT(VARCHAR, SeriesPassportCit) + ' ' + CONVERT(VARCHAR, NumberPassportCit) AS 'Серия и номер', DateBirthCit as 'День рождения'
FROM     dbo.DataCitizen