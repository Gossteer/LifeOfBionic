use [Life_of_Bionic]  --�������� ����� ������
go
create procedure [del_FormWrite]
@id_FormWrite int
as
delete from [dbo].[FormWrite]
where
id_FormWrite = @id_FormWrite