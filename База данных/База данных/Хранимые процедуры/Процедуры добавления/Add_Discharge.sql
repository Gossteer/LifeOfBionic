use [Life_of_Bionic]  --Добавление новой выписки
go
create procedure [Add_Discharge]
@DateDischarge varchar (10),
@id_card int,
@id_TypeDischarge int,
@Discharge_Logical_Delete bit
as
insert into [dbo].[Discharge] (DateDischarge,id_card,id_TypeDischarge,Discharge_Logical_Delete)
values (@DateDischarge,@id_card,@id_TypeDischarge,@Discharge_Logical_Delete)