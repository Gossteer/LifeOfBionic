use [Life_of_Bionic]  -- логическое удалениe производителя
go
create procedure [logdel_Manufacturer]
@id_Manufacturer int
as
Update [dbo].[Manufacturer]
set
	Manufacturer_Logical_Delete = 1
where
id_Manufacturer = @id_Manufacturer

Update [dbo].[Medicament]
set
	id_Manufacturer = null
where
id_Manufacturer = @id_Manufacturer

