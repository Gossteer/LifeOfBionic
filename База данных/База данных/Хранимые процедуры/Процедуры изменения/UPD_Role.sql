use [Life_of_Bionic] -- изменение роли
go
create procedure [UPD_Role]
@id_Role int,
@Write bit,
@CardDesign bit,
@AcceptanceMedication bit,
@ResolutionStatement bit,
@id_SpecialityPersonal int
as
Update [dbo].[Role]
set
	Write = @Write,
	CardDesign = @CardDesign,
	AcceptanceMedication = @AcceptanceMedication,
	ResolutionStatement = @ResolutionStatement,
	id_SpecialityPersonal = @id_SpecialityPersonal
where
	id_Role = @id_Role