use [Life_of_Bionic]  -- ���������� �������� ���� �������
go
create procedure [logdel_TypeDischarge]
@id_TypeDischarge int
as
Update [dbo].[TypeDischarge]
set
	TypeDischarge_Logical_Delete = 1
where
id_TypeDischarge = @id_TypeDischarge
