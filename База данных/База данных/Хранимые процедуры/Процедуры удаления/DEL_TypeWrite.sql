use [Life_of_Bionic]  --�������� ���� ������
go
create procedure [del_TypeWrite]
@id_TypeWrite int
as
delete from [dbo].[TypeWrite]
where
id_TypeWrite = @id_TypeWrite