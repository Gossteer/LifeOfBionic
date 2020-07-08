use [Life_of_Bionic] -- изменение выписки
go
create procedure [UPD_Discharge]
@id_Discharge int,
@DateDischarge varchar (10),
@id_card int,
@id_TypeDischarge int
as
Update [dbo].[Discharge]
set
	DateDischarge = @DateDischarge,
	id_card = @id_card,
	id_TypeDischarge = @id_TypeDischarge
where
	id_Discharge = @id_Discharge