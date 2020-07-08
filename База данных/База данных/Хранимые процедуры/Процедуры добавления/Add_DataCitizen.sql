use [Life_of_Bionic]  --Добавление данных граждан
go 
create procedure [Add_DataCitizen]
@NameCit varchar (50),
@SurnameCit varchar (50),
@PatronymicCit varchar (50),
@Snils varchar (11),
@SeriesPassportCit int,
@NumberPassportCit int,
@DateBirthCit varchar (10),
@DataCitizen_Logical_Delete bit
as
insert into [dbo].[DataCitizen] (NameCit,SurnameCit,PatronymicCit,Snils,SeriesPassportCit,NumberPassportCit,DateBirthCit,DataCitizen_Logical_Delete)
values (@NameCit,@SurnameCit,@PatronymicCit,@Snils,@SeriesPassportCit,@NumberPassportCit,@DateBirthCit,@DataCitizen_Logical_Delete)