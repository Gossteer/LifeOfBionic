use [Life_of_Bionic]  -- логическое удаление типа употребления
go
create procedure [logdel_TypeUse]
@id_TypeUse int
as
Update [dbo].[TypeUse]
set
	TypeUse_Logical_Delete = 1
where
id_TypeUse = @id_TypeUse
