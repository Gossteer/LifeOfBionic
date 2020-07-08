use [Life_of_Bionic] -- изменение записи на приём
go
create procedure [UPD_WriteAppointment]
@id_WriteAppointment int,
@id_Day_of_the_week int,
@visit bit,
@id_Citizen int,
@SentToTreatment bit,
@times datetime,
@id_FormWrite int
as
if  (@visit = 0)
THROW 50683, 'Невозможно положить того, кто ещё не пришёл',1 
else if (@times < getDate() and convert(varchar,getDate(),108) > (Select Record_Time
FROM dbo.Day_of_the_week WHERE id_Day_of_the_week = @id_Day_of_the_week))
THROW 50671, 'Невозможно создать запись на приём задним числом',1 
else if (@id_WriteAppointment != (Select WriteAppointment.id_WriteAppointment FROM WriteAppointment WHERE WriteAppointment_Logical_Delete = 0 and times = @times 
and id_Day_of_the_week = @id_Day_of_the_week and id_Citizen = @id_Citizen and id_FormWrite = @id_FormWrite))
THROW 50672, 'Данный гражданин уже записан', 1

else if (@id_WriteAppointment != (Select WriteAppointment.id_WriteAppointment FROM WriteAppointment WHERE WriteAppointment_Logical_Delete = 1 and times = @times 
and id_Day_of_the_week = @id_Day_of_the_week and id_Citizen = @id_Citizen and id_FormWrite = @id_FormWrite))
begin
Update [dbo].[WriteAppointment]
set
WriteAppointment_Logical_Delete = 0
where
	id_WriteAppointment = (Select WriteAppointment.id_WriteAppointment FROM WriteAppointment WHERE WriteAppointment_Logical_Delete = 1 and times = @times 
and id_Day_of_the_week = @id_Day_of_the_week and id_Citizen = @id_Citizen and id_FormWrite = @id_FormWrite)
Update [dbo].[WriteAppointment]
set
WriteAppointment_Logical_Delete = 1
where
	id_WriteAppointment = @id_WriteAppointment
end
else
Update [dbo].[WriteAppointment]
set
	id_Day_of_the_week = @id_Day_of_the_week,
	visit = @visit,
	id_Citizen = @id_Citizen,
	id_FormWrite = @id_FormWrite,
	SentToTreatment = @SentToTreatment
where
	id_WriteAppointment = @id_WriteAppointment