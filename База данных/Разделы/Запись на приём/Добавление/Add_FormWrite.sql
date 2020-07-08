use [Life_of_Bionic]  --Добавление формы записи
go
create procedure [Add_FormWrite]
@id_worker int,
@id_TypeWrite int,
@mail varchar (50),
@PhoneNumber varchar (12),
@Sites varchar (100),
@Adress varchar (100)
as
if (@Mail not like '%@%.%' and @Mail  in ('!','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\'))
	THROW 50676, 'Пожалуйста кажите почту в таком формате pochta@mail.ru',1
else if (EXISTS(Select FormWrite.id_FormWrite FROM FormWrite WHERE id_worker = @id_worker and id_TypeWrite = @id_TypeWrite
and mail = @mail and PhoneNumber = @PhoneNumber and Sites = @Sites and @Adress = Adress))
return
else
insert into [dbo].[FormWrite] (id_worker,id_TypeWrite,mail,PhoneNumber,Sites,Adress)
values (@id_worker,@id_TypeWrite,@mail,@PhoneNumber,@Sites,@Adress)