use [Life_of_Bionic]  --�������� �������
go
create procedure [del_Regulation]
@id_Regulation int
as
delete from [dbo].[Regulation]
where
id_Regulation = @id_Regulation