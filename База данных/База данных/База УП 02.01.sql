Create DataBase [Life_of_Bionic] 
go

set quoted_identifier on
go
set ansi_nulls on
go
set ansi_padding on
go 

use [Life_of_Bionic]
go 

--Производитель
Create table [dbo].[Manufacturer]
(
	[id_Manufacturer] [int] not null identity(1,1),
	[Name_Manufacturer] [varchar] (100) not null,
	[Adress] [varchar] (100) null,
	[Mail] [varchar] (50) null,
	[Manufacturer_Logical_Delete] [bit] not null default (0)
	Constraint [PK_Manufacturer] primary key clustered
	([id_Manufacturer] ASC ) on [PRIMARY],
	CONSTRAINT uc_Manufacturer UNIQUE (Name_Manufacturer),
	CONSTRAINT uc_ManufacturerMail UNIQUE (Mail),
	Constraint [CH_check_Mail_Manufacturer] check 
	([Mail] like '%@%.%' and [Mail] not in ('!','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\'))
)


--Категории медикаментов
Create table [dbo].[CategoryOfMedicament]
(
	[id_CategoryOfMedicament] [int] not null identity(1,1),
	[Name_MedCategory] [varchar] (1) not null,
	[CategoryOfMedicament_Logical_Delete] [bit] not null default (0)
	Constraint [PK_CategoryOfMedicament] primary key clustered
	([id_CategoryOfMedicament] ASC ) on [PRIMARY],
	CONSTRAINT uc_CategoryOfMedicament UNIQUE (Name_MedCategory),
	Constraint [CH_check_NameMedCategory] check
	([Name_MedCategory] like '[A-Z]' or [Name_MedCategory] like '[a-z]' )
)


--Тип записи на приём
Create table [dbo].[TypeWrite]
(
	[id_TypeWrite] [int] not null identity(1,1),
	[Name_Write] [varchar] (50) not null,
	[TypeWrite_Logical_Delete] [bit] not null default (0)
	Constraint [PK_TypeWrite] primary key clustered
	([id_TypeWrite] ASC ) on [PRIMARY],
	CONSTRAINT uc_TypeWriteName UNIQUE (Name_Write),
	Constraint [CH_check_Name_Write] check
	([Name_Write] not in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0'))
)


--Данные граждан
Create table [dbo].[DataCitizen]
(
	[id_Citizen] [int] not null identity(1,1),
	[NameCit] [varchar] (50) not null,
	[SurnameCit] [varchar] (50) not null,
	[PatronymicCit] [varchar] (50) null,
	[Snils] [varchar] (11) not null,
	[SeriesPassportCit] [int] not null,
	[NumberPassportCit] [int] not null,
	[DateBirthCit] [date] not null,
	[AmountOfDiagnosis] [int] not null default (0),
	[DataCitizen_Logical_Delete] [bit] not null default (0)
	Constraint [PK_DataCitizen] primary key clustered
	([id_Citizen] ASC ) on [PRIMARY],
	Constraint [CH_check_NameCitizen] check
	(([NameCit] like '%[А-Я]%' or [NameCit] like '%[а-я]%') and [NameCit] not in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0')),
	Constraint [CH_check_SurnameCitizen] check
	(([PatronymicCit] like '%[А-Я]%' or [PatronymicCit] like '%[а-я]%') and [surnameCit] not in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0')),
	Constraint [CH_check_PatronymicCitizen] check
	(([PatronymicCit] like '%[А-Я]%' or [PatronymicCit] like '%[а-я]%') and [PatronymicCit] not in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0')),
	Constraint [CH_check_SnilsCitizen] check
	([Snils] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	Constraint [CH_check_SeriesPassportCitizen] check
	([SeriesPassportCit] like '[0-9][0-9][0-9][0-9]'),
	Constraint [CH_check_NumberPassportCitizen] check
	([NumberPassportCit] like '[0-9][0-9][0-9][0-9][0-9][0-9]'),
	CONSTRAINT uc_PassportCitizen UNIQUE (SeriesPassportCit,NumberPassportCit),
	CONSTRAINT uc_SnilsCit UNIQUE (Snils),
)	

--Тип употребления
Create table [dbo].[TypeUse]
(
	[id_TypeUse] [int] not null identity(1,1),
	[Name_Use] [varchar] (50) not null,
	[TypeUse_Logical_Delete] [bit] not null default (0)
	Constraint [PK_TypeUse] primary key clustered
	([id_TypeUse] ASC ) on [PRIMARY],
	Constraint [CH_check_Name_Use] check
	(([Name_Use] like '%[А-Я]%' or [Name_Use] like '%[а-я]%') 
	and [Name_Use] not in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','\','1','2','3','4','5','6','7','8','9','0')),
	CONSTRAINT uc_TypeUse UNIQUE (Name_Use)
)

--Справочник болезней
Create table [dbo].[DirectoryDisease]
(
	[id_Disease] [int] not null identity(1,1),
	[Name_Disease] [varchar] (50) not null,
	[DirectoryDisease_Logical_Delete] [bit] not null default (0)
	Constraint [PK_Disease] primary key clustered
	([id_Disease] ASC ) on [PRIMARY],
	CONSTRAINT uc_DirectoryDisease UNIQUE (Name_Disease),
	Constraint [CH_check_Name_Disease] check
	(([Name_Disease] like '%[А-Я]%' or [Name_Disease] like '%[а-я]%') 
	and [Name_Disease] not in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0')) 
)


--Специальность персонала
Create table [dbo].[SpecialityPersonal]
(
	[id_SpecialityPersonal] [int] not null identity(1,1),
	[Name_SpecialityPersonal] [varchar] (150) not null,
	[SpecialityPersonal_Logical_Delete] [bit] not null default (0)
	Constraint [PK_SpecialityPersonal] primary key clustered
	([id_SpecialityPersonal] ASC ) on [PRIMARY],
	CONSTRAINT uc_NameSpecialityPersonal UNIQUE (Name_SpecialityPersonal),
	Constraint [CH_check_Name_SpecialityPersonal] check
	(([Name_SpecialityPersonal] like '%[А-Я]%' or [Name_SpecialityPersonal] like '%[а-я]%') 
	and [Name_SpecialityPersonal] not in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0'))
)


--Рабочий график персонала
Create table [dbo].[WorkSchedule]
(
	[id_WorkSchedule] [int] not null identity(1,1),
	[weekdays] [VARCHAR] (16) not null,
	[WorkSchedule_Logical_Delete] [bit] not null default (0)
	constraint [PK_Student] primary key clustered 
	([id_WorkSchedule] ASC) on [PRIMARY],
	CONSTRAINT uc_WorkSchedule UNIQUE (weekdays),
	Constraint [CH_check_WorkSchedule] check
	([weekdays] like '[0-7]/[0-7]' )
)


--Роли
Create table [dbo].[Role]
(
	[id_Role] [int] not null identity(1,1),
	[Write] [bit] not null,
	[CardDesign] [bit] not null,
	[AcceptanceMedication] [bit] not null,
	[ResolutionStatement] [bit] not null,
	[AdmissionPatient] [bit] not null,
	[id_SpecialityPersonal]  [int] not null, --выступает в качестве наименования роли
	[Role_Logical_Delete] [bit] not null default (0)
	Constraint [PK_Role] primary key clustered
	([id_Role] ASC ) on [PRIMARY],
	constraint [FK_SpecialityPersonal] foreign key ([id_SpecialityPersonal])
	references [dbo].[SpecialityPersonal] ([id_SpecialityPersonal])
)

-- Тип выписки
Create table [dbo].[TypeDischarge]
(
	[id_TypeDischarge] [int] not null identity(1,1),
	[NameDischarge] [varchar] (50) not null,
	[TypeDischarge_Logical_Delete] [bit] not null default (0)
	Constraint [PK_TypeDischarge] primary key clustered
	([id_TypeDischarge] ASC ) on [PRIMARY],
	Constraint [CH_check_NameDischarge] check
	(([NameDischarge] like '%[А-Я]%' or [NameDischarge] like '%[а-я]%') 
	and [NameDischarge] not in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0')),
	CONSTRAINT uc_TypeDischarge UNIQUE (NameDischarge)
)


--Правила оказания услуг
Create table [dbo].[Regulation]
(
	[id_Regulation] [int] not null identity(1,1),
	[TextRegulation] [text] not null,
	[id_SpecialityPersonal] [int] not null,
	[Regulation_Logical_Delete] [bit] not null default (0)
	Constraint [PK_Regulation] primary key clustered
	([id_Regulation] ASC ) on [PRIMARY],
	constraint [FK_Speciality] foreign key ([id_SpecialityPersonal])
	references [dbo].[SpecialityPersonal] ([id_SpecialityPersonal])
)

--Медикаменты
Create table [dbo].[Medicament]
(
	[id_Medicament] [int] not null identity(1,1),
	[Name_Medicament] [varchar] (100) not null,
	[id_Manufacturer] [int] not null,
	[id_CategoryOfMedicament] [int] not null,
	[Medicament_Logical_Delete] [bit] not null default (0)
	Constraint [PK_Medicament] primary key clustered
	([id_Medicament] ASC ) on [PRIMARY],
	constraint [FK_CategoryOfMedicament] foreign key ([id_CategoryOfMedicament])
	references [dbo].[CategoryOfMedicament] ([id_CategoryOfMedicament]),
	constraint [FK_Manufacturer] foreign key ([id_Manufacturer])
	references [dbo].[Manufacturer] ([id_Manufacturer]),
	Constraint [CH_check_NameMedicament] check
	([Name_Medicament] not in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"',';',':','?','{','}','[',']','<','>','/','\')),
	CONSTRAINT uc_NameMedicament UNIQUE (Name_Medicament),
)


--Персонал
Create table [dbo].[Personal]
(
	[id_worker] [int] not null identity(1,1),
	[NamePers] [varchar] (50) not null,
	[SurnamePers] [varchar] (50)not null,
	[PatronymicPers] [varchar] (50) null,
	[SeriesPassportPers] [int] not null, 
	[NumberPassportPers] [int] not null,
	[User_Nick] [VARCHAR] (50)  not null,
	[User_Pass] [VARBINARY] (max) not null,
	[id_WorkSchedule] [int] null,
	[id_Role] [int] null,
	[Personal_Logical_Delete] [bit] not null default (0)
	Constraint [PK_Personal] primary key clustered
	([id_worker] ASC ) on [PRIMARY],
	constraint [FK_WorkSchedule] foreign key ([id_WorkSchedule])
	references [dbo].[WorkSchedule] ([id_WorkSchedule]),
	constraint [FK_RolePersonal] foreign key ([id_Role])
	references [dbo].[Role] ([id_Role]),
	Constraint [CH_check_NamePersonal] check
	(([NamePers] like '%[А-Я]%' or [NamePers] like '%[а-я]%') 
	and [NamePers] not in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0')),
	Constraint [CH_check_SurnamePersonal] check
	(([SurnamePers] like '%[А-Я]%' or [SurnamePers] like '%[а-я]%') 
	and [SurnamePers] not in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0')),
	Constraint [CH_check_PatronymicPersonal] check
	(([PatronymicPers] like '%[А-Я]%' or [PatronymicPers] like '%[а-я]%') 
	and [PatronymicPers] not in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0')),
	Constraint [CH_check_SeriesPassportPersonal] check
	([SeriesPassportPers] like '[0-9][0-9][0-9][0-9]'),
	Constraint [CH_check_NumberPassportPersonal] check
	([NumberPassportPers] like '[0-9][0-9][0-9][0-9][0-9][0-9]'),
	Constraint [CH_check_UserNick] check
	([User_Nick] not in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\')),
	CONSTRAINT uc_UserNick UNIQUE (User_Nick),
	CONSTRAINT uc_PassportPersonal UNIQUE (SeriesPassportPers,NumberPassportPers)
)


--Склад
Create table [dbo].[Storage]
(
	[id_spot] [int] not null identity(1,1),
	[Amount] [int] not null,
	[occupiedSpace] [int] not null, --занятое место на складе
	[Storage_Logical_Delete] [bit] not null default (0)
	Constraint [PK_Storage] primary key clustered
	([id_spot] ASC ) on [PRIMARY],	
	Constraint [CH_check_AmountOnSpotStorage] check
	(Amount>=occupiedSpace),
)


--Доставка медикаментов
Create table [dbo].[DeliveryMedicament]
(
	[id_DeliveryMedicament] [int] not null identity(1,1),
	[Amount] [int] not null,
	[DateOfDelivery] [date] not null,
	[id_Medicament] [int] not null,
	[id_worker] [int] not null,
	[id_spot] [int] not null,
	[DeliveryMedicament_Logical_Delete] [bit] not null default (0)
	Constraint [PK_DeliveryMedicament] primary key clustered
	([id_DeliveryMedicament] ASC ) on [PRIMARY],
	constraint [FK_MedicamentDelivery] foreign key ([id_Medicament])
	references [dbo].[Medicament] ([id_Medicament]),
	constraint [FK_PersonalDelivery] foreign key ([id_worker])
	references [dbo].[Personal] ([id_worker]),
	constraint [FK_Storage] foreign key ([id_spot])
	references [dbo].[Storage] ([id_spot]),
	--Constraint [CH_check_DeliveryAmount] check
	--([Amount] like '%[0-9]%' and [Amount] not in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	--'"','№',';',':','?','{','}','[',']','<','>','/','\')),
	Constraint [CH_Check_DateOfDelivery] check (DATEDIFF (DAY,DateOfDelivery,getDate())=0)
)


-- Категория болезни
Create table [dbo].[CategoriesDisease]
(
	[id_CategoriesDisease] [int]  not null identity(1,1),
	[Name_CategoriesDisease] [varchar] (50) not null,
	[CategoriesDisease_Logical_Delete] [bit] not null default (0)
	Constraint [PK_CategoriesDisease] primary key clustered
	([id_CategoriesDisease] ASC ) on [PRIMARY],
	Constraint [CH_check_Name_CategoriesDisease] check
	(([Name_CategoriesDisease] like '%[А-Я]%' or [Name_CategoriesDisease] like '%[а-я]%') 
	and [Name_CategoriesDisease] not in ('!','@','#','$','%','^','&','*','(',')','_','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','\')),
	CONSTRAINT uc_CategoriesDisease UNIQUE (Name_CategoriesDisease)
)


--Форма записи
Create table [dbo].[FormWrite]
(
	[id_FormWrite] [INT] not null identity(1,1),
	[id_worker] [int] not null,
	[id_TypeWrite] [int] not null,
	[mail] [varchar] (50) null,
	[PhoneNumber] [varchar] (16) null,
	[Sites] [varchar] (100) null,
	[Adress] [varchar] (100) null,
	[FormWrite_Logical_Delete] [bit] not null default (0)
	Constraint [PK_FormWrite] primary key clustered
	([id_FormWrite] ASC ) on [PRIMARY],
	constraint [FK_PersonalWrite] foreign key ([id_worker])
	references [dbo].[Personal] ([id_worker]),
	constraint [FK_TypeWrite] foreign key ([id_TypeWrite])
	references [dbo].[TypeWrite] ([id_TypeWrite]),
	Constraint [CH_check_MailFormWrite] check
	([Mail] like '%@%.%' and [Mail] not in ('!','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\')),
	Constraint [CH_check_PhoneNumber] check
	([PhoneNumber] like '+[0-9]([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]') -- +X(XXX)XXX-XX-XX
)


--Запись на приём
Create table [dbo].[WriteAppointment]
(
	[id_WriteAppointment] [int] not null identity(1,1),
	[times] [datetime] not null,
	[visit] [bit] not null,
	[id_Citizen] [int] not null, 
	[id_FormWrite] [int] not null,
	[SentToTreatment] [bit] not null,
	[WriteAppointment_Logical_Delete] [bit] not null default (0)
	Constraint [PK_WriteAppointment] primary key clustered
	([id_WriteAppointment] ASC ) on [PRIMARY],
	constraint [FK_Citizen] foreign key ([id_Citizen])
	references [dbo].[DataCitizen] ([id_Citizen]),
	constraint [FK_FormWrite] foreign key ([id_FormWrite])
	references [dbo].[FormWrite] ([id_FormWrite])
	--Constraint [CH_check_WriteAppointment] check
	--([times] like '[0-2]:[0-9] [0-3][0-9]-[0-1][0-9]-[0-2][0][0-5][0-9]'), -- xx:xx dd-mm-yyyy, 16:00 28-03-2015
)

--Терапевтическое отделение
Create table [dbo].[TherapeuticDepartament]
(
	[id_Room] [int] not null identity(1,1),
	[amountRooms] [int] not null,
	[BusyRoom] [int] not null default ('0'), --занятно мест
	[id_worker] [int] not null,
	[id_CategoriesDisease] [int] not null,
	[TherapeuticDepartament_Logical_Delete] [bit] not null default (0)
	Constraint [PK_TherapeuticDepartament] primary key clustered
	([id_Room] ASC ) on [PRIMARY],
	constraint [FK_PersonalTherapeutic] foreign key ([id_worker])
	references [dbo].[Personal] ([id_worker]),
	constraint [FK_CategoriesDisease] foreign key ([id_CategoriesDisease])
	references [dbo].[CategoriesDisease] ([id_CategoriesDisease]),
	Constraint [CH_check_RoomsInTherapy] check
	(amountRooms>=BusyRoom)
)


--Диагноз
Create table [dbo].[Diagnosis]
(
	[id_Diagnoz] [int] not null identity(1,1),
	[TimeDisease] [int] not null default ('14'), 
	[Amount] [int] not null,
	[ID_Room] [int] not null,
	[id_TypeUse] [int] not null,
	[id_Medicament] [int] not null,
	[id_Disease] [int] not null,
	[Diagnosis_Logical_Delete] [bit] not null default (0)
	Constraint [PK_Diagnoz] primary key clustered
	([id_Diagnoz] ASC ) on [PRIMARY],
	constraint [FK_Room] foreign key ([id_Room])
	references [dbo].[TherapeuticDepartament] ([id_Room]),
	constraint [FK_TypeUse] foreign key ([id_TypeUse])
	references [dbo].[TypeUse] ([id_TypeUse]),
	constraint [FK_MedicamentDiagnosis] foreign key ([id_Medicament])
	references [dbo].[Medicament] ([id_Medicament]),
	constraint [FK_DiseaseDiagnosis] foreign key ([id_Disease])
	references [dbo].[DirectoryDisease] ([id_Disease])
)


--Карта лечения
Create table [dbo].[CardTreatments]
(
	[id_card] [int] not null identity(1,1),
	[id_WriteAppointment] [int] not null,
	[id_Diagnoz] [int] not null,
	[MedicalDepartament] [int] not null,
	[CardTreatments_Logical_Delete] [bit] not null default (0), 
	[Cured] [bit] not null default ('В процессе лечения')
	Constraint [PK_Card] primary key clustered
	([id_card] ASC ) on [PRIMARY],
	constraint [FK_Disease] foreign key ([id_WriteAppointment])
	references [dbo].[WriteAppointment] ([id_WriteAppointment]),
	constraint [FK_Diaznoz] foreign key ([id_Diagnoz])
	references [dbo].[Diagnosis] ([id_Diagnoz])
)


--Выписка
Create table [dbo].[Discharge]
(
	[id_Discharge] [int] not null identity(1,1),
	[DateDischarge] [date] not null,
	[id_card] [int] not null,
	[id_TypeDischarge] [int] not null,
	[Discharge_Logical_Delete] [bit] not null default (0)
	Constraint [PK_Discharge] primary key clustered
	([id_Discharge] ASC ) on [PRIMARY],
	constraint [FK_Card] foreign key ([id_Card])
	references [dbo].[CardTreatments] ([id_Card]),
	constraint [FK_TypeDischarge] foreign key ([id_TypeDischarge])
	references [dbo].[TypeDischarge] ([id_TypeDischarge]),
)
