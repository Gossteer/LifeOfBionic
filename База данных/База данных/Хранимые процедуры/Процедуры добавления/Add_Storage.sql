use [Life_of_Bionic]  --Добавление склада
go
create procedure [Add_Storage]
@Amount int,
@occupiedSpace int,
@Storage_Logical_Delete bit
as
insert into [dbo].[Storage] (Amount,occupiedSpace,Storage_Logical_Delete)
values (@Amount,@occupiedSpace,@Storage_Logical_Delete)