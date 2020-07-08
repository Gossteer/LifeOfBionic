use [Life_of_Bionic]
go
create procedure [Add_Personal]
@NamePers varchar (50),
@SurnamePers varchar (50),
@PatronymicPers varchar (50), 
@SeriesPassportPers int,
@NumberPassportPers int,
@User_Nick varchar (50),
@User_Pass varchar (20)
as
   IF (EXISTS(SELECT Personal.id_worker
FROM dbo.Personal
WHERE User_Nick = @User_Nick))
THROW 50250, 'Данный логин уже существует', 1
	else if((@NamePers not like '%[А-Я]%' or @NamePers not like '%[а-я]%') or @NamePers in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0'))
	THROW 50673,  'Пожалуйста укажите имя только русскими буквами',1 
	else if ((@SurnamePers not like '%[А-Я]%' or @SurnamePers not like '%[а-я]%') or @SurnamePers  in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0'))
	THROW 50674,  'Пожалуйста укажите SurnameCit Only in Russian letters',1 
	else if ((@PatronymicPers not like '%[А-Я]%' or @PatronymicPers not like '%[а-я]%') or @PatronymicPers  in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0'))
	THROW 50675,  'Пожалуйста укажите отчество только русскими буквами',1 
	else
OPEN SYMMETRIC KEY SSN_Key_01
   DECRYPTION BY CERTIFICATE cert1;
insert into [dbo].[Personal] 
	(NamePers,SurnamePers,PatronymicPers,SeriesPassportPers,User_Nick,NumberPassportPers,User_Pass)
values 
	(@NamePers,@SurnamePers,@PatronymicPers,@SeriesPassportPers,@User_Nick,@NumberPassportPers,EncryptByKey(Key_GUID('SSN_Key_01'),convert(varbinary (max),@User_Pass)))


