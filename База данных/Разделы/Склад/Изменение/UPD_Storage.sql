use [Life_of_Bionic] -- ��������� ������
go
alter procedure [UPD_Storage]
@id_Spot int,
@Amount int
as
if ( @Amount < (Select Storage.occupiedSpace FROM Storage WHERE Storage.Storage_Logical_Delete = 0 and Storage.id_spot = @id_Spot))
THROW 50565, '���������� ������������ ��������� ���������� ������ ������', 1 
Update [dbo].[Storage]
set
	Amount = @Amount
where
	id_Spot = @id_Spot


