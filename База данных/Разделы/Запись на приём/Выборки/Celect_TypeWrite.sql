use Life_of_Bionic
go

create procedure Celect_TypeWrite
as
SELECT TypeWrite.id_TypeWrite, 'Тип записи: ' + dbo.TypeWrite.Name_Write as 'Тип записи'
FROM     dbo.TypeWrite

