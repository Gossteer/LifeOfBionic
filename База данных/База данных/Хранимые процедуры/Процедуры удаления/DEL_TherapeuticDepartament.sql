use [Life_of_Bionic]  --�������� ���������������� ���������
go
create procedure [del_TherapeuticDepartament]
@id_Room int
as
delete from [dbo].[TherapeuticDepartament]
where
id_Room = @id_Room