use [Life_of_Bionic]  --�������� �������
go
create procedure [del_Discharge]
@id_Discharge int
as
delete from [dbo].[Discharge]
where
id_Discharge = @id_Discharge