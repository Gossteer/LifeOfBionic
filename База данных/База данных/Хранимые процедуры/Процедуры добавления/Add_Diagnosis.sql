use [Life_of_Bionic]  --Добавление нового диагноза
go
create procedure [Add_Diagnosis]
@TimeDisease int,
@Amount int,
@ID_Room int,
@id_TypeUse int,
@id_Medicament int,
@id_Disease int,
@Diagnosis_Logical_Delete bit
as
insert into [dbo].[Diagnosis] (TimeDisease,Amount,ID_Room,id_TypeUse,id_Medicament,id_Disease,Diagnosis_Logical_Delete)
values (@TimeDisease,@Amount,@ID_Room,@id_TypeUse,@id_Medicament,@id_Disease,@Diagnosis_Logical_Delete)