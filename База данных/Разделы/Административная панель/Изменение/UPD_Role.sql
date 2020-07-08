use [Life_of_Bionic] -- изменение роли
go
create procedure [UPD_Role]
@id_Role int,
@Write bit,
@CardDesign bit,
@AcceptanceMedication bit,
@ResolutionStatement bit,
@AdmissionPatient bit,
@id_SpecialityPersonal int
as
if (@id_Role != (SELECT dbo.[Role].id_Role FROM [Role] WHERE Write = @Write and CardDesign = @CardDesign and AcceptanceMedication = @AcceptanceMedication
and ResolutionStatement = @ResolutionStatement and id_SpecialityPersonal = @id_SpecialityPersonal and Role_Logical_Delete = 0))
THROW 50664, 'ƒанна€ роль уже существует', 1
else if (@id_Role != (SELECT dbo.[Role].id_Role FROM [Role] WHERE Write = @Write and CardDesign = @CardDesign and AcceptanceMedication = @AcceptanceMedication
and ResolutionStatement = @ResolutionStatement and id_SpecialityPersonal = @id_SpecialityPersonal and Role_Logical_Delete = 1))
begin
UPDATE [Role]
set
Role_Logical_Delete = 0
where 
id_Role = (SELECT dbo.[Role].id_Role FROM [Role] WHERE Write = @Write and CardDesign = @CardDesign and AcceptanceMedication = @AcceptanceMedication
and ResolutionStatement = @ResolutionStatement and id_SpecialityPersonal = @id_SpecialityPersonal and Role_Logical_Delete = 1)
UPDATE [Role]
set
Role_Logical_Delete = 1
where 
id_Role = @id_Role
end
else
Update [dbo].[Role]
set
	Write = @Write,
	CardDesign = @CardDesign,
	AcceptanceMedication = @AcceptanceMedication,
	ResolutionStatement = @ResolutionStatement,
	id_SpecialityPersonal = @id_SpecialityPersonal,
	AdmissionPatient = @AdmissionPatient
where
	id_Role = @id_Role