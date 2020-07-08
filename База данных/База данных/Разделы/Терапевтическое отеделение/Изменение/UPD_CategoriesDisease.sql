use [Life_of_Bionic] -- изменение категории болезни
go
create procedure [UPD_CategoriesDisease]
@id_CategoriesDisease int,
@Name_CategoriesDisease varchar (50)
as
DECLARE @Answer int
SET @Answer = (Select dbo.Answer_UPD_Unique(@id_CategoriesDisease,@Name_CategoriesDisease))
if ( @Answer =  0)
THROW 50662, 'Данная категория уже существует', 1
else if (@Answer = 1)
begin
Update [dbo].[CategoriesDisease]
set
	CategoriesDisease_Logical_Delete = 0
where
ID_CategoriesDisease = (SELECT CategoriesDisease.id_CategoriesDisease FROM CategoriesDisease WHERE CategoriesDisease.Name_CategoriesDisease = @Name_CategoriesDisease and CategoriesDisease_Logical_Delete = 1)
Update [dbo].[CategoriesDisease]
set
	CategoriesDisease_Logical_Delete = 1
where
ID_CategoriesDisease = @ID_CategoriesDisease
end
else
Update [dbo].[CategoriesDisease]
set
	Name_CategoriesDisease = @Name_CategoriesDisease
where
ID_CategoriesDisease = @ID_CategoriesDisease
