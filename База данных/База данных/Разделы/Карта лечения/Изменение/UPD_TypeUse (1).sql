use [Life_of_Bionic] -- ��������� ���� ������������
go
alter procedure [UPD_TypeUse]
@id_TypeUse int,
@NameUse varchar (50),
@TypeUse_Logical_Delete bit
as
if (@id_TypeUse != (Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse and TypeUse.TypeUse_Logical_Delete = 0))
THROW 50252, '������ ��� ����� ������������ ��� ����������',1
else if (@id_TypeUse != (Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse and TypeUse.TypeUse_Logical_Delete = 1))
begin
Update [dbo].[TypeUse]
set
	TypeUse_Logical_Delete = 0
where
	id_TypeUse = (Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse and TypeUse.TypeUse_Logical_Delete = 1)
	Update [dbo].[TypeUse]
set
	TypeUse_Logical_Delete = 1
where
	id_TypeUse = @id_TypeUse
	end
	else
Update [dbo].[TypeUse]
set
	Name_Use = @NameUse,
	TypeUse_Logical_Delete = @TypeUse_Logical_Delete
where
	id_TypeUse = @id_TypeUse