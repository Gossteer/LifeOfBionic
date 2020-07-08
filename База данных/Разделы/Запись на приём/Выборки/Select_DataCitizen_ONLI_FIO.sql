use Life_of_Bionic
go

create procedure Select_DataCitizen_ONLI_FIO
as
SELECT id_Citizen, SurnameCit  + ' ' + NameCit + ' ' + PatronymicCit as 'ФИО'
FROM     dbo.DataCitizen