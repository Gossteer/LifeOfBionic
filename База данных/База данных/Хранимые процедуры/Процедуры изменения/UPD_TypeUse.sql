use [Life_of_Bionic] -- изменение типа употребления
go
create procedure [UPD_TypeUse]
@id_TypeUse int,
@NameUse varchar (50)
as
Update [dbo].[TypeUse]
set
	Name_Use = @NameUse
where
	id_TypeUse = @id_TypeUse