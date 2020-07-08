use [Life_of_Bionic]
insert into [dbo].[Manufacturer] (Name_Manufacturer,Adress,Mail,Manufacturer_Logical_Delete)
values 
('Актива','г.Москва','Activa@mail.ru','0'),
('Биотех','г.Сенкт-Петербург','Biotech@mail.ru','0'),
('BOIRON','г.Москва','BoiRon@mail.ru','0')

--добавление категории лекарств
insert into [dbo].[CategoryOfMedicament] (Name_MedCategory,CategoryOfMedicament_Logical_Delete)
values
('A','0'),
('B','0'),
('C','0')

--добавление типа записи
insert into [dbo].[TypeWrite] (Name_Write,TypeWrite_Logical_Delete)
values
('По телефону','0'),
('Через интернет','0'),
('Через регистратуру','0')

--добавление данных граждан
insert into [dbo].[DataCitizen] (NameCit,SurnameCit,PatronymicCit,Snils,SeriesPassportCit,NumberPassportCit,DateBirthCit,DataCitizen_Logical_Delete)
values
('Виктор','Олежко','Викторович','12748294281','1234','653721','2000-01-20','0'),
('Павел','Серько','Анатольевич','28478492045','4214','948271','1998-12-30','0'),
('Дмитрий','Дубров','Агатьев','95837261264','4938','425349','1997-04-14','0')

--Добавление типа употребления
insert into [dbo].[TypeUse] (Name_Use,TypeUse_Logical_Delete)
values
('Раз в день','0'),
('Внутривенно','0'),
('После еды','0')

--добавление справочника болезней
insert into [dbo].[DirectoryDisease] (Name_Disease,DirectoryDisease_Logical_Delete)
values
('Астма','0'),
('Желудочные колики','0'),
('Аллергия','0')

--добавление специальности
insert into [dbo].[SpecialityPersonal] (Name_SpecialityPersonal,SpecialityPersonal_Logical_Delete)
values 
('Аллерголог','0'),
('Терапевт','0'),
('Хирург','0')

--Добавление графика персонала
insert into [dbo].[WorkSchedule] (weekdays,WorkSchedule_Logical_Delete)
values 
('2/2','0'),
('3/2','0'),
('5/2','0')

--добавление роли
insert into [dbo].[Role] (Write,CardDesign,AcceptanceMedication,ResolutionStatement,AdmissionPatient,id_SpecialityPersonal,Role_Logical_Delete)
values
('1','1','1','1','0','1','0'),
('1','0','0','1','1','3','0'),
('1','1','1','0','0','2','0')

--добавление типа выписки
insert into [dbo].[TypeDischarge] (NameDischarge,TypeDischarge_Logical_Delete)
values 
('Рабочая выписка','0'),
('В учебное заведение','0'),
('Полная медицинская выписка','0')

--добавление правила по оказанию услуг
insert into [dbo].[Regulation] (TextRegulation,id_SpecialityPersonal,Regulation_Logical_Delete)
values
('Текст №1','2','0'),
('Текст №2','1','0'),
('Текст №3','3','0')

--добавлерние медикаментов
insert into [dbo].[Medicament] (Name_Medicament,id_Manufacturer,id_CategoryOfMedicament,Medicament_Logical_Delete)
values
('Ношпа','1','2','0'),
('Анальгин','3','1','0'),
('Крем-ВАК','2','3','0')

OPEN SYMMETRIC KEY SSN_Key_01
   DECRYPTION BY CERTIFICATE cert1;

--добавлениеь персонала
insert into [dbo].[Personal] (NamePers,SurnamePers,PatronymicPers,SeriesPassportPers,NumberPassportPers,User_Nick,User_Pass,id_WorkSchedule,id_Role,Personal_Logical_Delete)
values
('Пётр','Васечкин','Евгеньевич','1253','240295','Petya123',EncryptByKey(Key_GUID('SSN_Key_01'),'fd12'),'1','1','0'),
('Степан','Ковшиков','Петрович','5312','652312','Grich',EncryptByKey(Key_GUID('SSN_Key_01'),'123ggg'),'3','3','0'),
('Лимон','Кислякин','Арбузин','6666','666666','Hell123',EncryptByKey(Key_GUID('SSN_Key_01'),'41gdG'),'2','2','0')

--добавление склада
insert into [dbo].[Storage] (Amount, occupiedSpace, Storage_Logical_Delete)
values
('12','1','0'),
('15','3','1'),
('24','5','0')

--добавление поставки медикаментов
insert into [dbo].[DeliveryMedicament] (Amount, DateOfDelivery, id_Medicament,id_worker,id_spot,DeliveryMedicament_Logical_Delete)
values
('15','2019-05-29','1','1','1','0'),
('12','2019-05-29','2','2','2','0'),
('1','2019-05-29','3','3','3','0')

--Категория болезни
insert into [dbo].[CategoriesDisease] (Name_CategoriesDisease, CategoriesDisease_Logical_Delete)
values
('Лёгочные','0'),
('Желудочные','0'),
('Хирургическое','0')

--форма записи
insert into [dbo].[FormWrite] (id_worker,id_TypeWrite,mail,PhoneNumber,Sites,adress,FormWrite_Logical_Delete)
values
('1','3','LifeOfBionic1@mail.com','+7(965)315-24-52','www.vl.com','г.Москва','0'),
('2','1','LifeOfBionicSPB@mail.com','+7(535)515-24-52','www.life.com','г.Санкт-Петербург','0'),
('3','2','LifeOfBionicMoscow@mail.com','+7(235)515-24-52','www.moslife.com','г,Тенза','0')

--запись на приём
insert into [dbo].[WriteAppointment] (times,visit,id_Citizen,id_FormWrite,MedicalDepartament,SentToTreatment,WriteAppointment_Logical_Delete)
values
('12:00 12.12.2012','1','1','1','14','1','0'),
('13:00 11.11.2011','1','3','2','13','1','0'),
('11:00 10.10.2010','0','2','3','12','1','0')

--терап.отделение
insert into [dbo].[TherapeuticDepartament] (amountRooms,BusyRoom,id_worker,id_CategoriesDisease,TherapeuticDepartament_Logical_Delete)
values
('150','12','1','1','0'),
('120','30','2','3','0'),
('80','40','3','2','0')

--диагноз
insert into [dbo].[Diagnosis] (TimeDisease,Amount,ID_Room,id_TypeUse,id_Medicament,id_Disease,Diagnosis_Logical_Delete)
values
('14','1','1','3','2','3','0'),
('2','15','3','2','1','1','0'),
('23','3','2','1','3','2','0')

--карта лечения
insert into [dbo].[CardTreatments] (id_WriteAppointment,id_Diagnoz,Cured,CardTreatments_Logical_Delete)
values
('1','3','1','0'),
('2','2','0','0'),
('3','1','1','0')

--выписка
insert into [dbo].[Discharge] (DateDischarge,id_WriteAppointment,id_TypeDischarge,Discharge_Logical_Delete)
values
('12.12.2019','2','2','0'),
('11.11.2018','3','1','0'),
('10.10.2018','1','3','0')