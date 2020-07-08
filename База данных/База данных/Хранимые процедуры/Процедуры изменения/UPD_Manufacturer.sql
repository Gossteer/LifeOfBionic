use [Life_of_Bionic] -- изменение производителя
go
create procedure [UPD_Manufacturer]
@id_Manufacturer int,
@N_Manufacturer varchar (100),
@Adress varchar (100),
@Mail varchar (50)
as
Update [dbo].[Manufacturer]
set
	Name_Manufacturer = @N_Manufacturer,
	Adress = @Adress,
	mail = @mail
where
	id_Manufacturer = @id_Manufacturer