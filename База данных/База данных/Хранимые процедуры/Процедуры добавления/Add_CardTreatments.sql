use [Life_of_Bionic]  --Добавление нового диагноза
go
create procedure [Add_CardTreatments]
@id_WriteAppointment int,
@id_Diagnoz int,
@Cured bit,
@MedicalDepartament int,
@CardTreatments_Logical_Delete bit
as
insert into [dbo].[CardTreatments] (id_WriteAppointment,id_Diagnoz,Cured,MedicalDepartament,CardTreatments_Logical_Delete)
values (@id_WriteAppointment,@id_Diagnoz,@Cured,@MedicalDepartament,@CardTreatments_Logical_Delete)