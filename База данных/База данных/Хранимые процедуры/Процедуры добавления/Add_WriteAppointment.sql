use [Life_of_Bionic]  --Добавление посещения
go
create procedure [Add_WriteAppointment]
@times datetime,
@visit bit,
@id_Citizen int,
@id_FormWrite int,
@SentToTreatment bit,
@WriteAppointment_Logical_Delete bit
as
insert into [dbo].[WriteAppointment] (times,visit,id_Citizen,id_FormWrite,SentToTreatment,WriteAppointment_Logical_Delete)
values (@times,@visit,@id_Citizen,@id_FormWrite,@SentToTreatment,@WriteAppointment_Logical_Delete)