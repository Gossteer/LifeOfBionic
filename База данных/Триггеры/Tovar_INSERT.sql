Create TRIGGER Tovar_INSERT ON dbo.DeliveryMedicament 
FOR INSERT
AS 
update dbo.Storage set 
occupiedSpace += (Select inserted.amount FROM inserted)
where id_spot = (Select inserted.id_spot FROM inserted)

