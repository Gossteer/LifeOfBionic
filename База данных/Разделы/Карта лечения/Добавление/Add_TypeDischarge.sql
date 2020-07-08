use [Life_of_Bionic]  --Добавление типа выписки
go
alter procedure [Add_TypeDischarge]
@NameDischarge varchar (50)
as
DECLARE @id_TypeDischarge int
if (EXISTS(Select TypeDischarge.NameDischarge FROM TypeDischarge WHERE TypeDischarge.NameDischarge = @NameDischarge and TypeDischarge.TypeDischarge_Logical_Delete = 1))
begin
set @id_TypeDischarge = (Select TypeDischarge.id_TypeDischarge FROM TypeDischarge WHERE TypeDischarge.NameDischarge = @NameDischarge) 
exec UPD_TypeDischarge @id_TypeDischarge, @NameDischarge, 0
end
else if (EXISTS(Select TypeDischarge.NameDischarge FROM TypeDischarge WHERE TypeDischarge.NameDischarge = @NameDischarge and TypeDischarge.TypeDischarge_Logical_Delete = 0))
THROW 50251, 'Данный тип выписки уже существует',1
else
insert into [dbo].[TypeDischarge] (NameDischarge)
values (@NameDischarge)
