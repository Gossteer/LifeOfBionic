use [Life_of_Bionic] -- изменение персонала
go
alter procedure [UPD_Personal]
@SeriesPassportPers int,
@NumberPassportPers int,
@User_Pass varchar (18),
@New_User_Pass varchar (18)
as
OPEN SYMMETRIC KEY SSN_Key_01
   DECRYPTION BY CERTIFICATE cert1;
   if ( (convert(char,DecryptByKey((Select Personal.User_Pass 
   FROM Personal WHERE Personal.SeriesPassportPers = @SeriesPassportPers and Personal.NumberPassportPers = @NumberPassportPers and Personal_Logical_Delete = 0)))) != @User_Pass)
   THROW 50562, '—тарый пароль не верный', 1
   else
Update [dbo].[Personal]
set
	User_Pass = EncryptByKey(Key_GUID('SSN_Key_01'),convert(varbinary (max),@New_User_Pass))
where
	id_worker = (SELECT Personal.id_worker FROM Personal WHERE Personal.SeriesPassportPers = @SeriesPassportPers and Personal.NumberPassportPers = @NumberPassportPers and Personal_Logical_Delete = 0)