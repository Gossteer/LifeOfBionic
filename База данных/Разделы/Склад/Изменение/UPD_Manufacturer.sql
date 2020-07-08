use [Life_of_Bionic] -- изменение производителя
go
create procedure [UPD_Manufacturer]
@id_Manufacturer int,
@Name_Manufacturer varchar (100),
@Adress varchar (100),
@Mail varchar (50)
as
IF( @id_Manufacturer != (Select Manufacturer.id_Manufacturer From Manufacturer WHERE Name_Manufacturer = @Name_Manufacturer and Adress =@Adress and Mail = @Mail and Manufacturer_Logical_Delete = 0))
THROW 50661, 'Данный производитель уже существует', 1
else if ( @id_Manufacturer != (Select Manufacturer.id_Manufacturer From Manufacturer WHERE Name_Manufacturer = @Name_Manufacturer and Adress =@Adress and Mail = @Mail and Manufacturer_Logical_Delete = 1))
begin
Update [dbo].[Manufacturer]
set
 Manufacturer_Logical_Delete = 0
where
	id_Manufacturer = (Select Manufacturer.id_Manufacturer From Manufacturer WHERE Name_Manufacturer = @Name_Manufacturer and Adress =@Adress and Mail = @Mail and Manufacturer_Logical_Delete = 1)
	Update [dbo].[Manufacturer]
set
 Manufacturer_Logical_Delete = 1
where
	id_Manufacturer = @id_Manufacturer
	end
	else
Update [dbo].[Manufacturer]
set
	Name_Manufacturer = @Name_Manufacturer,
	Adress = @Adress,
	mail = @mail
where
	id_Manufacturer = @id_Manufacturer
