Create TRIGGER Tovar_UPDATE ON dbo.DeliveryMedicament 
FOR UPDATE
AS 
update dbo.Storage set 
occupiedSpace += ((Select inserted.amount FROM inserted) - (Select deleted.amount FROM deleted))
where id_spot = (Select inserted.id_spot FROM inserted)

