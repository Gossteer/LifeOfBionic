use [Life_of_Bionic]  --Добавление категории болезни
go
create procedure [Add_CategoriesDisease]
@Name_CategoriesDisease varchar (50)
as
if (EXISTS(SELECT CategoriesDisease.id_CategoriesDisease FROM CategoriesDisease WHERE Name_CategoriesDisease = @Name_CategoriesDisease and CategoriesDisease_Logical_Delete = 0))
THROW 50662, 'Данная категория уже существует', 1
else if (EXISTS(SELECT CategoriesDisease.id_CategoriesDisease FROM CategoriesDisease WHERE Name_CategoriesDisease = @Name_CategoriesDisease and CategoriesDisease_Logical_Delete = 1))
UPDATE CategoriesDisease
set
	CategoriesDisease_Logical_Delete = 0
where
CategoriesDisease.Name_CategoriesDisease = @Name_CategoriesDisease
else
insert into [dbo].[CategoriesDisease] (Name_CategoriesDisease)
values (@Name_CategoriesDisease)