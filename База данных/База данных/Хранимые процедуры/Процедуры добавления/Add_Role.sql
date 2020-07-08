use [Life_of_Bionic]  --Добавление роли
go
create procedure [Add_Role]
@Write bit,
@CardDesign bit,
@AcceptanceMedication bit,
@ResolutionStatement bit,
@id_SpecialityPersonal int,
@Role_Logical_Delete bit
as
insert into [dbo].[Role] (Write,CardDesign,AcceptanceMedication,ResolutionStatement,id_SpecialityPersonal,Role_Logical_Delete)
values (@Write,@CardDesign,@AcceptanceMedication,@ResolutionStatement,@id_SpecialityPersonal,@Role_Logical_Delete)