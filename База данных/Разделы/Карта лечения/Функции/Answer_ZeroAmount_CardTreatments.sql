Create FUNCTION Answer_ZeroAmount_CardTreatments
 (@id_WriteAppointment int)
RETURNS bit
AS
 BEGIN
  DECLARE @Amswer_Amount int
  if (EXISTS(SELECT *
FROM dbo.CardTreatments INNER JOIN
dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment
WHERE WriteAppointment.id_WriteAppointment = @id_WriteAppointment  and CardTreatments.Cured  = 0 and CardTreatments.CardTreatments_Logical_Delete = 0 
and WriteAppointment.WriteAppointment_Logical_Delete = 0))
Return (1)
Return (0)
 END




