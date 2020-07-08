use [Life_of_Bionic]
go 
create procedure [Select_Role_Percon] 
@User_Nick varchar (50), 
@User_Pass varchar (50) 
as 
OPEN SYMMETRIC KEY SSN_Key_01 
DECRYPTION BY CERTIFICATE cert1;
DECLARE @Id_Role int 
DECLARE @Answer_User_Login bit 
DECLARE @Answer_User_Pass bit 
DECLARE @Nenaviju_SQL bit 
DECLARE @User_Pass_BD varchar(50) 

select @User_Pass_BD = convert(char,DecryptByKey([User_Pass])) 
from [dbo].[Personal] 
WHERE User_Nick = @User_Nick

SELECT @Answer_User_Login = COUNT(*) 
FROM dbo.Personal 
WHERE User_Nick = @User_Nick  and Personal.Personal_Logical_Delete = 0

SELECT @Nenaviju_SQL   = COUNT(*) 
FROM dbo.Personal 
WHERE User_Nick = @User_Nick  and Personal.Personal_Logical_Delete = 1

SELECT @Answer_User_Pass = COUNT(*) 
FROM dbo.Personal 
WHERE User_Nick = @User_Nick and @User_Pass_BD = @User_Pass 

Select @Id_Role = id_Role 
FROM dbo.Personal 
WHERE User_Nick = @User_Nick 

IF (@Answer_User_Login = 1) 
begin 
if (@Answer_User_Pass = 1) 
begin 

SELECT * 
FROM dbo.Role 
WHERE id_Role = @Id_Role 
end 

else 
THROW 50278, 'Неверный пароль или логин', 1 

end 

else if (@Nenaviju_SQL = 1)
THROW 50685, 'Данный пользователь удалён из системы, обратитесь к администратору',1
else
THROW 50277, 'Неверный пароль или логин', 1 
