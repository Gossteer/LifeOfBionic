use [Life_of_Bionic]  --Добавление роли
go
create procedure [Add_Role]
@Write bit,
@CardDesign bit,
@AcceptanceMedication bit,
@ResolutionStatement bit,
@AdmissionPatient bit,
@id_SpecialityPersonal int
as
if (Exists(SELECT dbo.[Role].id_Role FROM [Role] WHERE Write = @Write and CardDesign = @CardDesign and AcceptanceMedication = @AcceptanceMedication
and ResolutionStatement = @ResolutionStatement and id_SpecialityPersonal = @id_SpecialityPersonal and Role_Logical_Delete = 0))
THROW 50664, 'Данная роль уже существует', 1
else if (Exists(SELECT dbo.[Role].id_Role FROM [Role] WHERE Write = @Write and CardDesign = @CardDesign and AcceptanceMedication = @AcceptanceMedication
and ResolutionStatement = @ResolutionStatement and id_SpecialityPersonal = @id_SpecialityPersonal and Role_Logical_Delete = 1))
UPDATE [Role]
set
Role_Logical_Delete = 0
where 
id_Role = (SELECT dbo.[Role].id_Role FROM [Role] WHERE Write = @Write and CardDesign = @CardDesign and AcceptanceMedication = @AcceptanceMedication
and ResolutionStatement = @ResolutionStatement and id_SpecialityPersonal = @id_SpecialityPersonal and Role_Logical_Delete = 1)
else
insert into [dbo].[Role] (Write,CardDesign,AcceptanceMedication,ResolutionStatement,AdmissionPatient, id_SpecialityPersonal)
values (@Write,@CardDesign,@AcceptanceMedication,@ResolutionStatement, @AdmissionPatient,@id_SpecialityPersonal)