use [Life_of_Bionic]  --�������� ������ �������
go
create procedure [del_DataCitizen]
@id_Citizen int
as
delete from [dbo].[DataCitizen]
where
id_Citizen = @id_Citizen
