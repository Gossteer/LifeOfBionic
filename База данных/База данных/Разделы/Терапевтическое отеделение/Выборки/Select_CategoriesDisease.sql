use Life_of_Bionic
go

create procedure Select_CategoriesDisease
as
SELECT CategoriesDisease.id_CategoriesDisease,  Name_CategoriesDisease
FROM            dbo.CategoriesDisease
WHERE CategoriesDisease.CategoriesDisease_Logical_Delete = 0