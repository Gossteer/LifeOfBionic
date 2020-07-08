use [Life_of_Bionic]  -- логическое удалениe выписки
go
create procedure [logdel_Discharge]
@id_Discharge int
as
Update [dbo].[Discharge]
set
	Discharge_Logical_Delete = 1
where
id_Discharge = @id_Discharge
