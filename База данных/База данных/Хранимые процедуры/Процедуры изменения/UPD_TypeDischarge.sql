use [Life_of_Bionic] -- ��������� ���� �������
go
create procedure [UPD_TypeDischarge]
@id_TypeDischarge int,
@NameDischarge varchar (50)
as
Update [dbo].[TypeDischarge]
set
	NameDischarge = @NameDischarge
where
	id_TypeDischarge = @id_TypeDischarge