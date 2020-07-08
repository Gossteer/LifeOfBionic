use [Life_of_Bionic]  --Добавление типп употребления
go 
create procedure [Add_TypeUse]
@NameUse varchar (50)
as
DECLARE @id_TypeUse int
if (EXISTS(Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse and TypeUse.TypeUse_Logical_Delete = 1))
begin
set @id_TypeUse = (Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse) 
UPDATE TypeUse
SET
TypeUse_Logical_Delete = 0
where
id_TypeUse = id_TypeUse
end
else if (EXISTS(Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse and TypeUse.TypeUse_Logical_Delete = 0))
THROW 50252, 'Данный тип приёма медикаментов уже существует',1
else
insert into [dbo].[TypeUse] (Name_Use)
values (@NameUse)