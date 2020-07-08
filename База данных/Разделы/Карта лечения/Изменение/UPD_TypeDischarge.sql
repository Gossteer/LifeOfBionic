use [Life_of_Bionic] -- изменение типа выписки
go
alter procedure [UPD_TypeDischarge]
@id_TypeDischarge int,
@NameDischarge varchar (50),
@TypeDischarge_Logical_Delete bit
as
if (@id_TypeDischarge != (Select TypeDischarge.NameDischarge FROM TypeDischarge WHERE TypeDischarge.NameDischarge = @NameDischarge and TypeDischarge.TypeDischarge_Logical_Delete = 0))
THROW 50251, 'Данный тип выписки уже существует',1
else if (@id_TypeDischarge != (Select TypeDischarge.NameDischarge FROM TypeDischarge WHERE TypeDischarge.NameDischarge = @NameDischarge and TypeDischarge.TypeDischarge_Logical_Delete = 1))
begin
Update [dbo].[TypeDischarge]
set
	TypeDischarge_Logical_Delete = 0

where
	id_TypeDischarge = (Select TypeDischarge.NameDischarge FROM TypeDischarge WHERE TypeDischarge.NameDischarge = @NameDischarge and TypeDischarge.TypeDischarge_Logical_Delete = 1)
	Update [dbo].[TypeDischarge]
set
	TypeDischarge_Logical_Delete = 1

where
	id_TypeDischarge = @id_TypeDischarge
	end
else
Update [dbo].[TypeDischarge]
set
	NameDischarge = @NameDischarge
where
	id_TypeDischarge = @id_TypeDischarge

