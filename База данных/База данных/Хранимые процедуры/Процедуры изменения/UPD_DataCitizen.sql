use [Life_of_Bionic] -- изменение данных граждан
go
create procedure [UPD_DataCitizen]
@id_Citizen int,
@NameCit varchar (50),
@SurnameCit varchar (50),
@PatronymicCit varchar (50),
@Snils varchar (11),
@SeriesPassportCit int,
@NumberPassportCit int,
@DateBirthCit varchar (10)
as
Update [dbo].[DataCitizen]
set
	NameCit = @NameCit,
	SurnameCit = @SurnameCit,
	PatronymicCit = @PatronymicCit,
	Snils = @Snils,
	SeriesPassportCit = @SeriesPassportCit,
	NumberPassportCit = @NumberPassportCit, 
	DateBirthCit = @DateBirthCit
where
	id_Citizen = @id_Citizen