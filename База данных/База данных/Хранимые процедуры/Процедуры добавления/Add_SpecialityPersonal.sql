use [Life_of_Bionic]  --���������� ������������� ��� ���������
go 
create procedure [Add_SpecialityPersonal]
@Name_SpecialityPersonal varchar (50),
@SpecialityPersonal_Logical_Delete bit
as
insert into [dbo].[SpecialityPersonal] (Name_SpecialityPersonal,SpecialityPersonal_Logical_Delete)
values (@Name_SpecialityPersonal,@SpecialityPersonal_Logical_Delete)