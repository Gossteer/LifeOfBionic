use [Life_of_Bionic]  -- ���������� �������� ��������� �������
go
create procedure [logdel_CategoriesDisease]
@id_CategoriesDisease int
as
Update [dbo].[CategoriesDisease]
set
	CategoriesDisease_Logical_Delete = 1
where
id_CategoriesDisease = @id_CategoriesDisease
