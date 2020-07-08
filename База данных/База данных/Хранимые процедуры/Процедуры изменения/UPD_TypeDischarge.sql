use [Life_of_Bionic] -- изменение типа выписки
go
create procedure [UPD_TypeDischarge]
@id_TypeDischarge int,
@NameDischarge varchar (50)
as
Update [dbo].[TypeDischarge]
set
	NameDischarge = @NameDischarge
where
	id_TypeDischarge = @id_TypeDischarge