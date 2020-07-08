use [Life_of_Bionic]  --���������� ���� ������������
go 
create procedure [Add_TypeUse]
@NameUse varchar (50),
@TypeUse_Logical_Delete bit
as
DECLARE @id_TypeUse int
if (EXISTS(Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse and TypeUse.TypeUse_Logical_Delete = 1))
begin
set @id_TypeUse = (Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse) 
exec UPD_TypeUse  @id_TypeUse, @NameUse, 0
end
else if (EXISTS(Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse and TypeUse.TypeUse_Logical_Delete = 0))
THROW 50252, '������ ��� ����� ������������ ��� ����������',1
else
insert into [dbo].[TypeUse] (Name_Use,TypeUse_Logical_Delete)
values (@NameUse,@TypeUse_Logical_Delete)