--1 этап 
use Life_of_Bionic
CREATE MASTER KEY ENCRYPTION BY
    PASSWORD= 'superpassword#12'

--2 этап
use Life_of_Bionic
CREATE CERTIFICATE cert1
   WITH SUBJECT = 'Certificate for Admin bd';

--3 этап
use Life_of_Bionic
CREATE SYMMETRIC KEY SSN_Key_01
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE cert1;
GO