use [Life_of_Bionic] -- изменение формы записи 
go
create procedure [UPD_FormWrite]
@id_FormWrite int,
@id_worker int,
@id_TypeWrite int,
@mail varchar (50),
@PhoneNumber varchar (12),
@Sites varchar (100),
@Adress varchar (100)
as
Update [dbo].[FormWrite]
set
	id_worker = @id_worker,
	id_TypeWrite = @id_TypeWrite,
	mail = @mail,
	PhoneNumber = @PhoneNumber,
	Sites = @Sites,
	Adress = @Adress
where
	id_FormWrite = @id_FormWrite