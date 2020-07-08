use [Life_of_Bionic] -- изменение категории болезни
go
create procedure [UPD_CategoriesDisease]
@id_CategoriesDisease int,
@Name_CategoriesDisease varchar (50)
as
Update [dbo].[CategoriesDisease]
set
	Name_CategoriesDisease = @Name_CategoriesDisease
where
ID_CategoriesDisease = @ID_CategoriesDisease