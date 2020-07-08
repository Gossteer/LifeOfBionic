use [Life_of_Bionic]  -- логическое удаление терапевтического отделения
go
create procedure [logdel_TherapeuticDepartament]
@id_Room int
as
Update [dbo].[TherapeuticDepartament]
set
	TherapeuticDepartament_Logical_Delete = 1
where
id_Room = @id_Room

Update [dbo].[Diagnosis]
set
	Diagnosis_Logical_Delete = 1
where
id_Room = @id_Room