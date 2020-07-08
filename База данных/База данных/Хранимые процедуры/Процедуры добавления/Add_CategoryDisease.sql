use [Life_of_Bionic]  --Добавление категории болезни
go
create procedure [Add_CategoriesDisease]
@Name_CategoriesDisease varchar (50),
@CategoriesDisease_Logical_Delete bit
as
insert into [dbo].[CategoriesDisease] (Name_CategoriesDisease,CategoriesDisease_Logical_Delete)
values (@Name_CategoriesDisease,@CategoriesDisease_Logical_Delete)