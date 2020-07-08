create FUNCTION Answer_UPD_Unique(@id_CategoriesDisease int, @Name_CategoriesDisease varchar(50))
RETURNS int
AS
BEGIN
IF (EXISTS(SELECT CategoriesDisease.id_CategoriesDisease FROM CategoriesDisease WHERE CategoriesDisease.Name_CategoriesDisease = @Name_CategoriesDisease and CategoriesDisease_Logical_Delete = 0)
and @id_CategoriesDisease != (SELECT CategoriesDisease.id_CategoriesDisease FROM CategoriesDisease WHERE CategoriesDisease.Name_CategoriesDisease = @Name_CategoriesDisease and CategoriesDisease_Logical_Delete = 0))
Return (0)
else IF (EXISTS(SELECT CategoriesDisease.id_CategoriesDisease FROM CategoriesDisease WHERE CategoriesDisease.Name_CategoriesDisease = @Name_CategoriesDisease and CategoriesDisease_Logical_Delete = 1)
and @id_CategoriesDisease != (SELECT CategoriesDisease.id_CategoriesDisease FROM CategoriesDisease WHERE CategoriesDisease.Name_CategoriesDisease = @Name_CategoriesDisease and CategoriesDisease_Logical_Delete = 1))
Return (1)
Return (2)
END
