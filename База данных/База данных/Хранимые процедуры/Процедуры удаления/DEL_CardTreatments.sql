use [Life_of_Bionic]  --удаление карты лечения
go
create procedure [del_CardTreatments]
@id_card int
as
delete from [dbo].[CardTreatments]
where
id_card = @id_card
