use [Life_of_Bionic]  --�������� ��������
go
create procedure [del_Diagnosis]
@id_Diagnoz int
as
delete from [dbo].[Diagnosis]
where
id_Diagnoz = @id_Diagnoz