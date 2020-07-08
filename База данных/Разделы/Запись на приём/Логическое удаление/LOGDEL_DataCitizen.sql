use [Life_of_Bionic]  -- логическое удаление данных граждан
go
create procedure [logdel_DataCitizen]
@id_Citizen int
as
Update [dbo].[DataCitizen]
set
	DataCitizen_Logical_Delete = 1
where
id_Citizen = @id_Citizen
Update [dbo].[WriteAppointment]
set
	WriteAppointment_Logical_Delete = 1
where
id_Citizen = @id_Citizen
if (EXISTS(SELECT        id_WriteAppointment
FROM            dbo.DataCitizen INNER JOIN
                         dbo.WriteAppointment ON dbo.DataCitizen.id_Citizen = dbo.WriteAppointment.id_Citizen
						 where DataCitizen.id_Citizen = @id_Citizen and WriteAppointment.visit = 1 and WriteAppointment.SentToTreatment = 1 and WriteAppointment_Logical_Delete = 0))
begin
Update [dbo].[CardTreatments]
set
	CardTreatments_Logical_Delete = 1
where
id_WriteAppointment in (SELECT        id_WriteAppointment
FROM            dbo.DataCitizen INNER JOIN
                         dbo.WriteAppointment ON dbo.DataCitizen.id_Citizen = dbo.WriteAppointment.id_Citizen
						 where DataCitizen.id_Citizen = @id_Citizen and WriteAppointment_Logical_Delete = 0)
UPDATE Discharge
set
	Discharge_Logical_Delete = 1
where Discharge.id_WriteAppointment IN (SELECT     Discharge.id_Discharge   
FROM            dbo.DataCitizen INNER JOIN
                         dbo.WriteAppointment ON dbo.DataCitizen.id_Citizen = dbo.WriteAppointment.id_Citizen INNER JOIN
                         dbo.Discharge ON dbo.WriteAppointment.id_WriteAppointment = dbo.Discharge.id_WriteAppointment
						 where WriteAppointment_Logical_Delete = 0 and DataCitizen.id_Citizen = @id_Citizen
						 )
end
