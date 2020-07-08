use [Life_of_Bionic] -- изменение типа записи
go
create procedure [UPD_TypeWrite]
@id_TypeWrite int,
@Name_TypeWrite varchar (50),
@TypeWrite_Logical_Delete bit
as
if (EXISTS(Select TypeWrite.id_TypeWrite FROM TypeWrite WHERE Name_Write = @Name_TypeWrite and TypeWrite_Logical_Delete = 0))
THROW 50669, 'Данный тип записи уже создан', 1
else if (@id_TypeWrite != (Select TypeWrite.id_TypeWrite FROM TypeWrite WHERE Name_Write = @Name_TypeWrite and TypeWrite_Logical_Delete = 1))
begin
Update TypeWrite
set
TypeWrite_Logical_Delete = 0
where
Name_Write = (Select TypeWrite.id_TypeWrite FROM TypeWrite WHERE Name_Write = @Name_TypeWrite and TypeWrite_Logical_Delete = 1)
Update TypeWrite
set
TypeWrite_Logical_Delete = 1
where
Name_Write = @Name_TypeWrite
end
else
Update [dbo].[TypeWrite]
set
	Name_Write = @Name_TypeWrite
where
	id_TypeWrite = @id_TypeWrite
