use [Life_of_Bionic]  --удаление категории болезни
go
create procedure [del_CategoriesDisease]
@id_CategoriesDisease int
as
delete from [dbo].[CategoriesDisease]
where
id_CategoriesDisease = @id_CategoriesDisease
