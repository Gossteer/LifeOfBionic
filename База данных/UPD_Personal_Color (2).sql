use [Life_of_Bionic] -- изменение персонала
go

alter table UPD_Personal
add color varchar (100) null

alter procedure [UPD_Personal]
@id_worker int,
@color varchar (100)
as
Update [dbo].[Personal]
set
	color = @color
where
	id_worker = @id_worker