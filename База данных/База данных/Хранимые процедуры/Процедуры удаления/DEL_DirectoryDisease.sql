use [Life_of_Bionic]  --�������� ����������� ��������
go
create procedure [del_DirectoryDisease]
@id_Disease int
as
delete from [dbo].[DirectoryDisease]
where
id_Disease = @id_Disease