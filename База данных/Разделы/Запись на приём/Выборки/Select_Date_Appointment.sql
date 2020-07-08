use Life_of_Bionic
go

alter procedure Select_Date_Appointment
@Date date
as
Select dbo.Day_of_the_week.id_Day_of_the_week , dbo.Day_of_the_week.Record_Time
FROM  dbo.Day_of_the_week
WHERE dbo.Day_of_the_week.Record_Time not in (SELECT        dbo.Day_of_the_week.Record_Time
FROM            dbo.Day_of_the_week INNER JOIN
                         dbo.WriteAppointment ON dbo.Day_of_the_week.id_Day_of_the_week = dbo.WriteAppointment.id_Day_of_the_week
						 WHERE WriteAppointment.times = @Date and WriteAppointment_Logical_Delete = 0)
