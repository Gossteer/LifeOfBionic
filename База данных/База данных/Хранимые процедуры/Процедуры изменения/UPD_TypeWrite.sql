use [Life_of_Bionic] -- изменение типа записи
go
create procedure [UPD_TypeWrite]
@id_TypeWrite int,
@N_TypeWrite varchar (50)
as
Update [dbo].[TypeWrite]
set
	Name_Write = @N_TypeWrite
where
	id_TypeWrite = @id_TypeWrite