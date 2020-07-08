use [Life_of_Bionic]  -- логическое удаление диагноза
go
create procedure [logdel_Diagnosis]
@id_Diagnoz int
as
Update [dbo].[Diagnosis]
set
	Diagnosis_Logical_Delete = 1
where
id_Diagnoz = @id_Diagnoz
