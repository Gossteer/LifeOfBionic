use [Life_of_Bionic] -- ��������� ������ �� ����
go
create procedure [Search_WriteAppointment]
@Snils varchar (11)
as
DECLARE @ID_Citizen_ForWriteAppointment int

Select @ID_Citizen_ForWriteAppointment = id_Citizen
FROM [dbo].[DataCitizen]
WHERE [dbo].[DataCitizen].Snils = @Snils 

SELECT  [dbo].[DataCitizen].NameCit,  [dbo].[DataCitizen].SurnameCit,  [dbo].[DataCitizen].PatronymicCit,  [dbo].[DataCitizen].Snils,
[dbo].[WriteAppointment].times, [dbo].[WriteAppointment].visit, [dbo].[WriteAppointment].SentForTreatment
FROM [dbo].[WriteAppointment], [dbo].[DataCitizen]
WHERE [dbo].[DataCitizen].Snils = @Snils and [dbo].[WriteAppointment].id_Citizen = @ID_Citizen_ForWriteAppointment

exec Search_WriteAppointment 11122233344
