use [Life_of_Bionic]
go
create procedure [Add_Personal]
@NamePers varchar (50),
@SurnamePers varchar (50),
@PatronymicPers varchar (50), 
@SeriesPassportPers int,
@NumberPassportPers int,
@User_Nick varchar (50),
@User_Pass varchar (20),
@id_WorkSchedule int,
@id_role int,
@Personal_Logical_Delete bit
as
OPEN SYMMETRIC KEY SSN_Key_01
   DECRYPTION BY CERTIFICATE cert1;
insert into [dbo].[Personal] 
	(NamePers,SurnamePers,PatronymicPers,SeriesPassportPers,NumberPassportPers,User_Nick,User_Pass,id_WorkSchedule,id_role,Personal_Logical_Delete)
values 
	(@NamePers,@SurnamePers,@PatronymicPers,@SeriesPassportPers,@NumberPassportPers,@User_Nick,EncryptByKey(Key_GUID('SSN_Key_01'),convert(varbinary (max),@User_Pass)),@id_WorkSchedule,@id_role,@Personal_Logical_Delete)