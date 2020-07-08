use [Life_of_Bionic] -- изменение данных граждан
go
create procedure [Search_DataCitizen]
@Snils varchar (11)
as
SELECT NameCit, SurnameCit, PatronymicCit, Snils, SeriesPassportCit, NumberPassportCit, DateBirthCit
FROM [dbo].[DataCitizen]
where
	Snils = @Snils

exec Search_DataCitizen 11122233344