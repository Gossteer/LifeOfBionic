use [Life_of_Bionic]  -- ���������� �������� ����� �������
go
create procedure [logdel_CardTreatments]
@id_card int
as
Update [dbo].[CardTreatments]
set
	CardTreatments_Logical_Delete = 1
where
id_card = @id_card
