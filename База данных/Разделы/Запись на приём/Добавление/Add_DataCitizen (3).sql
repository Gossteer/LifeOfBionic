use [Life_of_Bionic]  --���������� ������ �������
go 
alter procedure [Add_DataCitizen]
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
else if (EXISTS(SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.Snils = @Snils and DataCitizen_Logical_Delete = 0))
THROW 50668,  'Гражданин с таким СНИЛС уже зарегистрирован',1 
else if (EXISTS(SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.NumberPassportCit = @NumberPassportCit 
AND DataCitizen.SeriesPassportCit = @SeriesPassportCit and DataCitizen_Logical_Delete = 0))
THROW 50668,  'Гражданин с такими паспортными данными уже зарегистрирован',1 
ELSE if (EXISTS(SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.Snils = @Snils and DataCitizen_Logical_Delete = 1) 
and EXISTS(SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.NumberPassportCit = @NumberPassportCit 
AND DataCitizen.SeriesPassportCit = @SeriesPassportCit and DataCitizen_Logical_Delete = 1))
UPDATE DataCitizen
set
DataCitizen_Logical_Delete = 0,
NameCit = @NameCit ,
SurnameCit = @SurnameCit ,
PatronymicCit = @PatronymicCit,
DateBirthCit = @DateBirthCit
where 
Snils = @Snils
else if((@NameCit not like '%[А-Я]%' or @NameCit not like '%[а-я]%') or @NameCit in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0'))
	THROW 50673,  'Пожалуйста укажите имя только русскими буквами',1 
	else if ((@SurnameCit not like '%[А-Я]%' or @SurnameCit not like '%[а-я]%') or @SurnameCit  in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0'))
	THROW 50674,  'Пожалуйста укажите SurnameCit Only in Russian letters',1 
	else if ((@PatronymicCit not like '%[А-Я]%' or @PatronymicCit not like '%[а-я]%') or @PatronymicCit  in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0'))
	THROW 50675,  'Пожалуйста укажите отчество только русскими буквами',1 
	else
insert into [dbo].[DataCitizen] (NameCit,SurnameCit,PatronymicCit,Snils,SeriesPassportCit,NumberPassportCit,DateBirthCit)
values (@NameCit,@SurnameCit,@PatronymicCit,@Snils,@SeriesPassportCit,@NumberPassportCit,@DateBirthCit)

exec 