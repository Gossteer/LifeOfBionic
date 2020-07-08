use [Life_of_Bionic]  --Добавление формы записи
go
create procedure [Add_FormWrite]
@id_worker int,
@id_TypeWrite int,
@mail varchar (50),
@PhoneNumber varchar (12),
@Sites varchar (100),
@Adress varchar (100),
@FormWrite_Logical_Delete bit
as
insert into [dbo].[FormWrite] (id_worker,id_TypeWrite,mail,PhoneNumber,Sites,Adress,FormWrite_Logical_Delete)
values (@id_worker,@id_TypeWrite,@mail,@PhoneNumber,@Sites,@Adress,@FormWrite_Logical_Delete)