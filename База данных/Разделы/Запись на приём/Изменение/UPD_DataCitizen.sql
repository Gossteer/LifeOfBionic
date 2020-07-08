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
@DateBirthCit date
as
if ((SELECT 
CASE 
WHEN MONTH(CONVERT(date,@DateBirthCit)) > MONTH(getDate()) THEN DATEDIFF(YEAR,CONVERT(date,@DateBirthCit),getDate())-1 
WHEN MONTH(CONVERT(date,@DateBirthCit)) < MONTH(getDate()) THEN DATEDIFF(YEAR,CONVERT(date,@DateBirthCit),getDate()) 
WHEN MONTH(CONVERT(date,@DateBirthCit)) = MONTH(getDate()) THEN 
CASE 
WHEN DAY(CONVERT(date,@DateBirthCit)) > DAY(getDate()) THEN DATEDIFF(YEAR,CONVERT(date,@DateBirthCit),getDate())-1 
ELSE DATEDIFF(YEAR,CONVERT(date,@DateBirthCit),getDate()) 
END 
END) < 18 )
THROW 50288, 'Возраст добавляемого гражданина меньше 18 лет!', 1
else if (@id_Citizen != (SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.Snils = @Snils and DataCitizen_Logical_Delete = 0) 
and EXISTS(SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.NumberPassportCit = @NumberPassportCit 
AND DataCitizen.SeriesPassportCit = @SeriesPassportCit and DataCitizen_Logical_Delete = 0))
THROW 50668,  'Данный гражданин уже зарегистрирован',1 
ELSE if (@id_Citizen != (SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.Snils = @Snils and DataCitizen_Logical_Delete = 1) 
and EXISTS(SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.NumberPassportCit = @NumberPassportCit 
AND DataCitizen.SeriesPassportCit = @SeriesPassportCit and DataCitizen_Logical_Delete = 1))
begin
UPDATE DataCitizen
set
DataCitizen_Logical_Delete = 0,
NameCit = @NameCit ,
SurnameCit = @SurnameCit ,
PatronymicCit = @PatronymicCit,
DateBirthCit = @DateBirthCit
where 
id_Citizen = (SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.Snils = @Snils and DataCitizen_Logical_Delete = 1) 
and EXISTS(SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.NumberPassportCit = @NumberPassportCit 
AND DataCitizen.SeriesPassportCit = @SeriesPassportCit and DataCitizen_Logical_Delete = 1)
UPDATE DataCitizen
set
DataCitizen_Logical_Delete = 1
where 
id_Citizen = @id_Citizen
end
else
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