alter TRIGGER UpdateOnPalateNewCitizen ON [dbo].[CardTreatments] 
AFTER UPDATE
as 
if ((0 in (Select deleted.Cured FROM deleted where deleted.CardTreatments_Logical_Delete = 0) and 1 in (Select inserted.Cured FROM inserted where inserted.CardTreatments_Logical_Delete = 0))
or (0 in (Select deleted.CardTreatments_Logical_Delete FROM deleted where deleted.Cured = 0) and 1 in (Select inserted.CardTreatments_Logical_Delete FROM inserted where inserted.Cured = 0)))
update dbo.TherapeuticDepartament 
set 
BusyRoom -= 1 
where id_Room in (Select TherapeuticDepartament.id_Room FROM inserted INNER JOIN
                         dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room
						 where Diagnosis.id_Diagnoz = inserted.id_Diagnoz)
						 else if ((1 in (Select deleted.CardTreatments_Logical_Delete FROM deleted where Cured = 0) and 0 in (Select inserted.CardTreatments_Logical_Delete FROM inserted where  Cured = 0)))
update dbo.TherapeuticDepartament 
set 
BusyRoom += 1 
where id_Room in (Select TherapeuticDepartament.id_Room FROM inserted INNER JOIN
                         dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room
						 where Diagnosis.id_Diagnoz = inserted.id_Diagnoz)
