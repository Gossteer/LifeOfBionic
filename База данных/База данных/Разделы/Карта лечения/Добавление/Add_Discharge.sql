USE [Life_of_Bionic]
GO
/****** Object:  StoredProcedure [dbo].[Add_Discharge]    Script Date: 29.05.2019 10:01:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Add_Discharge]
@DateDischarge varchar (10),
@id_card int,
@id_TypeDischarge int
as
DECLARE @ID_WriteAppointment int
SET @ID_WriteAppointment = (SELECT CardTreatments.id_WriteAppointment FROM CardTreatments WHERE CardTreatments.id_card = @id_card and CardTreatments.CardTreatments_Logical_Delete = 0)
if (@id_TypeDischarge = (SELECT TypeDischarge.id_TypeDischarge FROM TypeDischarge WHERE TypeDischarge.NameDischarge = 'Полная медицинская выписка') 
and EXISTS(SELECT dbo.Discharge.id_Discharge FROM Discharge JOIN TypeDischarge ON Discharge.id_Discharge = TypeDischarge.id_TypeDischarge WHERE 
TypeDischarge.id_TypeDischarge = @id_TypeDischarge and Discharge.id_card = @id_card and Discharge.Discharge_Logical_Delete = 1))
UPDATE Discharge
set
Discharge_Logical_Delete = 0
else if ('Полная медицинская выписка' IN (SELECT   TypeDischarge.NameDischarge
FROM            dbo.CardTreatments INNER JOIN
                         dbo.Discharge ON dbo.CardTreatments.id_card = dbo.Discharge.id_card INNER JOIN
                         dbo.TypeDischarge ON dbo.Discharge.id_TypeDischarge = dbo.TypeDischarge.id_TypeDischarge INNER JOIN
                         dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment
WHERE WriteAppointment.id_WriteAppointment = 1 and CardTreatments.CardTreatments_Logical_Delete = 0))
THROW 50253, 'Данный пациент уже выписан',1
else
insert into [dbo].[Discharge] (DateDischarge,id_card,id_TypeDischarge)
values (@DateDischarge,@id_card,@id_TypeDischarge)

