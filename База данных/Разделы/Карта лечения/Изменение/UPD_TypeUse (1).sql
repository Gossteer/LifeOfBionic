use [Life_of_Bionic] -- изменение типа употребления
go
alter procedure [UPD_TypeUse]
@id_TypeUse int,
@NameUse varchar (50)
as
if (@id_TypeUse != (Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse and TypeUse.TypeUse_Logical_Delete = 0))
THROW 50252, 'Данный тип приёма медикаментов уже существует',1
else if (@id_TypeUse != (Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse and TypeUse.TypeUse_Logical_Delete = 1))
begin
Update [dbo].[TypeUse]
set
	TypeUse_Logical_Delete = 0
where
	id_TypeUse = (Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse and TypeUse.TypeUse_Logical_Delete = 1)
	Update [dbo].[TypeUse]
set
	TypeUse_Logical_Delete = 1
where
	id_TypeUse = @id_TypeUse
	end
	else
Update [dbo].[TypeUse]
set
	Name_Use = @NameUse
where
	id_TypeUse = @id_TypeUse