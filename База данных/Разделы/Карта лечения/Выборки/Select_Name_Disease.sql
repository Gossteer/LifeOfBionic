use Life_of_Bionic
go

create procedure Select_Name_Disease
as
SELECT DirectoryDisease.id_Disease, dbo.DirectoryDisease.Name_Disease
FROM  dbo.DirectoryDisease 
WHERE dbo.DirectoryDisease.DirectoryDisease_Logical_Delete = 0
