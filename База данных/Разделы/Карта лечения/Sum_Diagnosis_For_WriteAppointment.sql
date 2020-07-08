
create procedure Sum_Diagnosis_For_WriteAppointment
@id_WriteAppointment int
as
SELECT Diagnosis.id_Diagnoz, SUM(Diagnosis.Amount)
FROM     dbo.CardTreatments INNER JOIN
                  dbo.Diagnosis ON dbo.CardTreatments.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                  dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment
				  WHERE WriteAppointment.id_WriteAppointment = @id_WriteAppointment and CardTreatments.CardTreatments_Logical_Delete = 0
				  GROUP BY Diagnosis.id_Diagnoz