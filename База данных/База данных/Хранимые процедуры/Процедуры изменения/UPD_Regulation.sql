use [Life_of_Bionic] -- изменение правил
go
create procedure [UPD_Regulation]
@id_Regulation int,
@TextRegulation varchar (50),
@id_SpecialityPersonal int
as
Update [dbo].[Regulation]
set
	@TextRegulation = @TextRegulation,
	@id_SpecialityPersonal = @id_SpecialityPersonal
where
	id_Regulation = @id_Regulation