use [Life_of_Bionic]  -- ���������� �������� ������
go
alter procedure [logdel_Storage]
@id_Spot_OLD int,
@id_Spot_New int
as
if (EXISTS(Select DeliveryMedicament.id_DeliveryMedicament From DeliveryMedicament WHERE DeliveryMedicament.id_spot = @id_Spot_New and DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0))
THROW 50564, '������ ����� ������ ��� ������������', 1
Update [dbo].[Storage]
set
	Storage_Logical_Delete = 1
where
id_Spot = @id_Spot_OLD

Update [dbo].[DeliveryMedicament]
set
	id_spot = @id_Spot_New
where
id_Spot = @id_Spot_OLD
