USE [Life_of_Bionic]
GO
/****** Object:  Trigger [dbo].[InsertOnPalateNewCitizen]    Script Date: 03.06.2019 21:48:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[InsertOnPalateNewCitizen] ON [dbo].[CardTreatments] 
AFTER INSERT
as 
if ((Select TherapeuticDepartament.BusyRoom FROM inserted INNER JOIN
                         dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room
						 where Diagnosis.id_Diagnoz = inserted.id_Diagnoz) + 1 > ((Select TherapeuticDepartament.amountRooms FROM inserted INNER JOIN
                         dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room
						 where Diagnosis.id_Diagnoz = inserted.id_Diagnoz)))
						 THROW 50679, 'Палата переполненна',1 		 
						 else if ((sELECT Diagnosis.Amount FROM inserted INNER JOIN
                         dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz WHERE Diagnosis.id_Diagnoz = inserted.id_Diagnoz) > (SELECT     DISTINCT   dbo.Storage.occupiedSpace
FROM            inserted INNER JOIN
                         dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.DeliveryMedicament ON dbo.Medicament.id_Medicament = dbo.DeliveryMedicament.id_Medicament INNER JOIN
                         dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
						 where DiagnosiS.id_Diagnoz = inserted.id_Diagnoz and DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0 and Storage_Logical_Delete = 0)  
						 )
						 THROW 50680, 'На складе недостаточно лекарств',1
						 else
update dbo.Storage
set 
occupiedSpace -= (sELECT Diagnosis.Amount FROM        inserted INNER JOIN
                         dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz WHERE Diagnosis.id_Diagnoz = inserted.id_Diagnoz)
where
id_spot = (SELECT     DISTINCT   dbo.Storage.id_spot
FROM            inserted INNER JOIN
                         dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.DeliveryMedicament ON dbo.Medicament.id_Medicament = dbo.DeliveryMedicament.id_Medicament INNER JOIN
                         dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
						 where DiagnosiS.id_Diagnoz = inserted.id_Diagnoz and DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0 and Storage_Logical_Delete = 0)
update dbo.TherapeuticDepartament 
set 
BusyRoom += 1 
where id_Room = (Select TherapeuticDepartament.id_Room FROM inserted INNER JOIN
                         dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room
						 where Diagnosis.id_Diagnoz = inserted.id_Diagnoz)


