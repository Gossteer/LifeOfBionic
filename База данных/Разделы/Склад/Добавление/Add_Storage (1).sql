use [Life_of_Bionic]  --���������� ������
go
create procedure [Add_Storage]
@Amount int
as
insert into [dbo].[Storage] (Amount)
values (@Amount)