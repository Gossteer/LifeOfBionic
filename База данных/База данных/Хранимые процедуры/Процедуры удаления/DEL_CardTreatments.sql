use [Life_of_Bionic]  --�������� ����� �������
go
create procedure [del_CardTreatments]
@id_card int
as
delete from [dbo].[CardTreatments]
where
id_card = @id_card
