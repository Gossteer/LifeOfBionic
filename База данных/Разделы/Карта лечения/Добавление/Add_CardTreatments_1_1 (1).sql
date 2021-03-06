USE [Life_of_Bionic]
GO
/****** Object:  StoredProcedure [dbo].[Add_CardTreatments]    Script Date: 28.05.2019 10:29:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Add_CardTreatments]
@id_WriteAppointment int,
@id_Diagnoz int,
@Name_SpecialityPersonal varchar(50)
as
DECLARE @id_CardTreatments int
DECLARE @id_WriteAppointment_Old int

if (@Name_SpecialityPersonal != (SELECT        dbo.SpecialityPersonal.Name_SpecialityPersonal
FROM            dbo.Role INNER JOIN
                         dbo.Personal ON dbo.Role.id_Role = dbo.Personal.id_Role INNER JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal INNER JOIN
                         dbo.TherapeuticDepartament ON dbo.Personal.id_worker = dbo.TherapeuticDepartament.id_worker INNER JOIN
                         dbo.Diagnosis ON dbo.TherapeuticDepartament.id_Room = dbo.Diagnosis.ID_Room
						 where Diagnosis.id_Diagnoz = @id_Diagnoz) and @Name_SpecialityPersonal != 'Главный врач')
						 THROW 50660, 'Данный диагноз находится вне вашей компитенции или на отделение не назначен заведующий', 1
else if (EXISTS(Select CardTreatments.id_card FROM CardTreatments WHERE CardTreatments.id_Diagnoz = @id_Diagnoz and 
CardTreatments.id_WriteAppointment = @id_WriteAppointment and CardTreatments.Cured = 0 and CardTreatments_Logical_Delete = 0))
THROW 50256, 'Данные диагноз уже назначен и в процессе лечения',1
else if ((Select Diagnosis.ID_Room FROM Diagnosis WHERE Diagnosis.id_Diagnoz = @id_Diagnoz ) !=
(Select Diagnosis.ID_Room FROM CardTreatments JOIN dbo.Diagnosis ON dbo.CardTreatments.id_Diagnoz = dbo.Diagnosis.id_Diagnoz
WHERE CardTreatments.Cured = 0 and CardTreatments.id_WriteAppointment = @id_WriteAppointment and  CardTreatments_Logical_Delete = 0) )
THROW 50257, 'На данный момент пациент лечится в другой палате',1
else if (EXISTS(Select CardTreatments.id_card FROM CardTreatments WHERE CardTreatments.id_Diagnoz = @id_Diagnoz and 
CardTreatments.id_WriteAppointment = @id_WriteAppointment and CardTreatments.Cured = 0 and CardTreatments_Logical_Delete = 1))
begin
SET @id_CardTreatments = (Select CardTreatments.id_card FROM CardTreatments WHERE CardTreatments.id_Diagnoz = @id_Diagnoz and 
CardTreatments.id_WriteAppointment = @id_WriteAppointment  and CardTreatments.Cured = 0 and CardTreatments_Logical_Delete = 1)
Update [dbo].[CardTreatments]
set
	CardTreatments_Logical_Delete = 0
where
ID_card = @id_CardTreatments
end
else
Update [dbo].[WriteAppointment]
set
	MedicalDepartament = (Select Diagnosis.ID_Room FROM Diagnosis WHERE Diagnosis.id_Diagnoz = @id_Diagnoz),
	СategoriesDisease = (Select dbo.CategoriesDisease.Name_CategoriesDisease FROM Diagnosis JOIN TherapeuticDepartament ON Diagnosis.ID_Room = TherapeuticDepartament.id_Room
	JOIN CategoriesDisease ON TherapeuticDepartament.id_Room = CategoriesDisease.id_CategoriesDisease 
	Where Diagnosis.id_Diagnoz = @id_Diagnoz)
where
id_WriteAppointment = @id_WriteAppointment
insert into [dbo].[CardTreatments] (id_WriteAppointment,Cured,id_Diagnoz)
values (@id_WriteAppointment,0,@id_Diagnoz)



