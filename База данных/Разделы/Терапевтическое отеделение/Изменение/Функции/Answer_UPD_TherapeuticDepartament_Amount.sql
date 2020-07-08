create FUNCTION Answer_UPD_TherapeuticDepartament_Amount(@id_Room int, @amountRooms int)
RETURNS bit
AS
BEGIN
IF (@amountRooms < (Select TherapeuticDepartament.BusyRoom FROM TherapeuticDepartament Where id_Room = @id_Room))
Return (0)
Return (1)
END