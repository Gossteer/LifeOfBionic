use [Life_of_Bionic]  --Добавление производителя
go 
create procedure [Add_Manufacturer]
@Name_Manufacturer varchar (100),
@Adress varchar (100),
@Mail varchar (50)
as
if (EXISTS(Select Manufacturer.id_Manufacturer FROM Manufacturer WHERE Name_Manufacturer = @Name_Manufacturer and Adress = @Adress and Mail = @Mail
 and Manufacturer_Logical_Delete = 0 ))
THROW 50259, 'Данный производитель уже существует',1
else if (EXISTS(Select Manufacturer.id_Manufacturer FROM Manufacturer WHERE Name_Manufacturer = @Name_Manufacturer and Adress = @Adress and Mail = @Mail
 and Manufacturer_Logical_Delete = 1 ))
Update [dbo].[Manufacturer]
set
	Manufacturer_Logical_Delete = 0
where
	id_Manufacturer = (Select Manufacturer.id_Manufacturer FROM Manufacturer WHERE Name_Manufacturer = @Name_Manufacturer and Adress = @Adress and Mail = @Mail
 and Manufacturer_Logical_Delete = 1 )
 else
insert into [dbo].[Manufacturer] (Name_Manufacturer,Adress,Mail)
values (@Name_Manufacturer,@Adress,@Mail)