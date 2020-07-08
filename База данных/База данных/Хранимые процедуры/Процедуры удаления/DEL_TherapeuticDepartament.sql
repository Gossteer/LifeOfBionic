use [Life_of_Bionic]  --удаление терапевтического отделения
go
create procedure [del_TherapeuticDepartament]
@id_Room int
as
delete from [dbo].[TherapeuticDepartament]
where
id_Room = @id_Room