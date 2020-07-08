use [Life_of_Bionic] -- изменение персонала
go
create procedure [UPD_Personal_For_Admin]
@id_worker int,
@NamePers varchar (50),
@SurnamePers varchar (50),
@PatronymicPers varchar (50), 
@SeriesPassportPers int,
@NumberPassportPers int,
@User_Nick varchar (50),
@ID_Role int, 
@id_WorkSchedule int
as
IF (@id_worker != (SELECT Personal.id_worker FROM Personal
WHERE  (SeriesPassportPers = @SeriesPassportPers and NumberPassportPers = @NumberPassportPers)
or User_Nick = User_Nick and Personal_Logical_Delete = 0))
THROW 50667, 'Данный пользователь уже существует',1
else IF (@id_worker != (SELECT Personal.id_worker FROM Personal
WHERE  (SeriesPassportPers = @SeriesPassportPers and NumberPassportPers = @NumberPassportPers)
or User_Nick = User_Nick and Personal_Logical_Delete = 1))
begin
Update [dbo].[Personal]
set
	NamePers = @NamePers,
	SurnamePers = @SurnamePers,
	PatronymicPers = @PatronymicPers,
	 Personal_Logical_Delete = 0,
	 	id_role = @id_Role,
	id_WorkSchedule = @id_WorkSchedule
where
	id_worker = (SELECT Personal.id_worker FROM Personal
WHERE  (SeriesPassportPers = @SeriesPassportPers and NumberPassportPers = @NumberPassportPers)
or User_Nick = User_Nick and Personal_Logical_Delete = 1)
	Update [dbo].[Personal]
set
Personal_Logical_Delete = 1
where
	id_worker = @id_worker
end
else 
Update [dbo].[Personal]
set
	NamePers = @NamePers,
	SurnamePers = @SurnamePers,
	PatronymicPers = @PatronymicPers,
	SeriesPassportPers = @SeriesPassportPers,
	NumberPassportPers = @NumberPassportPers,
	User_Nick = @User_Nick,
	id_role = @id_Role,
	id_WorkSchedule = @id_WorkSchedule
where
	id_worker = @id_worker