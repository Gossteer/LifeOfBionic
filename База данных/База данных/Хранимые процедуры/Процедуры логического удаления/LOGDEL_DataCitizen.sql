use [Life_of_Bionic]  -- логическое удаление данных граждан
go
create procedure [logdel_DataCitizen]
@id_Citizen int
as
Update [dbo].[DataCitizen]
set
	DataCitizen_Logical_Delete = 1
where
id_Citizen = @id_Citizen
