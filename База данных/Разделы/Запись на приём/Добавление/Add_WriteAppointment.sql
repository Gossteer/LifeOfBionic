use [Life_of_Bionic]  --���������� ���������
go
alter procedure [Add_WriteAppointment]
@times date,
@id_Day_of_the_week int,
@id_Citizen int,
@id_FormWrite int
as
if  (@times < cast(getDate() as date) or ( @times = cast(getDate() as date) and cast(getDate() as time) > cast((Select Record_Time
FROM dbo.Day_of_the_week WHERE id_Day_of_the_week = @id_Day_of_the_week)as time)))
THROW 50671, 'Невозможно создать запись на приём задним числом',1 
else if (EXISTS(Select WriteAppointment.id_WriteAppointment FROM WriteAppointment WHERE WriteAppointment_Logical_Delete = 0 and times = @times 
and id_Day_of_the_week = @id_Day_of_the_week and id_Citizen = @id_Citizen and id_FormWrite = @id_FormWrite))
THROW 50672, 'Данный гражданин уже записан', 1

else if (EXISTS(Select WriteAppointment.id_WriteAppointment FROM WriteAppointment WHERE WriteAppointment_Logical_Delete = 1 and times = @times 
and id_Day_of_the_week = @id_Day_of_the_week and id_Citizen = @id_Citizen and id_FormWrite = @id_FormWrite))
Update [dbo].[WriteAppointment]
set
WriteAppointment_Logical_Delete = 0
where
	id_WriteAppointment = (Select WriteAppointment.id_WriteAppointment FROM WriteAppointment WHERE WriteAppointment_Logical_Delete = 1 and times = @times 
and id_Day_of_the_week = @id_Day_of_the_week and id_Citizen = @id_Citizen and id_FormWrite = @id_FormWrite)
else
insert into [dbo].[WriteAppointment] (times,id_Citizen,id_FormWrite, id_Day_of_the_week)
values (@times,@id_Citizen,@id_FormWrite, @id_Day_of_the_week)
