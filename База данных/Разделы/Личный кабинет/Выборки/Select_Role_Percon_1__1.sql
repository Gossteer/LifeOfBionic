use [Life_of_Bionic]
go 
create procedure [Select_Role_Percon] 
@User_Nick varchar (50), 
@User_Pass varchar (50) 
as 
OPEN SYMMETRIC KEY SSN_Key_01 
DECRYPTION BY CERTIFICATE cert1;
DECLARE @User_Pass_BD varchar(50) 

select @User_Pass_BD = convert(char,DecryptByKey([User_Pass])) 
from [dbo].[Personal] 
WHERE User_Nick = @User_Nick

IF (exists(Select Personal.id_worker From Personal WHERE Personal.User_Nick = @User_Nick and Personal.Personal_Logical_Delete = 0)) 
begin 
if (exists(Select Personal.id_worker From Personal WHERE Personal.User_Pass = @User_Pass_BD and Personal.Personal_Logical_Delete = 0)) 
SELECT * 
FROM dbo.Role 
WHERE id_Role = (Select Personal.id_Role FROM Personal Where Personal.User_Nick = @User_Nick)
else 
THROW 50278, 'Неверный пароль или логин', 1 
end 
else if  (exists(Select Personal.id_worker From Personal WHERE Personal.User_Nick = @User_Nick and Personal.Personal_Logical_Delete = 1))
THROW 50685, 'Данный пользователь удалён из системы, обратитесь к администратору',1
else
THROW 50277, 'Неверный пароль или логин', 1 
