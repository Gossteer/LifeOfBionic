use [Life_of_Bionic] -- ��������� ���������
go
create procedure [UPD_Personal]
@id_worker int,
@NamePers varchar (50),
@SurnamePers varchar (50),
@PatronymicPers varchar (50), 
@SeriesPassportPers int,
@NumberPassportPers int,
@User_Nick varchar (50),
@User_Pass varchar (18),
@ID_Role int, 
@id_WorkSchedule int
as
OPEN SYMMETRIC KEY SSN_Key_01
   DECRYPTION BY CERTIFICATE cert1;
   if ((EncryptByKey(Key_GUID('SSN_Key_01'),convert(varbinary (max),(Select Personal.User_Pass FROM Personal Where Personal.User_Nick = @User_Nick)))) != @User_Pass)
   THROW 50562, '������ ������ �� ������', 1

Update [dbo].[Personal]
set
	NamePers = @NamePers,
	SurnamePers = @SurnamePers,
	PatronymicPers = @PatronymicPers,
	SeriesPassportPers = @SeriesPassportPers,
	NumberPassportPers = @NumberPassportPers,
	User_Nick = @User_Nick,
	User_Pass = EncryptByKey(Key_GUID('SSN_Key_01'),convert(varbinary (max),@User_Pass)),
	id_role = @id_Role,
	id_WorkSchedule = @id_WorkSchedule
where
	id_worker = @id_worker