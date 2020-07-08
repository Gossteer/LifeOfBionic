use [Life_of_Bionic]  --Добавление правила
go
create procedure [Add_Regulation]
@TextRegulation varchar (50),
@id_SpecialityPersonal int,
@Regulation_Logical_Delete bit
as
insert into [dbo].[Regulation] (TextRegulation,id_SpecialityPersonal,Regulation_Logical_Delete)
values (@TextRegulation,@id_SpecialityPersonal,@Regulation_Logical_Delete)