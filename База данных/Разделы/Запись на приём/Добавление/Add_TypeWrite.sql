use [Life_of_Bionic]  --���������� ���� ������
go 
create procedure [Add_TypeWrite]
@Name_TypeWrite varchar (50)
as
if (EXISTS(Select TypeWrite.id_TypeWrite FROM TypeWrite WHERE Name_Write = @Name_TypeWrite and TypeWrite_Logical_Delete = 0))
THROW 50669, 'Данный тип записи уже создан', 1
else if (EXISTS(Select TypeWrite.id_TypeWrite FROM TypeWrite WHERE Name_Write = @Name_TypeWrite and TypeWrite_Logical_Delete = 1))
Update TypeWrite
set
TypeWrite_Logical_Delete = 0
where
Name_Write = @Name_TypeWrite
else
insert into [dbo].[TypeWrite] (Name_Write)
values (@Name_TypeWrite)