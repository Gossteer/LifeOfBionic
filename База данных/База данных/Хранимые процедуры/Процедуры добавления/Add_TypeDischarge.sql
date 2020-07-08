use [Life_of_Bionic]  --Добавление типа выписки
go
create procedure [Add_TypeDischarge]
@NameDischarge varchar (50),
@TypeDischarge_Logical_Delete bit
as
insert into [dbo].[TypeDischarge] (NameDischarge,TypeDischarge_Logical_Delete)
values (@NameDischarge,@TypeDischarge_Logical_Delete)