use [Life_of_Bionic]  -- ���������� �������� �������
go
create procedure [logdel_Regulation]
@id_Regulation int
as
Update [dbo].[Regulation]
set
	Regulation_Logical_Delete = 1
where
id_Regulation = @id_Regulation
