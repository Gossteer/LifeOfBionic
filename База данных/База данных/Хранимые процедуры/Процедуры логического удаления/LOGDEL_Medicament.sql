use [Life_of_Bionic]  -- ���������� �������� ���������
go
create procedure [logdel_Medicament]
@id_Medicament int
as
Update [dbo].[Medicament]
set
	Medicament_Logical_Delete = 1
where
id_Medicament = @id_Medicament
