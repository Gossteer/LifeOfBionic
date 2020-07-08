use [Life_of_Bionic]  -- логическое удалениe формы записи
go
create procedure [logdel_FormWrite]
@id_FormWrite int
as
Update [dbo].[FormWrite]
set
	FormWrite_Logical_Delete = 1
where
id_FormWrite = @id_FormWrite
