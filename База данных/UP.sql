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

 Create table [dbo].[LogChange]
(
	[ID_Change] [int] not null identity(1,1),
	[Change_Date] [datetime] not null default getdate(),
	[Change_Type] [varchar] (15) not null,
	[Change_Info] [varchar] (max) 
	Constraint [PK_ChangeLog] primary key clustered
	([ID_Change] ASC ) on [PRIMARY]
)

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
	(([surnameCit] like '%[А-Я]%' or [surnameCit] like '%[а-я]%') and [surnameCit] not in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
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
	[occupiedSpace] [int] not null default (0), --занятое место на складе
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


CREATE TABLE dbo.Day_of_the_week
(  
	[id_Day_of_the_week] [int] not null identity(1,1),
    Record_Time varchar(10) NULL,
	[Day_of_the_week_Logical_Delete] [bit] not null default (0)
	Constraint [PK_Day_of_the_week] primary key clustered
	([id_Day_of_the_week] ASC ) on [PRIMARY]  

); 

--Запись на приём
Create table [dbo].[WriteAppointment]
(
	[id_WriteAppointment] [int] not null identity(1,1),
	[times] [datetime] not null,
	[visit] [bit] not null default (0),
	[id_Citizen] [int] not null, 
	[id_FormWrite] [int] not null,
	id_Day_of_the_week int not null,
	[MedicalDepartament] [int] not null,
	СategoriesDisease varchar(50) null,
	[SentToTreatment] [bit] not null default (0),
	[WriteAppointment_Logical_Delete] [bit] not null default (0)
	CONSTRAINT FK_Day_of_the_week FOREIGN KEY (id_Day_of_the_week)     
    REFERENCES dbo.Day_of_the_week (id_Day_of_the_week)       
	Constraint [PK_WriteAppointment] primary key clustered
	([id_WriteAppointment] ASC ) on [PRIMARY],
	constraint [FK_Citizen] foreign key ([id_Citizen])
	references [dbo].[DataCitizen] ([id_Citizen]),
	constraint [FK_FormWrite] foreign key ([id_FormWrite])
	references [dbo].[FormWrite] ([id_FormWrite])
)

--Терапевтическое отделение
Create table [dbo].[TherapeuticDepartament]
(
	[id_Room] [int] not null identity(1,1),
	[amountRooms] [int] not null,
	[BusyRoom] [int] not null default (0), --занятно мест
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
	[TimeDisease] [int] not null, 
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
	[Cured] [bit] not null default (0),
	[CardTreatments_Logical_Delete] [bit] not null default (0)
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
	[id_WriteAppointment] [int] not null,
	[id_TypeDischarge] [int] not null,
	[Discharge_Logical_Delete] [bit] not null default (0)
	Constraint [PK_Discharge] primary key clustered
	([id_Discharge] ASC ) on [PRIMARY],
	constraint [FK_Card] foreign key ([id_WriteAppointment])
	references [dbo].[WriteAppointment] ([id_WriteAppointment]),
	constraint [FK_TypeDischarge] foreign key ([id_TypeDischarge])
	references [dbo].[TypeDischarge] ([id_TypeDischarge]),
)

--Приход товара
Create TRIGGER Tovar_UPDATE ON dbo.DeliveryMedicament 
FOR UPDATE
AS 
update dbo.Storage set 
occupiedSpace += ((Select inserted.amount FROM inserted) - (Select deleted.amount FROM deleted))
where id_spot = (Select inserted.id_spot FROM inserted)


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ ТЕРАПЕВТИЧЕСКОГО ОТДЕЛЕНИЯ
create trigger dbo.changes_CardTreatments_trigger on  dbo.CardTreatments
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end
         
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Карта №'+ Convert(varchar (4),id_card) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Карта №'+ Convert(varchar (4),id_card) from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Карта №'+ Convert(varchar (4),id_card)  from inserted
    end
end

--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ КАТЕГОРИИ МЕДИКАМЕНТОВ
create trigger dbo.changes_CategoriesDisease_trigger on  dbo.CategoriesDisease
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end         
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Категория болезней: '+Name_CategoriesDisease from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Категория болезней: '+Name_CategoriesDisease from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		 'Категория болезней: '+Name_CategoriesDisease from inserted
    end
end 

--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ КАТЕГОРИИ МЕДИКАМЕНТОВ
create trigger dbo.changes_CategoryOfMedicament_trigger on  dbo.CategoryOfMedicament
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end
         
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Категория медикаментов: '+Name_MedCategory from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Категория медикаментов: '+Name_MedCategory from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		 'Категория медикаментов: '+Name_MedCategory from inserted
    end
end


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ КАТЕГОРИИ МЕДИКАМЕНТОВ
create trigger dbo.changes_DataCitizen_trigger on  dbo.DataCitizen
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end       
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Гражданин: '+NameCit+' '+SurnameCit+' '+PatronymicCit from deleted
end
else
begin

    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Гражданин: '+NameCit+' '+SurnameCit+' '+PatronymicCit from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Гражданин: '+NameCit+' '+SurnameCit+' '+PatronymicCit from inserted
    end
end


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ ПЕРСОНАЛА
create trigger dbo.changes_DeliveryMedicament_trigger on  dbo.DeliveryMedicament
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end       
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Доставка №'+ Convert(varchar (4),id_DeliveryMedicament) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Доставка №'+ Convert(varchar (4),id_DeliveryMedicament) from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Доставка №'+ Convert(varchar (4),id_DeliveryMedicament)  from inserted
    end
end

--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ ТЕРАПЕВТИЧЕСКОГО ОТДЕЛЕНИЯ
create trigger dbo.changes_Diagnosis_trigger on  dbo.Diagnosis
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end         
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Диагноз №'+ Convert(varchar (4),id_Diagnoz) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Диагноз №'+ Convert(varchar (4),id_Diagnoz) from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Диагноз №'+ Convert(varchar (4),id_Diagnoz)  from inserted
    end
end


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ СПРАВОЧНИКА БОЛЕЗНЕЙ
create trigger dbo.changes_DirectoryDisease_trigger on  dbo.DirectoryDisease
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end       
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Название болезни: '+ Name_Disease from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Название болезни: '+ Name_Disease from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Название болезни: '+ Name_Disease from inserted
    end
end


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ ТЕРАПЕВТИЧЕСКОГО ОТДЕЛЕНИЯ
create trigger dbo.changes_Discharge_trigger on  dbo.Discharge
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end       
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Выписка №'+ Convert(varchar (4),[id_Discharge]) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Выписка №'+ Convert(varchar (4),[id_Discharge]) from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Выписка №'+ Convert(varchar (4),[id_Discharge])  from inserted
    end
end


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ ПЕРСОНАЛА
create trigger dbo.changes_FormWrite_trigger on  dbo.FormWrite
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Форма на запись №'+ Convert(varchar (4),id_FormWrite) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Форма на запись №'+ Convert(varchar (4),id_FormWrite) from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'зФорма на запись №'+ Convert(varchar (4),id_FormWrite)  from inserted
    end
end 


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ ПРОИЗВОДИТЕЛЯ
create trigger dbo.changes_manufacturer_trigger on  dbo.Manufacturer
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end         
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Производитель: '+Name_Manufacturer from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Производитель: '+Name_Manufacturer from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		 'Производитель: '+Name_Manufacturer from inserted
    end
end


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ ГРАФИКА ПЕРСОНАЛА
create trigger dbo.changes_Medicament_trigger on  dbo.Medicament
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end      
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Медикамент: '+ Name_Medicament from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Медикамент: '+ Name_Medicament from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Медикамент: '+ Name_Medicament from inserted
    end
end 


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ ПЕРСОНАЛА
create trigger dbo.changes_Personal_trigger on  dbo.Personal
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end        
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Сотрудник: '+ SurnamePers+' '+NamePers+' '+PatronymicPers from deleted
end
else
begin

    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Сотрудник: '+ SurnamePers+' '+NamePers+' '+PatronymicPers from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Сотрудник: '+ SurnamePers+' '+NamePers+' '+PatronymicPers from inserted
    end
end


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ ГРАФИКА ПЕРСОНАЛА
create trigger dbo.changes_Regulation_trigger on  dbo.Regulation
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end      
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Правило №'+ CONVERT(varchar (4),id_Regulation) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Правило №'+ CONVERT(varchar (4),id_Regulation) from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Правило №'+ CONVERT(varchar (4),id_Regulation) from inserted
    end
end


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ ГРАФИКА ПЕРСОНАЛА
create trigger dbo.changes_Role_trigger on  dbo.[Role]
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end     
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Роли №'+ CONVERT(varchar (4),id_Role) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Роли №'+ CONVERT(varchar (4),id_Role) from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Роли №'+ CONVERT(varchar (4),id_Role) from inserted
    end
end


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ СПЕЦИАЛЬНОСТЕЙ ПЕРСОНАЛА
create trigger dbo.changes_SpecialityPersonal_trigger on  dbo.SpecialityPersonal
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end       
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Название специальности: '+ Name_SpecialityPersonal from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Название специальности: '+ Name_SpecialityPersonal from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Название специальности: '+ Name_SpecialityPersonal from inserted
    end
end


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ ПЕРСОНАЛА
create trigger dbo.changes_Storage_trigger on  dbo.Storage
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end      
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Ячейка склаад №'+ CONVERT(varchar (4),id_spot) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Ячейка склаад №'+ CONVERT(varchar (4),id_spot) from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Ячейка склаад №'+ CONVERT(varchar (4),id_spot) from inserted
    end
end


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ ТЕРАПЕВТИЧЕСКОГО ОТДЕЛЕНИЯ
create trigger dbo.changes_TherapeuticDepartament_trigger on  dbo.TherapeuticDepartament
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end  
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Палата №'+ Convert(varchar (4),id_Room) from deleted
end
else
begin

    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Палата №'+ Convert(varchar (4),id_Room) from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Палата №'+ Convert(varchar (4),id_Room)  from inserted
    end
end


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ ГРАФИКА ПЕРСОНАЛА
create trigger dbo.changes_TypeDischarge_trigger on  dbo.TypeDischarge
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end         
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Тип выписки: '+ NameDischarge from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Тип выписки: '+ NameDischarge from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Тип выписки: '+ NameDischarge from inserted
    end
end


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ КАТЕГОРИИ МЕДИКАМЕНТОВ
create trigger dbo.changes_TypeUse_trigger on  dbo.TypeUse
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end       
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Типе исопльзования: '+ Name_Use from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Типе исопльзования: '+ Name_Use from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Типе исопльзования: '+ Name_Use from inserted
    end
end

--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ КАТЕГОРИИ МЕДИКАМЕНТОВ
create trigger dbo.changes_TypeWrite_trigger on  dbo.TypeWrite
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end   
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Типе записи: '+Name_Write from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Типе записи: '+Name_Write from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		 'Типе записи: '+Name_Write from inserted
    end
end


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ ГРАФИКА ПЕРСОНАЛА
create trigger dbo.changes_WorkSchedulel_trigger on  dbo.WorkSchedule
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end     
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'График: '+ weekdays from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'График: '+ weekdays from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'График: '+ weekdays from inserted
    end
end


--- ТРИГГЕР ОТСЛЕЖИВАЮЩИЙ ИЗМЕНЕНИЯ ПЕРСОНАЛА
create trigger dbo.changes_WriteAppointment_trigger on  dbo.WriteAppointment
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- определеяем тип произошедших изменений INSERT,UPDATE, или DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end       
-- обработка удаления
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Удалено из ', 
	'Запись №'+ Convert(varchar (4),id_WriteAppointment) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Добавлено в ',
		'Запись №'+ Convert(varchar (4),id_WriteAppointment) from inserted
    end
-- обработка обновления
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select 'Изменено в ',
		'Запись №'+ Convert(varchar (4),id_WriteAppointment)  from inserted
    end
end 


create procedure [Add_Personal]
@NamePers varchar (50),
@SurnamePers varchar (50),
@PatronymicPers varchar (50), 
@SeriesPassportPers int,
@NumberPassportPers int,
@User_Nick varchar (50),
@User_Pass varchar (20)
as
   IF (EXISTS(SELECT Personal.id_worker
FROM dbo.Personal
WHERE User_Nick = @User_Nick))
THROW 50250, 'Данный логин уже существует', 1
	else if((@NamePers not like '%[А-Я]%' or @NamePers not like '%[а-я]%') or @NamePers in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0'))
	THROW 50673,  'Пожалуйста укажите имя только русскими буквами',1 
	else if ((@SurnamePers not like '%[А-Я]%' or @SurnamePers not like '%[а-я]%') or @SurnamePers  in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0'))
	THROW 50674,  'Пожалуйста укажите SurnameCit Only in Russian letters',1 
	else if ((@PatronymicPers not like '%[А-Я]%' or @PatronymicPers not like '%[а-я]%') or @PatronymicPers  in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0'))
	THROW 50675,  'Пожалуйста укажите отчество только русскими буквами',1 
	else
OPEN SYMMETRIC KEY SSN_Key_01
   DECRYPTION BY CERTIFICATE cert1;
insert into [dbo].[Personal] 
	(NamePers,SurnamePers,PatronymicPers,SeriesPassportPers,User_Nick,NumberPassportPers,User_Pass)
values 
	(@NamePers,@SurnamePers,@PatronymicPers,@SeriesPassportPers,@User_Nick,@NumberPassportPers,EncryptByKey(Key_GUID('SSN_Key_01'),convert(varbinary (max),@User_Pass)))


create procedure [UPD_Personal]
@SeriesPassportPers int,
@NumberPassportPers int,
@User_Pass varchar (18)
as
OPEN SYMMETRIC KEY SSN_Key_01
   DECRYPTION BY CERTIFICATE cert1;
   if ((EncryptByKey(Key_GUID('SSN_Key_01'),convert(varbinary (max),(Select Personal.User_Pass 
   FROM Personal WHERE Personal.SeriesPassportPers = @SeriesPassportPers and Personal.NumberPassportPers = @NumberPassportPers and Personal_Logical_Delete = 0)))) != @User_Pass)
   THROW 50562, 'Старый пароль не верный', 1

Update [dbo].[Personal]
set
	User_Pass = EncryptByKey(Key_GUID('SSN_Key_01'),convert(varbinary (max),@User_Pass))
where
	id_worker = (SELECT Personal.id_worker FROM Personal WHERE Personal.SeriesPassportPers = @SeriesPassportPers and Personal.NumberPassportPers = @NumberPassportPers and Personal_Logical_Delete = 0)


create procedure Select_Personal
as
SELECT       Role.id_Role, Personal.id_worker, dbo.Personal.SurnamePers + ' ' + dbo.Personal.NamePers + ' ' + dbo.Personal.PatronymicPers as 'ФИО', 
Convert(varchar,Personal.SeriesPassportPers) + ' ' + Convert(varchar,Personal.NumberPassportPers) as 'Серия и номер', isnull(WorkSchedule.weekdays,'Не назначен') as 'Рабочий график',
dbo.Role.id_Role as 'Номер роли', isnull(dbo.SpecialityPersonal.Name_SpecialityPersonal, 'Не назначена') as 'Специализация'
FROM            dbo.Personal LEFT JOIN
                         dbo.Role ON dbo.Personal.id_Role = dbo.Role.id_Role LEFT JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal LEFT JOIN
                         dbo.WorkSchedule ON dbo.Personal.id_WorkSchedule = dbo.WorkSchedule.id_WorkSchedule
						 WHERE Personal.Personal_Logical_Delete = 0

create procedure [Select_Role]
as
SELECT        dbo.Role.id_Role as 'Номер роли', dbo.Role.Write as 'Запись', dbo.Role.CardDesign as 'Оформление карт', 
dbo.Role.AcceptanceMedication as 'Приём лекарств',  dbo.Role.ResolutionStatement as 'Выписка пациентов', dbo.Role.AdmissionPatient as 'Приём пациентов', 
                         dbo.SpecialityPersonal.Name_SpecialityPersonal as 'Специализация'
FROM            dbo.Role INNER JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal
						 WHERE Role_Logical_Delete = 0

create procedure [Select_SpecialityPersonal]
as
SELECT SpecialityPersonal.id_SpecialityPersonal, SpecialityPersonal.Name_SpecialityPersonal AS 'Специализация'
From SpecialityPersonal
WHERE SpecialityPersonal_Logical_Delete = 0 and SpecialityPersonal.Name_SpecialityPersonal != 'Админ' and SpecialityPersonal.Name_SpecialityPersonal != 'Главный Врач'


create procedure [Select_WorkSchedule]
as
SELECT WorkSchedule.id_WorkSchedule,  WorkSchedule.weekdays as 'График' 
FROM WorkSchedule
WHERE WorkSchedule_Logical_Delete = 0

create procedure [Add_Role]
@Write bit,
@CardDesign bit,
@AcceptanceMedication bit,
@ResolutionStatement bit,
@AdmissionPatient bit,
@id_SpecialityPersonal int
as
if (Exists(SELECT dbo.[Role].id_Role FROM [Role] WHERE Write = @Write and CardDesign = @CardDesign and AcceptanceMedication = @AcceptanceMedication
and ResolutionStatement = @ResolutionStatement and id_SpecialityPersonal = @id_SpecialityPersonal and Role_Logical_Delete = 0))
THROW 50664, 'Данная роль уже существует', 1
else if (Exists(SELECT dbo.[Role].id_Role FROM [Role] WHERE Write = @Write and CardDesign = @CardDesign and AcceptanceMedication = @AcceptanceMedication
and ResolutionStatement = @ResolutionStatement and id_SpecialityPersonal = @id_SpecialityPersonal and Role_Logical_Delete = 1))
UPDATE [Role]
set
Role_Logical_Delete = 0
where 
id_Role = (SELECT dbo.[Role].id_Role FROM [Role] WHERE Write = @Write and CardDesign = @CardDesign and AcceptanceMedication = @AcceptanceMedication
and ResolutionStatement = @ResolutionStatement and id_SpecialityPersonal = @id_SpecialityPersonal and Role_Logical_Delete = 1)
else
insert into [dbo].[Role] (Write,CardDesign,AcceptanceMedication,ResolutionStatement,AdmissionPatient, id_SpecialityPersonal)
values (@Write,@CardDesign,@AcceptanceMedication,@ResolutionStatement, @AdmissionPatient,@id_SpecialityPersonal)


create procedure [Add_SpecialityPersonal]
@Name_SpecialityPersonal varchar (50)
as
if (Exists(SELECT SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal WHERE SpecialityPersonal.Name_SpecialityPersonal = @Name_SpecialityPersonal and SpecialityPersonal_Logical_Delete = 0))
THROW 50665, 'Данная специализация уже создана', 1
else if (Exists(SELECT SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal WHERE SpecialityPersonal.Name_SpecialityPersonal = @Name_SpecialityPersonal and SpecialityPersonal_Logical_Delete = 1))
UPDATE [SpecialityPersonal]
set
SpecialityPersonal_Logical_Delete = 0
where 
id_SpecialityPersonal = (SELECT SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal WHERE SpecialityPersonal.Name_SpecialityPersonal = @Name_SpecialityPersonal and SpecialityPersonal_Logical_Delete = 1)
else
insert into [dbo].[SpecialityPersonal] (Name_SpecialityPersonal)
values (@Name_SpecialityPersonal)


create procedure [Add_WorkSchedule]
@weekdays varchar (16)
as
if (@weekdays not like '[0-7]/[0-7]' )
THROW 50684, 'Пожалуйста укажите график в формате: 5/7. В неделе не более 7 дней',1
else if (Exists(SELECT WorkSchedule.id_WorkSchedule FROM WorkSchedule WHERE WorkSchedule.weekdays = @weekdays and WorkSchedule.WorkSchedule_Logical_Delete = 0))
THROW 50666, 'Данный график уже создан', 1
else if (Exists(SELECT WorkSchedule.id_WorkSchedule FROM WorkSchedule WHERE WorkSchedule.weekdays = @weekdays and WorkSchedule.WorkSchedule_Logical_Delete = 1))
UPDATE [WorkSchedule]
set
WorkSchedule_Logical_Delete = 0
where 
WorkSchedule.id_WorkSchedule = (SELECT WorkSchedule.id_WorkSchedule FROM WorkSchedule WHERE WorkSchedule.weekdays = @weekdays and WorkSchedule.WorkSchedule_Logical_Delete = 1)
else
insert into [dbo].[WorkSchedule] (weekdays)
values (@weekdays)


create procedure [UPD_Personal_For_Admin]
@id_worker int,
@NamePers varchar (50),
@SurnamePers varchar (50),
@PatronymicPers varchar (50), 
@SeriesPassportPers int,
@NumberPassportPers int,
@User_Nick varchar (50),
@ID_Role int, 
@id_WorkSchedule int
as
IF (@id_worker != (SELECT Personal.id_worker FROM Personal
WHERE  (SeriesPassportPers = @SeriesPassportPers and NumberPassportPers = @NumberPassportPers)
or User_Nick = User_Nick and Personal_Logical_Delete = 0))
THROW 50667, 'Данный пользователь уже существует',1
else IF (@id_worker != (SELECT Personal.id_worker FROM Personal
WHERE  (SeriesPassportPers = @SeriesPassportPers and NumberPassportPers = @NumberPassportPers)
or User_Nick = User_Nick and Personal_Logical_Delete = 1))
begin
Update [dbo].[Personal]
set
	NamePers = @NamePers,
	SurnamePers = @SurnamePers,
	PatronymicPers = @PatronymicPers,
	 Personal_Logical_Delete = 0,
	 	id_role = @id_Role,
	id_WorkSchedule = @id_WorkSchedule
where
	id_worker = (SELECT Personal.id_worker FROM Personal
WHERE  (SeriesPassportPers = @SeriesPassportPers and NumberPassportPers = @NumberPassportPers)
or User_Nick = User_Nick and Personal_Logical_Delete = 1)
	Update [dbo].[Personal]
set
Personal_Logical_Delete = 1
where
	id_worker = @id_worker
end
else 
Update [dbo].[Personal]
set
	NamePers = @NamePers,
	SurnamePers = @SurnamePers,
	PatronymicPers = @PatronymicPers,
	SeriesPassportPers = @SeriesPassportPers,
	NumberPassportPers = @NumberPassportPers,
	User_Nick = @User_Nick,
	id_role = @id_Role,
	id_WorkSchedule = @id_WorkSchedule
where
	id_worker = @id_worker


create procedure [UPD_Role]
@id_Role int,
@Write bit,
@CardDesign bit,
@AcceptanceMedication bit,
@ResolutionStatement bit,
@AdmissionPatient bit,
@id_SpecialityPersonal int
as
if (@id_Role != (SELECT dbo.[Role].id_Role FROM [Role] WHERE Write = @Write and CardDesign = @CardDesign and AcceptanceMedication = @AcceptanceMedication
and ResolutionStatement = @ResolutionStatement and id_SpecialityPersonal = @id_SpecialityPersonal and Role_Logical_Delete = 0))
THROW 50664, 'Данная роль уже существует', 1
else if (@id_Role != (SELECT dbo.[Role].id_Role FROM [Role] WHERE Write = @Write and CardDesign = @CardDesign and AcceptanceMedication = @AcceptanceMedication
and ResolutionStatement = @ResolutionStatement and id_SpecialityPersonal = @id_SpecialityPersonal and Role_Logical_Delete = 1))
begin
UPDATE [Role]
set
Role_Logical_Delete = 0
where 
id_Role = (SELECT dbo.[Role].id_Role FROM [Role] WHERE Write = @Write and CardDesign = @CardDesign and AcceptanceMedication = @AcceptanceMedication
and ResolutionStatement = @ResolutionStatement and id_SpecialityPersonal = @id_SpecialityPersonal and Role_Logical_Delete = 1)
UPDATE [Role]
set
Role_Logical_Delete = 1
where 
id_Role = @id_Role
end
else
Update [dbo].[Role]
set
	Write = @Write,
	CardDesign = @CardDesign,
	AcceptanceMedication = @AcceptanceMedication,
	ResolutionStatement = @ResolutionStatement,
	id_SpecialityPersonal = @id_SpecialityPersonal,
	AdmissionPatient = @AdmissionPatient
where
	id_Role = @id_Role


create procedure [UPD_SpecialityPersonal]
@id_SpecialityPersonal int,
@Name_SpecialityPersonal varchar (50)
as
if (@id_SpecialityPersonal != (SELECT SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal 
WHERE SpecialityPersonal.Name_SpecialityPersonal = @Name_SpecialityPersonal and SpecialityPersonal_Logical_Delete = 0))
THROW 50665, 'Данная специализация уже создана', 1
else if (@id_SpecialityPersonal != (SELECT SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal 
WHERE SpecialityPersonal.Name_SpecialityPersonal = @Name_SpecialityPersonal and SpecialityPersonal_Logical_Delete = 1))
begin
Update [dbo].[SpecialityPersonal]
set
	SpecialityPersonal_Logical_Delete = 0
where
	id_SpecialityPersonal = (SELECT SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal 
WHERE SpecialityPersonal.Name_SpecialityPersonal = @Name_SpecialityPersonal and SpecialityPersonal_Logical_Delete = 1)
	Update [dbo].[SpecialityPersonal]
set
	SpecialityPersonal_Logical_Delete = 1
where
	id_SpecialityPersonal = @id_SpecialityPersonal
end
else
Update [dbo].[SpecialityPersonal]
set
	Name_SpecialityPersonal = @Name_SpecialityPersonal
where
	id_SpecialityPersonal = @id_SpecialityPersonal


create procedure [UPD_WorkSchedule]
@id_WorkSchedule int,
@weekdays varchar (16)
as
if (@id_WorkSchedule != (SELECT WorkSchedule.id_WorkSchedule FROM WorkSchedule WHERE weekdays = @weekdays and WorkSchedule_Logical_Delete = 0))
THROW 50664, 'Данная роль уже существует', 1
else if (@id_WorkSchedule != (SELECT WorkSchedule.id_WorkSchedule FROM WorkSchedule WHERE weekdays = @weekdays and WorkSchedule_Logical_Delete = 1))
begin
Update [dbo].[WorkSchedule]
set
	WorkSchedule_Logical_Delete = 1
where
	id_WorkSchedule = @id_WorkSchedule

Update [dbo].[WorkSchedule]
set
	WorkSchedule_Logical_Delete = 0
where
	id_WorkSchedule = (SELECT WorkSchedule.id_WorkSchedule FROM WorkSchedule WHERE weekdays = @weekdays and WorkSchedule_Logical_Delete = 1)
end
else
Update [dbo].[WorkSchedule]
set
	weekdays = @weekdays
where
	id_WorkSchedule = @id_WorkSchedule


create procedure [logdel_Personal]
@id_worker int
as
Update [dbo].[Personal]
set
	Personal_Logical_Delete = 1
where
id_worker = @id_worker

Update [dbo].[TherapeuticDepartament]
set
	id_worker = null
where
id_worker = @id_worker


create procedure [logdel_Role]
@id_Role int
as
Update [dbo].[Role]
set
	Role_Logical_Delete = 1
where
id_Role = @id_Role
Update [dbo].[Personal]
set
	id_Role = null
where
id_Role = @id_Role

Update [dbo].[TherapeuticDepartament]
set
	id_worker = null
where
TherapeuticDepartament.id_worker IN (SELECT        dbo.Personal.id_worker
FROM            dbo.Personal INNER JOIN
                         dbo.TherapeuticDepartament ON dbo.Personal.id_worker = dbo.TherapeuticDepartament.id_worker
						 where Personal.id_Role = NULL and Personal_Logical_Delete = 0)


create procedure [logdel_SpecialityPersonal]
@id_SpecialityPersonal int
as
Update [dbo].[SpecialityPersonal]
set
	SpecialityPersonal_Logical_Delete = 1
where
id_SpecialityPersonal = @id_SpecialityPersonal

Update [dbo].[Role]
set
	id_SpecialityPersonal = (Select SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal WHERE Name_SpecialityPersonal = 'Неопределенный поьзователь')
where
id_SpecialityPersonal = @id_SpecialityPersonal


Update [dbo].[TherapeuticDepartament]
set
	id_worker = null
where
TherapeuticDepartament.id_worker IN (SELECT dbo.Personal.id_worker
FROM            dbo.Role INNER JOIN
                         dbo.Personal ON dbo.Role.id_Role = dbo.Personal.id_Role INNER JOIN
                         dbo.TherapeuticDepartament ON dbo.Personal.id_worker = dbo.TherapeuticDepartament.id_worker
						 WHERE Role.id_SpecialityPersonal = (Select SpecialityPersonal.id_SpecialityPersonal FROM SpecialityPersonal WHERE Name_SpecialityPersonal = 'Неопределенный поьзователь'))



create procedure [logdel_Storage]
@id_Spot_OLD int,
@id_Spot_New int
as
if (EXISTS(Select DeliveryMedicament.id_DeliveryMedicament From DeliveryMedicament WHERE DeliveryMedicament.id_spot = @id_Spot_New and DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0))
THROW 50564, 'Данныя чейка склада уже используется', 1
Update [dbo].[Storage]
set
	Storage_Logical_Delete = 1
where
id_Spot = @id_Spot_OLD

Update [dbo].[DeliveryMedicament]
set
	id_spot = @id_Spot_New
where
id_Spot = @id_Spot_OLD


create procedure [logdel_WorkSchedule]
@id_WorkSchedule int
as
Update [dbo].[WorkSchedule]
set
	WorkSchedule_Logical_Delete = 1
where
id_WorkSchedule = @id_WorkSchedule

Update [dbo].[Personal]
set
	id_WorkSchedule = null
where
id_WorkSchedule = @id_WorkSchedule


create procedure Search__Personal_For_Admin
@Name_Personal varchar (50)
as
SELECT       Role.id_Role, Personal.id_worker, dbo.Personal.SurnamePers + ' ' + dbo.Personal.NamePers + ' ' + dbo.Personal.PatronymicPers as 'ФИО', 
Convert(varchar,Personal.SeriesPassportPers) + ' ' + Convert(varchar,Personal.NumberPassportPers) as 'Серия и номер', dbo.Role.id_Role as 'Номер роли', dbo.SpecialityPersonal.Name_SpecialityPersonal as 'Специализация'
FROM            dbo.Role INNER JOIN
                         dbo.Personal ON dbo.Role.id_Role = dbo.Personal.id_Role INNER JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal
						 WHERE Personal.Personal_Logical_Delete = 0 and dbo.Personal.NamePers+ ' ' + 
                         dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers LIKE '%' + @Name_Personal + '%' 


create procedure [Search_Role_SpecialityPesonal]
@Name_SpecialityPersonal varchar (50)
as
SELECT        dbo.Role.id_Role as 'Номер роли', dbo.Role.Write as 'Запись', dbo.Role.CardDesign as 'Оформление карт', 
dbo.Role.AcceptanceMedication as 'Приём лекарств',  dbo.Role.ResolutionStatement as 'Выписка пациентов', dbo.Role.AdmissionPatient as 'Приём пациентов', 
                         dbo.SpecialityPersonal.Name_SpecialityPersonal as 'Специализация'
FROM            dbo.Role INNER JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal
						 WHERE Role_Logical_Delete = 0 and SpecialityPersonal.Name_SpecialityPersonal like '%' + @Name_SpecialityPersonal + '%'


create procedure Celect_TypeWrite
as
SELECT TypeWrite.id_TypeWrite, 'Тип записи: ' + dbo.TypeWrite.Name_Write as 'Тип записи'
FROM     dbo.TypeWrite


create procedure Select_DataCitizen_ONLI_FIO
as
SELECT id_Citizen, SurnameCit  + ' ' + NameCit + ' ' + PatronymicCit as 'ФИО'
FROM     dbo.DataCitizen


create procedure Select_DataCitizen
as
SELECT id_Citizen, SurnameCit  + ' ' + NameCit + ' ' + PatronymicCit as 'ФИО', Snils as 'Снилс', 
CONVERT(VARCHAR, SeriesPassportCit) + ' ' + CONVERT(VARCHAR, NumberPassportCit) AS 'Серия и номер', DateBirthCit as 'День рождения'
FROM     dbo.DataCitizen


create procedure Select_Date_Appointment
@Date date
as
Select dbo.Day_of_the_week.id_Day_of_the_week , dbo.Day_of_the_week.Record_Time
FROM  dbo.Day_of_the_week
WHERE dbo.Day_of_the_week.Record_Time not in (SELECT        dbo.Day_of_the_week.Record_Time
FROM            dbo.Day_of_the_week INNER JOIN
                         dbo.WriteAppointment ON dbo.Day_of_the_week.id_Day_of_the_week = dbo.WriteAppointment.id_Day_of_the_week
						 WHERE WriteAppointment.times = @Date and WriteAppointment_Logical_Delete = 0)


create procedure Select_Diagnos_ForPosa
as
SELECT Diagnosis.id_Diagnoz,  dbo.DirectoryDisease.Name_Disease + ' ' +
convert(varchar,dbo.Diagnosis.TimeDisease) +  'дня, ' + dbo.Medicament.Name_Medicament + ' ' +
convert(varchar,dbo.Diagnosis.Amount) + ' штук, ' + dbo.TypeUse.Name_Use + ', пал: №' + convert(varchar,dbo.TherapeuticDepartament.id_Room) as 'Диагнозыыы'
FROM     dbo.Diagnosis INNER JOIN
                  dbo.DirectoryDisease ON dbo.Diagnosis.id_Disease = dbo.DirectoryDisease.id_Disease INNER JOIN
                  dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                  dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room INNER JOIN
                  dbo.CategoriesDisease ON dbo.TherapeuticDepartament.id_CategoriesDisease = dbo.CategoriesDisease.id_CategoriesDisease INNER JOIN
                  dbo.TypeUse ON dbo.Diagnosis.id_TypeUse = dbo.TypeUse.id_TypeUse
WHERE dbo.Diagnosis.Diagnosis_Logical_Delete = 0


create procedure Select_WriteAppointment
as
SELECT dbo.DataCitizen.id_Citizen, dbo.Personal.id_worker, dbo.WriteAppointment.id_WriteAppointment, dbo.FormWrite.id_FormWrite, dbo.Day_of_the_week.id_Day_of_the_week , dbo.DataCitizen.SurnameCit + ' ' + dbo.DataCitizen.NameCit + ' ' + dbo.DataCitizen.PatronymicCit AS 'ФИО', 
                  convert(varchar,dbo.WriteAppointment.times)+ ' ' + dbo.Day_of_the_week.Record_Time AS 'Время записи', dbo.WriteAppointment.visit AS 'Посетил', dbo.WriteAppointment.SentToTreatment AS 'Положили', 
				  dbo.TypeWrite.Name_Write AS 'Тип записи', dbo.Personal.SurnamePers + ' ' + dbo.Personal.NamePers + ' ' + dbo.Personal.PatronymicPers AS 'Регистратор'
FROM            dbo.Day_of_the_week INNER JOIN
                         dbo.DataCitizen INNER JOIN
                         dbo.TypeWrite INNER JOIN
                         dbo.FormWrite ON dbo.TypeWrite.id_TypeWrite = dbo.FormWrite.id_TypeWrite INNER JOIN
                         dbo.WriteAppointment ON dbo.FormWrite.id_FormWrite = dbo.WriteAppointment.id_FormWrite ON dbo.DataCitizen.id_Citizen = dbo.WriteAppointment.id_Citizen ON 
                         dbo.Day_of_the_week.id_Day_of_the_week = dbo.WriteAppointment.id_Day_of_the_week INNER JOIN
                         dbo.Personal ON dbo.FormWrite.id_worker = dbo.Personal.id_worker
						 Where WriteAppointment_Logical_Delete = 0


create procedure [Add_DataCitizen]
@NameCit varchar (50),
@SurnameCit varchar (50),
@PatronymicCit varchar (50),
@Snils varchar (11),
@SeriesPassportCit int,
@NumberPassportCit int,
@DateBirthCit date
as

if ((SELECT 
CASE 
WHEN MONTH(CONVERT(date,@DateBirthCit)) > MONTH(getDate()) THEN DATEDIFF(YEAR,CONVERT(date,@DateBirthCit),getDate())-1 
WHEN MONTH(CONVERT(date,@DateBirthCit)) < MONTH(getDate()) THEN DATEDIFF(YEAR,CONVERT(date,@DateBirthCit),getDate()) 
WHEN MONTH(CONVERT(date,@DateBirthCit)) = MONTH(getDate()) THEN 
CASE 
WHEN DAY(CONVERT(date,@DateBirthCit)) > DAY(getDate()) THEN DATEDIFF(YEAR,CONVERT(date,@DateBirthCit),getDate())-1 
ELSE DATEDIFF(YEAR,CONVERT(date,@DateBirthCit),getDate()) 
END 
END) < 18 )
THROW 50288, 'Возраст добавляемого гражданина меньше 18 лет!', 1
else if (EXISTS(SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.Snils = @Snils and DataCitizen_Logical_Delete = 0))
THROW 50668,  'Гражданин с таким СНИЛС уже зарегистрирован',1 
else if (EXISTS(SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.NumberPassportCit = @NumberPassportCit 
AND DataCitizen.SeriesPassportCit = @SeriesPassportCit and DataCitizen_Logical_Delete = 0))
THROW 50668,  'Гражданин с такими паспортными данными уже зарегистрирован',1 
ELSE if (EXISTS(SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.Snils = @Snils and DataCitizen_Logical_Delete = 1) 
and EXISTS(SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.NumberPassportCit = @NumberPassportCit 
AND DataCitizen.SeriesPassportCit = @SeriesPassportCit and DataCitizen_Logical_Delete = 1))
UPDATE DataCitizen
set
DataCitizen_Logical_Delete = 0,
NameCit = @NameCit ,
SurnameCit = @SurnameCit ,
PatronymicCit = @PatronymicCit,
DateBirthCit = @DateBirthCit
where 
Snils = @Snils
else if((@NameCit not like '%[А-Я]%' or @NameCit not like '%[а-я]%') or @NameCit in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0'))
	THROW 50673,  'Пожалуйста укажите имя только русскими буквами',1 
	else if ((@SurnameCit not like '%[А-Я]%' or @SurnameCit not like '%[а-я]%') or @SurnameCit  in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0'))
	THROW 50674,  'Пожалуйста укажите SurnameCit Only in Russian letters',1 
	else if ((@PatronymicCit not like '%[А-Я]%' or @PatronymicCit not like '%[а-я]%') or @PatronymicCit  in ('!','@','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\','1','2','3','4','5','6','7','8','9','0'))
	THROW 50675,  'Пожалуйста укажите отчество только русскими буквами',1 
	else
insert into [dbo].[DataCitizen] (NameCit,SurnameCit,PatronymicCit,Snils,SeriesPassportCit,NumberPassportCit,DateBirthCit)
values (@NameCit,@SurnameCit,@PatronymicCit,@Snils,@SeriesPassportCit,@NumberPassportCit,@DateBirthCit)


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


create procedure [Add_TypeWrite]
@Name_TypeWrite varchar (50)
as
if (EXISTS(Select TypeWrite.id_TypeWrite FROM TypeWrite WHERE Name_Write = @Name_TypeWrite and TypeWrite_Logical_Delete = 0))
THROW 50669, 'Данный тип записи уже создан', 1
else if (EXISTS(Select TypeWrite.id_TypeWrite FROM TypeWrite WHERE Name_Write = @Name_TypeWrite and TypeWrite_Logical_Delete = 1))
Update TypeWrite
set
TypeWrite_Logical_Delete = 0
where
Name_Write = @Name_TypeWrite
else
insert into [dbo].[TypeWrite] (Name_Write)
values (@Name_TypeWrite)


create procedure [Add_WriteAppointment]
@times date,
@id_Day_of_the_week int,
@id_Citizen int,
@id_FormWrite int
as
if  (@times < cast(getDate() as date) or ( @times = cast(getDate() as date) and cast(getDate() as time) > cast((Select Record_Time
FROM dbo.Day_of_the_week WHERE id_Day_of_the_week = @id_Day_of_the_week)as time)))
THROW 50671, 'Невозможно создать запись на приём задним числом',1 
else if (EXISTS(Select WriteAppointment.id_WriteAppointment FROM WriteAppointment WHERE WriteAppointment_Logical_Delete = 0 and times = @times 
and id_Day_of_the_week = @id_Day_of_the_week and id_Citizen = @id_Citizen and id_FormWrite = @id_FormWrite))
THROW 50672, 'Данный гражданин уже записан', 1

else if (EXISTS(Select WriteAppointment.id_WriteAppointment FROM WriteAppointment WHERE WriteAppointment_Logical_Delete = 1 and times = @times 
and id_Day_of_the_week = @id_Day_of_the_week and id_Citizen = @id_Citizen and id_FormWrite = @id_FormWrite))
Update [dbo].[WriteAppointment]
set
WriteAppointment_Logical_Delete = 0
where
	id_WriteAppointment = (Select WriteAppointment.id_WriteAppointment FROM WriteAppointment WHERE WriteAppointment_Logical_Delete = 1 and times = @times 
and id_Day_of_the_week = @id_Day_of_the_week and id_Citizen = @id_Citizen and id_FormWrite = @id_FormWrite)
else
insert into [dbo].[WriteAppointment] (times,id_Citizen,id_FormWrite, id_Day_of_the_week)
values (@times,@id_Citizen,@id_FormWrite, @id_Day_of_the_week)


create procedure [UPD_DataCitizen]
@id_Citizen int,
@NameCit varchar (50),
@SurnameCit varchar (50),
@PatronymicCit varchar (50),
@Snils varchar (11),
@SeriesPassportCit int,
@NumberPassportCit int,
@DateBirthCit date
as
if ((SELECT 
CASE 
WHEN MONTH(CONVERT(date,@DateBirthCit)) > MONTH(getDate()) THEN DATEDIFF(YEAR,CONVERT(date,@DateBirthCit),getDate())-1 
WHEN MONTH(CONVERT(date,@DateBirthCit)) < MONTH(getDate()) THEN DATEDIFF(YEAR,CONVERT(date,@DateBirthCit),getDate()) 
WHEN MONTH(CONVERT(date,@DateBirthCit)) = MONTH(getDate()) THEN 
CASE 
WHEN DAY(CONVERT(date,@DateBirthCit)) > DAY(getDate()) THEN DATEDIFF(YEAR,CONVERT(date,@DateBirthCit),getDate())-1 
ELSE DATEDIFF(YEAR,CONVERT(date,@DateBirthCit),getDate()) 
END 
END) < 18 )
THROW 50288, 'Возраст добавляемого гражданина меньше 18 лет!', 1
else if (@id_Citizen != (SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.Snils = @Snils and DataCitizen_Logical_Delete = 0) 
and EXISTS(SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.NumberPassportCit = @NumberPassportCit 
AND DataCitizen.SeriesPassportCit = @SeriesPassportCit and DataCitizen_Logical_Delete = 0))
THROW 50668,  'Данный гражданин уже зарегистрирован',1 
ELSE if (@id_Citizen != (SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.Snils = @Snils and DataCitizen_Logical_Delete = 1) 
and EXISTS(SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.NumberPassportCit = @NumberPassportCit 
AND DataCitizen.SeriesPassportCit = @SeriesPassportCit and DataCitizen_Logical_Delete = 1))
begin
UPDATE DataCitizen
set
DataCitizen_Logical_Delete = 0,
NameCit = @NameCit ,
SurnameCit = @SurnameCit ,
PatronymicCit = @PatronymicCit,
DateBirthCit = @DateBirthCit
where 
id_Citizen = (SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.Snils = @Snils and DataCitizen_Logical_Delete = 1) 
and EXISTS(SELECT dbo.DataCitizen.id_Citizen FROM DataCitizen Where DataCitizen.NumberPassportCit = @NumberPassportCit 
AND DataCitizen.SeriesPassportCit = @SeriesPassportCit and DataCitizen_Logical_Delete = 1)
UPDATE DataCitizen
set
DataCitizen_Logical_Delete = 1
where 
id_Citizen = @id_Citizen
end
else
Update [dbo].[DataCitizen]
set
	NameCit = @NameCit,
	SurnameCit = @SurnameCit,
	PatronymicCit = @PatronymicCit,
	Snils = @Snils,
	SeriesPassportCit = @SeriesPassportCit,
	NumberPassportCit = @NumberPassportCit, 
	DateBirthCit = @DateBirthCit
where
	id_Citizen = @id_Citizen


create procedure [UPD_TypeWrite]
@id_TypeWrite int,
@Name_TypeWrite varchar (50),
@TypeWrite_Logical_Delete bit
as
if (EXISTS(Select TypeWrite.id_TypeWrite FROM TypeWrite WHERE Name_Write = @Name_TypeWrite and TypeWrite_Logical_Delete = 0))
THROW 50669, 'Данный тип записи уже создан', 1
else if (@id_TypeWrite != (Select TypeWrite.id_TypeWrite FROM TypeWrite WHERE Name_Write = @Name_TypeWrite and TypeWrite_Logical_Delete = 1))
begin
Update TypeWrite
set
TypeWrite_Logical_Delete = 0
where
Name_Write = (Select TypeWrite.id_TypeWrite FROM TypeWrite WHERE Name_Write = @Name_TypeWrite and TypeWrite_Logical_Delete = 1)
Update TypeWrite
set
TypeWrite_Logical_Delete = 1
where
Name_Write = @Name_TypeWrite
end
else
Update [dbo].[TypeWrite]
set
	Name_Write = @Name_TypeWrite
where
	id_TypeWrite = @id_TypeWrite


create procedure [UPD_WriteAppointment]
@id_WriteAppointment int,
@id_Day_of_the_week int,
@visit bit,
@id_Citizen int,
@SentToTreatment bit,
@times datetime,
@id_FormWrite int
as
if  (@visit = 0)
THROW 50683, 'Невозможно положить того, кто ещё не пришёл',1 
else if (@times < getDate() and convert(varchar,getDate(),108) > (Select Record_Time
FROM dbo.Day_of_the_week WHERE id_Day_of_the_week = @id_Day_of_the_week))
THROW 50671, 'Невозможно создать запись на приём задним числом',1 
else if (@id_WriteAppointment != (Select WriteAppointment.id_WriteAppointment FROM WriteAppointment WHERE WriteAppointment_Logical_Delete = 0 and times = @times 
and id_Day_of_the_week = @id_Day_of_the_week and id_Citizen = @id_Citizen and id_FormWrite = @id_FormWrite))
THROW 50672, 'Данный гражданин уже записан', 1

else if (@id_WriteAppointment != (Select WriteAppointment.id_WriteAppointment FROM WriteAppointment WHERE WriteAppointment_Logical_Delete = 1 and times = @times 
and id_Day_of_the_week = @id_Day_of_the_week and id_Citizen = @id_Citizen and id_FormWrite = @id_FormWrite))
begin
Update [dbo].[WriteAppointment]
set
WriteAppointment_Logical_Delete = 0
where
	id_WriteAppointment = (Select WriteAppointment.id_WriteAppointment FROM WriteAppointment WHERE WriteAppointment_Logical_Delete = 1 and times = @times 
and id_Day_of_the_week = @id_Day_of_the_week and id_Citizen = @id_Citizen and id_FormWrite = @id_FormWrite)
Update [dbo].[WriteAppointment]
set
WriteAppointment_Logical_Delete = 1
where
	id_WriteAppointment = @id_WriteAppointment
end
else
Update [dbo].[WriteAppointment]
set
	id_Day_of_the_week = @id_Day_of_the_week,
	visit = @visit,
	id_Citizen = @id_Citizen,
	id_FormWrite = @id_FormWrite,
	SentToTreatment = @SentToTreatment
where
	id_WriteAppointment = @id_WriteAppointment


create procedure [logdel_DataCitizen]
@id_Citizen int
as
Update [dbo].[DataCitizen]
set
	DataCitizen_Logical_Delete = 1
where
id_Citizen = @id_Citizen
Update [dbo].[WriteAppointment]
set
	WriteAppointment_Logical_Delete = 1
where
id_Citizen = @id_Citizen
if (EXISTS(SELECT        id_WriteAppointment
FROM            dbo.DataCitizen INNER JOIN
                         dbo.WriteAppointment ON dbo.DataCitizen.id_Citizen = dbo.WriteAppointment.id_Citizen
						 where DataCitizen.id_Citizen = @id_Citizen and WriteAppointment.visit = 1 and WriteAppointment.SentToTreatment = 1 and WriteAppointment_Logical_Delete = 0))
begin
Update [dbo].[CardTreatments]
set
	CardTreatments_Logical_Delete = 1
where
id_WriteAppointment in (SELECT        id_WriteAppointment
FROM            dbo.DataCitizen INNER JOIN
                         dbo.WriteAppointment ON dbo.DataCitizen.id_Citizen = dbo.WriteAppointment.id_Citizen
						 where DataCitizen.id_Citizen = @id_Citizen and WriteAppointment_Logical_Delete = 0)
UPDATE Discharge
set
	Discharge_Logical_Delete = 1
where Discharge.id_WriteAppointment IN (SELECT     Discharge.id_Discharge   
FROM            dbo.DataCitizen INNER JOIN
                         dbo.WriteAppointment ON dbo.DataCitizen.id_Citizen = dbo.WriteAppointment.id_Citizen INNER JOIN
                         dbo.Discharge ON dbo.WriteAppointment.id_WriteAppointment = dbo.Discharge.id_WriteAppointment
						 where WriteAppointment_Logical_Delete = 0 and DataCitizen.id_Citizen = @id_Citizen
						 )
end


create procedure [logdel_TypeWrite]
@id_TypeWrite int
as
Update [dbo].[TypeWrite]
set
	TypeWrite_Logical_Delete = 1
where
id_TypeWrite = @id_TypeWrite



create procedure [logdel_WriteAppointment]
@id_WriteAppointment int
as
Update [dbo].[WriteAppointment]
set
	WriteAppointment_Logical_Delete = 1
where
id_WriteAppointment = @id_WriteAppointment
if (EXISTS(Select WriteAppointment.id_WriteAppointment FROM WriteAppointment WHERE WriteAppointment.id_WriteAppointment = @id_WriteAppointment and WriteAppointment.visit = 1 and WriteAppointment.SentToTreatment = 1))
begin
Update [dbo].[CardTreatments]
set
	CardTreatments_Logical_Delete = 1
where
id_WriteAppointment = @id_WriteAppointment
UPDATE Discharge
set
	Discharge_Logical_Delete = 1
where Discharge.id_WriteAppointment IN (Select id_card FROM CardTreatments WHERE CardTreatments.id_WriteAppointment = @id_WriteAppointment)
end


create procedure Search_DataCitizen
@Name_DateCitizen varchar (100)
AS
SELECT id_Citizen, SurnameCit  + ' ' + NameCit + ' ' + PatronymicCit as 'ФИО', Snils as 'Снилс', 
CONVERT(VARCHAR, SeriesPassportCit) + ' ' + CONVERT(VARCHAR, NumberPassportCit) AS 'Серия и номер', DateBirthCit as 'День рождения'
FROM     dbo.DataCitizen
WHERE SurnameCit  + ' ' + NameCit + ' ' + PatronymicCit like '%' + @Name_DateCitizen +'%'


create procedure Search_WriteAppointment
@Name_DateCitizen varchar (100)
as
SELECT dbo.DataCitizen.id_Citizen, dbo.Personal.id_worker, dbo.WriteAppointment.id_WriteAppointment, dbo.FormWrite.id_FormWrite, dbo.DataCitizen.SurnameCit + ' ' + dbo.DataCitizen.NameCit + ' ' + dbo.DataCitizen.PatronymicCit AS 'ФИО', 
                  dbo.WriteAppointment.times AS 'Время записи', dbo.WriteAppointment.visit AS 'Посетил', dbo.WriteAppointment.SentToTreatment AS 'Положили', 
				  dbo.TypeWrite.Name_Write AS 'Тип записи', dbo.Personal.SurnamePers + ' ' + dbo.Personal.NamePers + ' ' + dbo.Personal.PatronymicPers AS 'Регистратор'
FROM     dbo.TypeWrite INNER JOIN
                  dbo.FormWrite ON dbo.TypeWrite.id_TypeWrite = dbo.FormWrite.id_TypeWrite INNER JOIN
                  dbo.WriteAppointment ON dbo.FormWrite.id_FormWrite = dbo.WriteAppointment.id_FormWrite INNER JOIN
                  dbo.DataCitizen ON dbo.WriteAppointment.id_Citizen = dbo.DataCitizen.id_Citizen INNER JOIN
                  dbo.Personal ON dbo.FormWrite.id_worker = dbo.Personal.id_worker
				  where SurnameCit  + ' ' + NameCit + ' ' + PatronymicCit like '%' + @Name_DateCitizen +'%'


create procedure Select_Date_Appointment
@Date date
as
Select dbo.Day_of_the_week.id_Day_of_the_week , dbo.Day_of_the_week.Record_Time
FROM  dbo.Day_of_the_week
WHERE dbo.Day_of_the_week.Record_Time not in (SELECT        dbo.Day_of_the_week.Record_Time
FROM            dbo.Day_of_the_week INNER JOIN
                         dbo.WriteAppointment ON dbo.Day_of_the_week.id_Day_of_the_week = dbo.WriteAppointment.id_Day_of_the_week
						 WHERE WriteAppointment.times = @Date and WriteAppointment_Logical_Delete = 0)


create procedure Cured_All_CardTreatmens
@id_WriteAppointment int
as
Update [dbo].[CardTreatments]
set
	Cured = 1
where
	CardTreatments.id_WriteAppointment = @id_WriteAppointment and CardTreatments_Logical_Delete = 0 and Cured = 0


create procedure Sum_Diagnosis_For_WriteAppointment
@id_WriteAppointment int
as
SELECT Diagnosis.id_Diagnoz, SUM(Diagnosis.Amount)
FROM     dbo.CardTreatments INNER JOIN
                  dbo.Diagnosis ON dbo.CardTreatments.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                  dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment
				  WHERE WriteAppointment.id_WriteAppointment = @id_WriteAppointment and CardTreatments.CardTreatments_Logical_Delete = 0
				  GROUP BY Diagnosis.id_Diagnoz


create procedure [CardTreatments_Diagnoz_Select]
@id_WriteAppointment int
as

SELECT  dbo.CardTreatments.id_card, dbo.CardTreatments.id_WriteAppointment, dbo.CardTreatments.id_Diagnoz, dbo.DirectoryDisease.Name_Disease as 'Название болезни', dbo.Diagnosis.TimeDisease as 'Срок лечения', dbo.Medicament.Name_Medicament as 'Назначаемое лекарство', 
dbo.Diagnosis.Amount as 'Количество', dbo.TypeUse.Name_Use as 'Способ применения', dbo.Diagnosis.ID_Room as 'Номер палаты лечения', dbo.CardTreatments.Cured as 'Состояние'
FROM            dbo.CardTreatments INNER JOIN
                         dbo.Diagnosis ON dbo.CardTreatments.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment INNER JOIN
                         dbo.TypeUse ON dbo.Diagnosis.id_TypeUse = dbo.TypeUse.id_TypeUse INNER JOIN
                         dbo.DirectoryDisease ON dbo.Diagnosis.id_Disease = dbo.DirectoryDisease.id_Disease INNER JOIN
                         dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament
WHERE CardTreatments.id_WriteAppointment = @id_WriteAppointment and CardTreatments.CardTreatments_Logical_Delete = 0


create procedure Select_All_Diagnos
as
SELECT Diagnosis.id_Diagnoz,  dbo.DirectoryDisease.Name_Disease as 'Название болезни', 
dbo.Diagnosis.TimeDisease 'Период лечения (в днях)' , dbo.Medicament.Name_Medicament as 'Название лекарства', 
dbo.Diagnosis.Amount as 'Количество медикаментов' , dbo.TypeUse.Name_Use 'Применение' , dbo.TherapeuticDepartament.id_Room 'Номер палаты', 
                  dbo.CategoriesDisease.Name_CategoriesDisease
FROM     dbo.Diagnosis INNER JOIN
                  dbo.DirectoryDisease ON dbo.Diagnosis.id_Disease = dbo.DirectoryDisease.id_Disease INNER JOIN
                  dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                  dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room INNER JOIN
                  dbo.CategoriesDisease ON dbo.TherapeuticDepartament.id_CategoriesDisease = dbo.CategoriesDisease.id_CategoriesDisease INNER JOIN
                  dbo.TypeUse ON dbo.Diagnosis.id_TypeUse = dbo.TypeUse.id_TypeUse
WHERE dbo.Diagnosis.Diagnosis_Logical_Delete = 0


create procedure [dbo].[Select_CardTreatments]
as
SELECT  dbo.DataCitizen.id_Citizen, dbo.CardTreatments.id_WriteAppointment, dbo.DataCitizen.NameCit + ' ' + dbo.DataCitizen.SurnameCit+ ' ' + dbo.DataCitizen.PatronymicCit as 'ФИО', dbo.DataCitizen.Snils AS 'СНИЛС', 
COUNT(CASE
    WHEN dbo.CardTreatments.CardTreatments_Logical_Delete = 0 THEN 1
    ELSE NULL
END) as 'Количество диагнозов',
ISNULL(dbo.WriteAppointment.MedicalDepartament, 0) AS 'Палата лечения', ISNULL(WriteAppointment.СategoriesDisease, 'Пациенту не назначен активный диагноз') as 'Категория болезни'
FROM   dbo.CardTreatments INNER JOIN
                         dbo.Diagnosis ON dbo.CardTreatments.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment INNER JOIN
                         dbo.DataCitizen ON dbo.WriteAppointment.id_Citizen = dbo.DataCitizen.id_Citizen
				  
WHERE dbo.WriteAppointment.visit = 1 and dbo.WriteAppointment.SentToTreatment = 1  and WriteAppointment_Logical_Delete = 0
GROUP BY dbo.CardTreatments.id_WriteAppointment,dbo.DataCitizen.NameCit, dbo.DataCitizen.SurnameCit, dbo.DataCitizen.PatronymicCit, dbo.DataCitizen.Snils,
 dbo.WriteAppointment.MedicalDepartament, WriteAppointment.СategoriesDisease


create procedure [dbo].[Select_Discharge]
@ID_WriteAppointment int
as
SELECT Discharge.id_Discharge, dbo.DataCitizen.NameCit + ' ' + dbo.DataCitizen.SurnameCit + ' ' + dbo.DataCitizen.PatronymicCit as 'ФИО' , 
dbo.DataCitizen.Snils as 'Снилс', dbo.TypeDischarge.NameDischarge as 'Тип выписки', dbo.Discharge.DateDischarge as 'Дата выписки'
FROM     dbo.Discharge INNER JOIN
                         dbo.TypeDischarge ON dbo.Discharge.id_TypeDischarge = dbo.TypeDischarge.id_TypeDischarge INNER JOIN
                         dbo.WriteAppointment ON dbo.Discharge.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment INNER JOIN
                         dbo.DataCitizen ON dbo.WriteAppointment.id_Citizen = dbo.DataCitizen.id_Citizen
WHERE dbo.WriteAppointment.id_WriteAppointment = @ID_WriteAppointment and Discharge.Discharge_Logical_Delete = 0


create procedure [dbo].[Select_Id_Departament]
as
SELECT dbo.TherapeuticDepartament.id_Room, '№'+CONVERT(varchar, dbo.TherapeuticDepartament.id_Room) + ' свободных мест: ' + CONVERT(varchar,dbo.TherapeuticDepartament.BusyRoom) as 'Терапевтическое отделение'
FROM dbo.TherapeuticDepartament
WHERE dbo.TherapeuticDepartament.amountRooms != dbo.TherapeuticDepartament.BusyRoom and dbo.TherapeuticDepartament.TherapeuticDepartament_Logical_Delete = 0


create procedure Select_Medicament
as
SELECT dbo.Medicament.id_Medicament, dbo.Medicament.Name_Medicament + ' на складе: ' + CONVERT(varchar, Storage.occupiedSpace) As 'Лекарство'
FROM dbo.DeliveryMedicament
JOIN dbo.Medicament ON dbo.DeliveryMedicament.id_DeliveryMedicament = dbo.Medicament.id_Medicament
JOIN Storage ON dbo.DeliveryMedicament.id_DeliveryMedicament = Storage.id_spot
WHERE dbo.Medicament.Medicament_Logical_Delete = 0
exec Select_Medicament


create procedure Select_Name_Disease
as
SELECT DirectoryDisease.id_Disease, dbo.DirectoryDisease.Name_Disease
FROM  dbo.DirectoryDisease 
WHERE dbo.DirectoryDisease.DirectoryDisease_Logical_Delete = 0


create procedure [dbo].[Select_TypeDischarge_Name_NameDischarge]
as
SELECT TypeDischarge.id_TypeDischarge, dbo.TypeDischarge.NameDischarge
FROM dbo.TypeDischarge
WHERE dbo.TypeDischarge.TypeDischarge_Logical_Delete = 0


create procedure [dbo].[Select_TypeUse]
as
SELECT TypeUse.id_TypeUse, TypeUse.Name_Use FROM TypeUse
WHERE TypeUse.TypeUse_Logical_Delete = 0


create procedure [dbo].[Add_CardTreatments]
@id_WriteAppointment int,
@id_Diagnoz int,
@Name_SpecialityPersonal varchar(50)
as
DECLARE @id_CardTreatments int
DECLARE @id_WriteAppointment_Old int

if (@Name_SpecialityPersonal != (SELECT        dbo.SpecialityPersonal.Name_SpecialityPersonal
FROM            dbo.Role INNER JOIN
                         dbo.Personal ON dbo.Role.id_Role = dbo.Personal.id_Role INNER JOIN
                         dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal INNER JOIN
                         dbo.TherapeuticDepartament ON dbo.Personal.id_worker = dbo.TherapeuticDepartament.id_worker INNER JOIN
                         dbo.Diagnosis ON dbo.TherapeuticDepartament.id_Room = dbo.Diagnosis.ID_Room
						 where Diagnosis.id_Diagnoz = @id_Diagnoz) and @Name_SpecialityPersonal != 'Главный врач')
						 THROW 50660, 'Данный диагноз находится вне вашей компитенции или на отделение не назначен заведующий', 1
else if (EXISTS(Select CardTreatments.id_card FROM CardTreatments WHERE CardTreatments.id_Diagnoz = @id_Diagnoz and 
CardTreatments.id_WriteAppointment = @id_WriteAppointment and CardTreatments.Cured = 0 and CardTreatments_Logical_Delete = 0))
THROW 50256, 'Данные диагноз уже назначен и в процессе лечения',1
else if ((Select Diagnosis.ID_Room FROM Diagnosis WHERE Diagnosis.id_Diagnoz = @id_Diagnoz ) !=
(Select Diagnosis.ID_Room FROM CardTreatments JOIN dbo.Diagnosis ON dbo.CardTreatments.id_Diagnoz = dbo.Diagnosis.id_Diagnoz
WHERE CardTreatments.Cured = 0 and CardTreatments.id_WriteAppointment = @id_WriteAppointment and  CardTreatments_Logical_Delete = 0) )
THROW 50257, 'На данный момент пациент лечится в другой палате',1
else if (EXISTS(Select CardTreatments.id_card FROM CardTreatments WHERE CardTreatments.id_Diagnoz = @id_Diagnoz and 
CardTreatments.id_WriteAppointment = @id_WriteAppointment and CardTreatments.Cured = 0 and CardTreatments_Logical_Delete = 1))
begin
SET @id_CardTreatments = (Select CardTreatments.id_card FROM CardTreatments WHERE CardTreatments.id_Diagnoz = @id_Diagnoz and 
CardTreatments.id_WriteAppointment = @id_WriteAppointment  and CardTreatments.Cured = 0 and CardTreatments_Logical_Delete = 1)
Update [dbo].[CardTreatments]
set
	CardTreatments_Logical_Delete = 0
where
ID_card = @id_CardTreatments
end
else
Update [dbo].[WriteAppointment]
set
	MedicalDepartament = (Select Diagnosis.ID_Room FROM Diagnosis WHERE Diagnosis.id_Diagnoz = @id_Diagnoz),
	СategoriesDisease = (Select dbo.CategoriesDisease.Name_CategoriesDisease FROM Diagnosis JOIN TherapeuticDepartament ON Diagnosis.ID_Room = TherapeuticDepartament.id_Room
	JOIN CategoriesDisease ON TherapeuticDepartament.id_Room = CategoriesDisease.id_CategoriesDisease 
	Where Diagnosis.id_Diagnoz = @id_Diagnoz)
where
id_WriteAppointment = @id_WriteAppointment
insert into [dbo].[CardTreatments] (id_WriteAppointment,Cured,id_Diagnoz)
values (@id_WriteAppointment,0,@id_Diagnoz)



create procedure [dbo].[Add_Diagnosis]
@TimeDisease int,
@Amount int,
@ID_Room int,
@id_TypeUse int,
@id_Medicament int,
@id_Disease int
as
DECLARE @id_Diagnosis int
if (EXISTS(Select Diagnosis.id_Diagnoz FROM [dbo].[Diagnosis] WHERE TimeDisease = @TimeDisease and Amount = @Amount 
and ID_Room = @ID_Room and id_TypeUse = @id_TypeUse and id_Medicament = @id_Medicament and id_Disease = @id_Disease and Diagnosis_Logical_Delete = 1))
begin
set @id_Diagnosis = (Select Diagnosis.id_Diagnoz FROM [dbo].[Diagnosis] WHERE TimeDisease = @TimeDisease and Amount = @Amount 
and ID_Room = @ID_Room and id_TypeUse = @id_TypeUse and id_Medicament = @id_Medicament and id_Disease = @id_Disease) 
exec UPD_Diagnosis @id_Diagnosis, @TimeDisease,@Amount,@ID_Room,@id_TypeUse,@id_Medicament,@id_Disease, 0
end
else if (EXISTS(Select Diagnosis.id_Diagnoz FROM [dbo].[Diagnosis] WHERE TimeDisease = @TimeDisease and Amount = @Amount 
and ID_Room = @ID_Room and id_TypeUse = @id_TypeUse and id_Medicament = @id_Medicament and id_Disease = @id_Disease and Diagnosis_Logical_Delete = 0))
THROW 50255, 'Данный диагноз уже существует',1
else
insert into [dbo].[Diagnosis] (TimeDisease,Amount,ID_Room,id_TypeUse,id_Medicament,id_Disease)
values (@TimeDisease,@Amount,@ID_Room,@id_TypeUse,@id_Medicament,@id_Disease)


create procedure [Add_DirectoryDisease]
@Name_Disease varchar (50)
as
DECLARE @id_DirectoryDisease int
if (EXISTS(Select DirectoryDisease.id_Disease FROM DirectoryDisease WHERE DirectoryDisease.Name_Disease = @Name_Disease and DirectoryDisease.DirectoryDisease_Logical_Delete = 1))
begin
set  @id_DirectoryDisease = (Select DirectoryDisease.id_Disease FROM DirectoryDisease WHERE DirectoryDisease.Name_Disease = @Name_Disease and DirectoryDisease_Logical_Delete = 1) 
Update DirectoryDisease
set
DirectoryDisease_Logical_Delete = 0
where 
DirectoryDisease.Name_Disease = @Name_Disease
end
else if (EXISTS(Select DirectoryDisease.id_Disease FROM DirectoryDisease WHERE DirectoryDisease.Name_Disease = @Name_Disease and DirectoryDisease.DirectoryDisease_Logical_Delete = 0))
THROW 50254, 'Данное название болезни уже существует',1
else
insert into [dbo].[DirectoryDisease] (Name_Disease)
values (@Name_Disease)


create procedure [dbo].[Add_Discharge]
@DateDischarge varchar (10),
@id_WriteAppointment int,
@id_TypeDischarge int
as
if (@id_TypeDischarge = (SELECT TypeDischarge.id_TypeDischarge FROM TypeDischarge WHERE TypeDischarge.NameDischarge = 'Полная медицинская выписка') 
and EXISTS(SELECT dbo.Discharge.id_Discharge FROM Discharge JOIN TypeDischarge ON Discharge.id_Discharge = TypeDischarge.id_TypeDischarge WHERE 
TypeDischarge.id_TypeDischarge = @id_TypeDischarge and Discharge.id_WriteAppointment = @id_WriteAppointment and Discharge.Discharge_Logical_Delete = 1))
UPDATE Discharge
set
Discharge_Logical_Delete = 0
else if ('Полная медицинская выписка' IN (SELECT   TypeDischarge.NameDischarge
FROM            dbo.CardTreatments INNER JOIN
                         dbo.Discharge ON dbo.CardTreatments.id_WriteAppointment = dbo.Discharge.id_WriteAppointment INNER JOIN
                         dbo.TypeDischarge ON dbo.Discharge.id_TypeDischarge = dbo.TypeDischarge.id_TypeDischarge INNER JOIN
                         dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment
WHERE WriteAppointment.id_WriteAppointment = 1 and CardTreatments.CardTreatments_Logical_Delete = 0))
THROW 50253, 'Данный пациент уже выписан',1
else if ((SELECT TypeDischarge.NameDischarge   
FROM            dbo.Discharge INNER JOIN
                         dbo.TypeDischarge ON dbo.Discharge.id_TypeDischarge = dbo.TypeDischarge.id_TypeDischarge) ='Полная медицинская выписка' and EXISTS(SELECT CardTreatments.id_card       
FROM            dbo.CardTreatments INNER JOIN
                         dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment
WHERE WriteAppointment.id_WriteAppointment = @id_WriteAppointment and CardTreatments.CardTreatments_Logical_Delete = 0 and Cured = 0))
THROW 50678, 'У данного пациента ещё имеются невылеченные диагнозы',1
else
insert into [dbo].[Discharge] (DateDischarge,id_WriteAppointment,id_TypeDischarge)
values (@DateDischarge,@id_WriteAppointment,@id_TypeDischarge)


CREATE procedure [Add_TypeDischarge]
@NameDischarge varchar (50)
as
DECLARE @id_TypeDischarge int
if (EXISTS(Select TypeDischarge.NameDischarge FROM TypeDischarge WHERE TypeDischarge.NameDischarge = @NameDischarge and TypeDischarge.TypeDischarge_Logical_Delete = 1))
begin
set @id_TypeDischarge = (Select TypeDischarge.id_TypeDischarge FROM TypeDischarge WHERE TypeDischarge.NameDischarge = @NameDischarge) 
exec UPD_TypeDischarge @id_TypeDischarge, @NameDischarge, 0
end
else if (EXISTS(Select TypeDischarge.NameDischarge FROM TypeDischarge WHERE TypeDischarge.NameDischarge = @NameDischarge and TypeDischarge.TypeDischarge_Logical_Delete = 0))
THROW 50251, 'Данный тип выписки уже существует',1
else
insert into [dbo].[TypeDischarge] (NameDischarge)
values (@NameDischarge)


create procedure [Add_TypeUse]
@NameUse varchar (50)
as
DECLARE @id_TypeUse int
if (EXISTS(Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse and TypeUse.TypeUse_Logical_Delete = 1))
begin
set @id_TypeUse = (Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse) 
UPDATE TypeUse
SET
TypeUse_Logical_Delete = 0
where
id_TypeUse = id_TypeUse
end
else if (EXISTS(Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse and TypeUse.TypeUse_Logical_Delete = 0))
THROW 50252, 'Данный тип приёма медикаментов уже существует',1
else
insert into [dbo].[TypeUse] (Name_Use)
values (@NameUse)


create procedure [dbo].[UPD_CardTreatments]
@id_WriteAppointment int,
@id_Diagnoz int,
@Cured bit
as
DECLARE @id_card int
SET @id_card = (Select CardTreatments.id_card FROM CardTreatments WHERE CardTreatments.id_Diagnoz = @id_Diagnoz and 
CardTreatments.id_WriteAppointment = @id_WriteAppointment and CardTreatments.Cured = 0 and CardTreatments_Logical_Delete = 0)
Update [dbo].[CardTreatments]
set
	Cured = @Cured
where
ID_card = @ID_card

if (EXISTS(Select CardTreatments.id_card FROM CardTreatments WHERE CardTreatments.id_WriteAppointment = @id_WriteAppointment and CardTreatments.Cured = 0 and CardTreatments.CardTreatments_Logical_Delete = 0))
Update [dbo].[WriteAppointment]
set
	MedicalDepartament = NULL,
	СategoriesDisease = NULL
where
id_WriteAppointment = @id_WriteAppointment


create procedure [UPD_Diagnosis]
@id_Diagnoz int,
@TimeDisease int,
@Amount int,
@ID_Room int,
@id_TypeUse int,
@id_Medicament int,
@id_Disease int,
@Diagnosis_Logical_Deletebit bit
as
if (@id_Diagnoz != (Select Diagnosis.id_Diagnoz FROM [dbo].[Diagnosis] WHERE TimeDisease = @TimeDisease and Amount = @Amount 
and ID_Room = @ID_Room and id_TypeUse = @id_TypeUse and id_Medicament = @id_Medicament and id_Disease = @id_Disease and Diagnosis_Logical_Delete = 0))
THROW 50255, 'Данный диагноз уже существует',1
else if (@id_Diagnoz != (Select Diagnosis.id_Diagnoz FROM [dbo].[Diagnosis] WHERE TimeDisease = @TimeDisease and Amount = @Amount 
and ID_Room = @ID_Room and id_TypeUse = @id_TypeUse and id_Medicament = @id_Medicament and id_Disease = @id_Disease and Diagnosis_Logical_Delete = 1))
begin
Update [dbo].[Diagnosis]
set
	Diagnosis_Logical_Delete = 0
where
	id_Diagnoz = (Select Diagnosis.id_Diagnoz FROM [dbo].[Diagnosis] WHERE TimeDisease = @TimeDisease and Amount = @Amount 
and ID_Room = @ID_Room and id_TypeUse = @id_TypeUse and id_Medicament = @id_Medicament and id_Disease = @id_Disease and Diagnosis_Logical_Delete = 1)
Update [dbo].[Diagnosis]
set
	Diagnosis_Logical_Delete = 1
where
	id_Diagnoz = @id_Diagnoz
	end
	else
Update [dbo].[Diagnosis]
set
	TimeDisease= @TimeDisease,
	Amount = @Amount,
	id_Medicament = @id_Medicament,
	ID_Room = @ID_Room, 
	id_TypeUse = @id_TypeUse,
	id_Disease = @id_Disease,
	Diagnosis_Logical_Delete = @Diagnosis_Logical_Deletebit
	
where
	id_Diagnoz = @id_Diagnoz



create procedure [UPD_DirectoryDisease]
@id_Disease int,
@Name_Disease varchar (50)
as
if (@id_Disease != (Select DirectoryDisease.id_Disease FROM DirectoryDisease WHERE DirectoryDisease.Name_Disease = @Name_Disease and DirectoryDisease.DirectoryDisease_Logical_Delete = 0))
THROW 50254, 'Данное название болезни уже существует',1
else if (@id_Disease != (Select DirectoryDisease.id_Disease FROM DirectoryDisease WHERE DirectoryDisease.Name_Disease = @Name_Disease and DirectoryDisease.DirectoryDisease_Logical_Delete = 1))
begin
Update [dbo].[DirectoryDisease]
set
	DirectoryDisease_Logical_Delete = 0

where
	id_Disease = (Select DirectoryDisease.id_Disease FROM DirectoryDisease WHERE DirectoryDisease.Name_Disease = @Name_Disease and DirectoryDisease.DirectoryDisease_Logical_Delete = 1)
	Update [dbo].[DirectoryDisease]
set
	DirectoryDisease_Logical_Delete = 1

where
	id_Disease = @id_Disease
	end
	else 
Update [dbo].[DirectoryDisease]
set
	Name_Disease = @Name_Disease
where
	id_Disease = @id_Disease


create procedure [UPD_TypeDischarge]
@id_TypeDischarge int,
@NameDischarge varchar (50),
@TypeDischarge_Logical_Delete bit
as
if (@id_TypeDischarge != (Select TypeDischarge.NameDischarge FROM TypeDischarge WHERE TypeDischarge.NameDischarge = @NameDischarge and TypeDischarge.TypeDischarge_Logical_Delete = 0))
THROW 50251, 'Данный тип выписки уже существует',1
else if (@id_TypeDischarge != (Select TypeDischarge.NameDischarge FROM TypeDischarge WHERE TypeDischarge.NameDischarge = @NameDischarge and TypeDischarge.TypeDischarge_Logical_Delete = 1))
begin
Update [dbo].[TypeDischarge]
set
	TypeDischarge_Logical_Delete = 0

where
	id_TypeDischarge = (Select TypeDischarge.NameDischarge FROM TypeDischarge WHERE TypeDischarge.NameDischarge = @NameDischarge and TypeDischarge.TypeDischarge_Logical_Delete = 1)
	Update [dbo].[TypeDischarge]
set
	TypeDischarge_Logical_Delete = 1

where
	id_TypeDischarge = @id_TypeDischarge
	end
else
Update [dbo].[TypeDischarge]
set
	NameDischarge = @NameDischarge
where
	id_TypeDischarge = @id_TypeDischarge



create procedure [UPD_TypeUse]
@id_TypeUse int,
@NameUse varchar (50)
as
if (@id_TypeUse != (Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse and TypeUse.TypeUse_Logical_Delete = 0))
THROW 50252, 'Данный тип приёма медикаментов уже существует',1
else if (@id_TypeUse != (Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse and TypeUse.TypeUse_Logical_Delete = 1))
begin
Update [dbo].[TypeUse]
set
	TypeUse_Logical_Delete = 0
where
	id_TypeUse = (Select TypeUse.id_TypeUse FROM TypeUse WHERE TypeUse.Name_Use =  @NameUse and TypeUse.TypeUse_Logical_Delete = 1)
	Update [dbo].[TypeUse]
set
	TypeUse_Logical_Delete = 1
where
	id_TypeUse = @id_TypeUse
	end
	else
Update [dbo].[TypeUse]
set
	Name_Use = @NameUse
where
	id_TypeUse = @id_TypeUse


create procedure [logdel_CardTreatments]
@id_card int,
@Amount_Use int
as 
declare @id_WriteAppointment INT
SET @id_WriteAppointment = (Select CardTreatments.id_WriteAppointment FROM CardTreatments  WHERE CardTreatments.id_card = @id_card and CardTreatments.CardTreatments_Logical_Delete = 0 and CardTreatments.Cured = 0)
if (EXISTS(Select id_card FROM CardTreatments  WHERE CardTreatments.id_card = @id_card and CardTreatments.CardTreatments_Logical_Delete = 0 and CardTreatments.Cured = 0))
begin
if (@Amount_Use > (SELECT  Diagnosis.Amount FROM dbo.CardTreatments INNER JOIN
dbo.Diagnosis ON dbo.CardTreatments.id_Diagnoz = dbo.Diagnosis.id_Diagnoz
WHERE CardTreatments.id_card = @id_card))
THROW 50563, 'Использовано больше лекарств, чем положено', 1
Update [dbo].[Storage]
set
	occupiedSpace += ((Select Diagnosis.Amount FROM CardTreatments JOIN Diagnosis ON CardTreatments.id_Diagnoz = Diagnosis.id_Diagnoz WHERE CardTreatments.id_card = @id_card) - @Amount_Use)
where
id_spot = (SELECT    DISTINCT    Storage.id_spot
FROM           dbo.CardTreatments INNER JOIN
                         dbo.Diagnosis ON dbo.CardTreatments.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.DeliveryMedicament ON dbo.Medicament.id_Medicament = dbo.DeliveryMedicament.id_Medicament INNER JOIN
                         dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
						 WHERE CardTreatments.id_card = @id_card)
						 end
Update [dbo].[CardTreatments]
set
	CardTreatments_Logical_Delete = 1
where
id_card = @id_card

if (EXISTS(Select CardTreatments.id_card FROM CardTreatments WHERE CardTreatments.id_WriteAppointment = @id_WriteAppointment and CardTreatments.Cured = 0 and CardTreatments.CardTreatments_Logical_Delete = 0))
Update [dbo].[WriteAppointment]
set
	MedicalDepartament = NULL,
	СategoriesDisease = NULL
where
id_WriteAppointment = @id_WriteAppointment




create procedure [logdel_Diagnosis]
@id_Diagnoz int
as
Update [dbo].[Diagnosis]
set
	Diagnosis_Logical_Delete = 1
where
id_Diagnoz = @id_Diagnoz


create procedure [logdel_DirectoryDisease]
@id_Disease int
as
Update [dbo].[DirectoryDisease]
set
	DirectoryDisease_Logical_Delete = 1
where
id_Disease = @id_Disease



create procedure [logdel_DirectoryDisease]
@id_Disease int
as
Update [dbo].[DirectoryDisease]
set
	DirectoryDisease_Logical_Delete = 1
where
id_Disease = @id_Disease
update Diagnosis
set
Diagnosis_Logical_Delete = 1
where 
Diagnosis.id_Disease = @id_Disease


create procedure [logdel_Discharge]
@id_Discharge int
as
Update [dbo].[Discharge]
set
	Discharge_Logical_Delete = 1
where
id_Discharge = @id_Discharge


create procedure [logdel_TypeDischarge]
@id_TypeDischarge int
as
Update [dbo].[TypeDischarge]
set
	TypeDischarge_Logical_Delete = 1
where
id_TypeDischarge = @id_TypeDischarge


create procedure [logdel_TypeUse]
@id_TypeUse int
as
Update [dbo].[TypeUse]
set
	TypeUse_Logical_Delete = 1
where
id_TypeUse = @id_TypeUse
Update [dbo].[Diagnosis]
set
	id_TypeUse = null
where
id_TypeUse = @id_TypeUse


create procedure [logdel_WriteAppointment]
@id_WriteAppointment int
as
Update [dbo].[WriteAppointment]
set
	WriteAppointment_Logical_Delete = 1
where
id_WriteAppointment = @id_WriteAppointment
if (EXISTS(Select WriteAppointment.id_WriteAppointment FROM WriteAppointment WHERE WriteAppointment.id_WriteAppointment = @id_WriteAppointment and WriteAppointment.visit = 1 and WriteAppointment.SentToTreatment = 1))
begin
Update [dbo].[CardTreatments]
set
	CardTreatments_Logical_Delete = 1
where
id_WriteAppointment = @id_WriteAppointment
UPDATE Discharge
set
	Discharge_Logical_Delete = 1
where Discharge.id_WriteAppointment IN (Select id_card FROM CardTreatments WHERE CardTreatments.id_WriteAppointment = @id_WriteAppointment)
end


create procedure [dbo].[Search_CardTreatments]
@Snils varchar(11)
as
SELECT  dbo.CardTreatments.id_WriteAppointment, dbo.DataCitizen.NameCit + ' ' + dbo.DataCitizen.SurnameCit+ ' ' + dbo.DataCitizen.PatronymicCit as 'ФИО', dbo.DataCitizen.Snils AS 'СНИЛС', COUNT(CASE
    WHEN dbo.CardTreatments.CardTreatments_Logical_Delete = 0 THEN 1
    ELSE NULL
END) as 'Количество диагнозов',
 ISNULL(dbo.WriteAppointment.MedicalDepartament, 0) AS 'Палата лечения', ISNULL(WriteAppointment.СategoriesDisease, 'Пациенту не назначен активный диагноз') as 'Категория болезни'
FROM   dbo.CardTreatments INNER JOIN
                         dbo.Diagnosis ON dbo.CardTreatments.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment INNER JOIN
                         dbo.DataCitizen ON dbo.WriteAppointment.id_Citizen = dbo.DataCitizen.id_Citizen
				  
WHERE dbo.WriteAppointment.visit = 1 and dbo.WriteAppointment.SentToTreatment = 1 and dbo.DataCitizen.Snils like '%' + @Snils + '%' and WriteAppointment.WriteAppointment_Logical_Delete = 0
GROUP BY dbo.CardTreatments.id_WriteAppointment,dbo.DataCitizen.NameCit, dbo.DataCitizen.SurnameCit, dbo.DataCitizen.PatronymicCit, dbo.DataCitizen.Snils,
 dbo.WriteAppointment.MedicalDepartament, WriteAppointment.СategoriesDisease

create procedure Select_Diagnos_For_Name_Disease
@Name_Disease varchar (50)
as
Select dbo.DirectoryDisease.Name_Disease as 'Название болезни', dbo.Diagnosis.TimeDisease as 'Срок лечения', dbo.Medicament.Name_Medicament as 'Назначаемое лекарство', dbo.Diagnosis.Amount as 'Количество', dbo.TypeUse.Name_Use as 'Способ применения', dbo.Diagnosis.ID_Room as 'Номер палаты лечения'
FROM dbo.Diagnosis INNER JOIN
dbo.DirectoryDisease ON dbo.Diagnosis.id_Disease = dbo.DirectoryDisease.id_Disease INNER JOIN
dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
dbo.TypeUse ON dbo.Diagnosis.id_TypeUse = dbo.TypeUse.id_TypeUse
WHERE dbo.DirectoryDisease.Name_Disease like '%' + @Name_Disease + '%' and Diagnosis.Diagnosis_Logical_Delete = 0



Create FUNCTION Answer_ZeroAmount_CardTreatments
 (@id_WriteAppointment int)
RETURNS bit
AS
 BEGIN
  DECLARE @Amswer_Amount int
  if (EXISTS(SELECT *
FROM dbo.CardTreatments INNER JOIN
dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment
WHERE WriteAppointment.id_WriteAppointment = @id_WriteAppointment  and CardTreatments.Cured  = 0 and CardTreatments.CardTreatments_Logical_Delete = 0 
and WriteAppointment.WriteAppointment_Logical_Delete = 0))
Return (1)
Return (0)
 END


create procedure [SELECT_Regulation]
@User_Nick varchar (50)
as
SELECT        
dbo.Regulation.id_Regulation, 
dbo.Regulation.TextRegulation
FROM            
	dbo.Personal INNER JOIN
	dbo.Role ON dbo.Personal.id_Role = dbo.Role.id_Role INNER JOIN
	dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal INNER JOIN
	dbo.Regulation ON dbo.SpecialityPersonal.id_SpecialityPersonal = dbo.Regulation.id_SpecialityPersonal
where Personal.User_Nick = @User_Nick and Regulation_Logical_Delete = 0



create procedure [dbo].[SELECT_Profile_Personal]
@User_Nick varchar (50)
as
SELECT        
	dbo.Personal.NamePers, 
	dbo.Personal.SurnamePers, 
	dbo.Personal.PatronymicPers, 
	dbo.Personal.SeriesPassportPers, 
	dbo.Personal.NumberPassportPers, 
	dbo.Personal.id_worker, 
	dbo.Personal.User_Nick, 
	isnull(WorkSchedule.weekdays,'Не назначен') as 'График', 
	dbo.SpecialityPersonal.Name_SpecialityPersonal
FROM           
	dbo.Personal INNER JOIN
	dbo.Role ON dbo.Personal.id_Role = dbo.Role.id_Role INNER JOIN
	dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal LEFT JOIN
	dbo.WorkSchedule ON dbo.Personal.id_WorkSchedule = dbo.WorkSchedule.id_WorkSchedule
WHERE Personal.User_Nick = @User_Nick


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


create procedure [UPD_Personal]
@SeriesPassportPers int,
@NumberPassportPers int,
@User_Pass varchar (18),
@New_User_Pass varchar (18)
as
OPEN SYMMETRIC KEY SSN_Key_01
   DECRYPTION BY CERTIFICATE cert1;
   if ( (convert(char,DecryptByKey((Select Personal.User_Pass 
   FROM Personal WHERE Personal.SeriesPassportPers = @SeriesPassportPers and Personal.NumberPassportPers = @NumberPassportPers and Personal_Logical_Delete = 0)))) != @User_Pass)
   THROW 50562, 'Старый пароль не верный', 1
   else
Update [dbo].[Personal]
set
	User_Pass = EncryptByKey(Key_GUID('SSN_Key_01'),convert(varbinary (max),@New_User_Pass))
where
	id_worker = (SELECT Personal.id_worker FROM Personal WHERE Personal.SeriesPassportPers = @SeriesPassportPers and Personal.NumberPassportPers = @NumberPassportPers and Personal_Logical_Delete = 0)


create procedure [dbo].[Select_CategoryOfMedicament]
as
SELECT CategoryOfMedicament.id_CategoryOfMedicament, CategoryOfMedicament.Name_MedCategory FROM CategoryOfMedicament
WHERE CategoryOfMedicament.CategoryOfMedicament_Logical_Delete = 0


create procedure [dbo].[Select_DeliveryMedicament]
as
SELECT dbo.DeliveryMedicament.id_DeliveryMedicament, DeliveryMedicament.id_spot, Medicament.id_Medicament, dbo.Medicament.Name_Medicament as 'Лекарство', dbo.DeliveryMedicament.Amount as 'Количество', 
dbo.DeliveryMedicament.DateOfDelivery 'Дата поставки', dbo.Personal.NamePers + ' ' + dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers as 'Принял поставку'
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.Personal ON dbo.DeliveryMedicament.id_worker = dbo.Personal.id_worker
						 where DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0


create procedure [dbo].[Select_Manufacturer]
as
SELECT Manufacturer.id_Manufacturer, Manufacturer.Name_Manufacturer FROM Manufacturer
WHERE Manufacturer.Manufacturer_Logical_Delete = 0


create procedure Select_Medicament_FOR_Storage
as
SELECT DISTINCT   
	dbo.Medicament.id_Medicament, 
	Storage.id_spot as 'Ячейка склада' , 
	dbo.Medicament.Name_Medicament as 'Название',
	dbo.CategoryOfMedicament.Name_MedCategory as 'Категория',
	dbo.Storage.occupiedSpace as 'Количество в наличии', 
	ISNULL(dbo.Manufacturer.Name_Manufacturer, 'Производитель не назначен') as 'Производитель', 
	dbo.Manufacturer.Adress as 'Адрес отправки', dbo.Manufacturer.Mail as 'Mail компании'
FROM           
	dbo.CategoryOfMedicament INNER JOIN
	dbo.Medicament ON dbo.CategoryOfMedicament.id_CategoryOfMedicament = dbo.Medicament.id_CategoryOfMedicament INNER JOIN
	dbo.DeliveryMedicament ON dbo.Medicament.id_Medicament = dbo.DeliveryMedicament.id_Medicament INNER JOIN
	dbo.Manufacturer ON dbo.Medicament.id_Manufacturer = dbo.Manufacturer.id_Manufacturer INNER JOIN
	dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
WHERE dbo.Medicament.Medicament_Logical_Delete = 0


create procedure [dbo].[Select_Medicament]
as
SELECT  dbo.Medicament.id_Medicament, dbo.Medicament.Name_Medicament
FROM            dbo.Medicament 
WHERE dbo.Medicament.Medicament_Logical_Delete = 0


create procedure [dbo].[Select_Storage_Id]
as
SELECT Storage.id_spot, '№' + convert(varchar,Storage.id_spot) + '  мест: ' + CONVERT(VARCHAR,(Storage.Amount - Storage.occupiedSpace)) as 'Ячейка склада' From Storage
WHERE Storage.Storage_Logical_Delete = 0



create procedure [dbo].[Add_DeliveryMedicament]
@Amount int,
@DateOfDelivery varchar (10),
@id_Medicament int,
@id_worker int,
@id_spot int
as
declare @lol varchar (100)
SET @lol = 'Данный медикамент, назначен на другую ячейку склада: ' + convert(varchar,(SELECT        dbo.Storage.id_spot
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
						 WHere Storage_Logical_Delete = 0 and DeliveryMedicament_Logical_Delete = 0 and Medicament.id_Medicament = @id_Medicament))
if (EXISTS(SELECT    DISTINCT    DeliveryMedicament.id_spot
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament
						 WHERE Medicament.Medicament_Logical_Delete = 0 and DeliveryMedicament.id_spot = @id_spot) 
						 and @id_Medicament NOT IN (SELECT    DISTINCT    DeliveryMedicament.id_Medicament
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament
						 WHERE Medicament.Medicament_Logical_Delete = 0 and DeliveryMedicament.id_spot = @id_spot))
THROW 50260, 'Данная ячейка склада занята другим лекарством', 1
else if (EXISTS(SELECT        dbo.Storage.id_spot
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
						 WHere Storage_Logical_Delete = 0 and DeliveryMedicament_Logical_Delete = 0 and Medicament.id_Medicament = @id_Medicament)
						 and @id_spot NOT IN (SELECT    DISTINCT    DeliveryMedicament.id_spot
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament
						 WHERE Medicament.Medicament_Logical_Delete = 0 and DeliveryMedicament.id_Medicament = @id_Medicament and DeliveryMedicament_Logical_Delete = 0))
						 THROW 50681, @lol ,1
else if (DATEDIFF (DAY,@DateOfDelivery,getDate())!=0)
THROW 50261, 'Дата поставки не совпадает с сегоднешней ', 1
else if ((SELECT dbo.Storage.Amount
FROM  dbo.Storage where Storage.id_spot = @id_spot) - (SELECT dbo.Storage.occupiedSpace
FROM  dbo.Storage where Storage.id_spot = @id_spot) < @Amount)
				  throw 50565 , 'Количество медикаментов превышает допустимый размер ячейки',1
				  else
insert into [dbo].[DeliveryMedicament] (Amount,DateOfDelivery,id_Medicament,id_worker,id_spot)
values (@Amount,@DateOfDelivery,@id_Medicament,@id_worker,@id_spot)



create procedure [Add_Manufacturer]
@Name_Manufacturer varchar (100),
@Adress varchar (100),
@Mail varchar (50)
as
if (EXISTS(Select Manufacturer.id_Manufacturer FROM Manufacturer WHERE Name_Manufacturer = @Name_Manufacturer and Adress = @Adress and Mail = @Mail
 and Manufacturer_Logical_Delete = 0 ))
THROW 50259, 'Данный производитель уже существует',1
else if (EXISTS(Select Manufacturer.id_Manufacturer FROM Manufacturer WHERE Name_Manufacturer = @Name_Manufacturer and Adress = @Adress and Mail = @Mail
 and Manufacturer_Logical_Delete = 1 ))
Update [dbo].[Manufacturer]
set
	Manufacturer_Logical_Delete = 0
where
	id_Manufacturer = (Select Manufacturer.id_Manufacturer FROM Manufacturer WHERE Name_Manufacturer = @Name_Manufacturer and Adress = @Adress and Mail = @Mail
 and Manufacturer_Logical_Delete = 1 )
 else if(@Mail not like '%@%.%' and @Mail  in ('!','#','$','%','^','&','*','(',')','_','-','=','+',
	'"','№',';',':','?','{','}','[',']','<','>','/','\'))
	THROW 50676, 'Пожалуйста кажите почту в таком формате pochta@mail.ru',1
	else
insert into [dbo].[Manufacturer] (Name_Manufacturer,Adress,Mail)
values (@Name_Manufacturer,@Adress,@Mail)



create procedure [Add_Medicament]
@Name_Medicament varchar (100),
@id_Manufacturer int,
@id_CategoryOfMedicament int
as
if (EXISTS(Select Medicament.id_Medicament FROM Medicament WHERE Medicament.Name_Medicament = @Name_Medicament and Medicament.id_Manufacturer = @id_Manufacturer 
and Medicament.id_CategoryOfMedicament = @id_CategoryOfMedicament and Medicament.Medicament_Logical_Delete = 0 ))
THROW 50258, 'Данное лекарство уже существует',1
else if (EXISTS(Select Medicament.id_Medicament FROM Medicament WHERE Medicament.Name_Medicament = @Name_Medicament and Medicament.id_Manufacturer = @id_Manufacturer 
and Medicament.id_CategoryOfMedicament = @id_CategoryOfMedicament and Medicament.Medicament_Logical_Delete = 1 ))
Update [dbo].[Medicament]
set
	Medicament_Logical_Delete = 0
where
	id_Medicament = (Select Medicament.id_Medicament FROM Medicament WHERE Medicament.Name_Medicament = @Name_Medicament and Medicament.id_Manufacturer = @id_Manufacturer 
and Medicament.id_CategoryOfMedicament = @id_CategoryOfMedicament and Medicament.Medicament_Logical_Delete = 1 )
else
insert into [dbo].[Medicament] (Name_Medicament,id_Manufacturer,id_CategoryOfMedicament)
values (@Name_Medicament,@id_Manufacturer,@id_CategoryOfMedicament)


create procedure [Add_Storage]
@Amount int
as
insert into [dbo].[Storage] (Amount)
values (@Amount)


create procedure [UPD_DeliveryMedicament]
@id_DeliveryMedicament int,
@Amount int,
@DateOfDelivery varchar (10),
@id_Medicament int,
@id_worker int,
@id_spot int
as
if (DATEDIFF (DAY,@DateOfDelivery,getDate()) != 0)
THROW 50659, 'Невозможно изменить поставку передним или задним числом',1
else if (EXISTS(SELECT    DISTINCT    DeliveryMedicament.id_spot
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament
						 WHERE Medicament.Medicament_Logical_Delete = 0 and DeliveryMedicament.id_Medicament = @id_Medicament) 
						 and @id_spot NOT IN (SELECT    DISTINCT    DeliveryMedicament.id_spot
FROM            dbo.DeliveryMedicament INNER JOIN
                         dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament
						 WHERE Medicament.Medicament_Logical_Delete = 0 and DeliveryMedicament.id_Medicament = @id_Medicament))
THROW 50260, 'Данная ячейка склада занята другим лекарством', 1
else if ((SELECT dbo.Storage.Amount
FROM  dbo.Storage where Storage.id_spot = @id_spot) - (SELECT dbo.Storage.occupiedSpace
FROM  dbo.Storage where Storage.id_spot = @id_spot) < @Amount)
				  throw 50565 , 'Количество медикаментов превышает допустимый размер ячейки',1
				  else
Update [dbo].[DeliveryMedicament]
set
	Amount = @Amount,
	DateOfDelivery = @DateOfDelivery,
	id_Medicament = @id_Medicament,
	id_worker =@id_worker, 
	id_spot = @id_spot
where
	id_DeliveryMedicament = @id_DeliveryMedicament


create procedure [UPD_Manufacturer]
@id_Manufacturer int,
@Name_Manufacturer varchar (100),
@Adress varchar (100),
@Mail varchar (50)
as
IF( @id_Manufacturer != (Select Manufacturer.id_Manufacturer From Manufacturer WHERE Name_Manufacturer = @Name_Manufacturer and Adress =@Adress and Mail = @Mail and Manufacturer_Logical_Delete = 0))
THROW 50661, 'Данный производитель уже существует', 1
else if ( @id_Manufacturer != (Select Manufacturer.id_Manufacturer From Manufacturer WHERE Name_Manufacturer = @Name_Manufacturer and Adress =@Adress and Mail = @Mail and Manufacturer_Logical_Delete = 1))
begin
Update [dbo].[Manufacturer]
set
 Manufacturer_Logical_Delete = 0
where
	id_Manufacturer = (Select Manufacturer.id_Manufacturer From Manufacturer WHERE Name_Manufacturer = @Name_Manufacturer and Adress =@Adress and Mail = @Mail and Manufacturer_Logical_Delete = 1)
	Update [dbo].[Manufacturer]
set
 Manufacturer_Logical_Delete = 1
where
	id_Manufacturer = @id_Manufacturer
	end
	else
Update [dbo].[Manufacturer]
set
	Name_Manufacturer = @Name_Manufacturer,
	Adress = @Adress,
	mail = @mail
where
	id_Manufacturer = @id_Manufacturer


create procedure [UPD_Medicament]
@id_Medicament int,
@Name_Medicament varchar (100),
@id_Manufacturer int,
@id_CategoryOfMedicament int
as
if (@id_Medicament != (Select Medicament.id_Medicament FROM Medicament WHERE Medicament.Name_Medicament = @Name_Medicament and Medicament.id_Manufacturer = @id_Manufacturer 
and Medicament.id_CategoryOfMedicament = @id_CategoryOfMedicament and Medicament.Medicament_Logical_Delete = 0))
THROW 50657, 'Данный медикамент уже создан',1
else if (@id_Medicament != (Select Medicament.id_Medicament FROM Medicament WHERE Medicament.Name_Medicament = @Name_Medicament and Medicament.id_Manufacturer = @id_Manufacturer 
and Medicament.id_CategoryOfMedicament = @id_CategoryOfMedicament and Medicament.Medicament_Logical_Delete = 1))
begin
Update [dbo].[Medicament]
set
Medicament_Logical_Delete = 0
where
	id_Medicament = (Select Medicament.id_Medicament FROM Medicament WHERE Medicament.Name_Medicament = @Name_Medicament and Medicament.id_Manufacturer = @id_Manufacturer 
and Medicament.id_CategoryOfMedicament = @id_CategoryOfMedicament and Medicament.Medicament_Logical_Delete = 1)
	Update [dbo].[Medicament]
set
Medicament_Logical_Delete = 1
where
	id_Medicament = @id_Medicament
	end
	else
Update [dbo].[Medicament]
set
	Name_Medicament = @Name_Medicament,
	id_Manufacturer = @id_Manufacturer,
	id_CategoryOfMedicament = @id_CategoryOfMedicament
where
	id_Medicament = @id_Medicament
					

create procedure [UPD_Storage]
@id_Spot int,
@Amount int
as
if ( @Amount < (Select Storage.occupiedSpace FROM Storage WHERE Storage.Storage_Logical_Delete = 0 and Storage.id_spot = @id_Spot))
THROW 50565, 'Количество медикаментов превышает допустимый размер ячейки', 1 
Update [dbo].[Storage]
set
	Amount = @Amount
where
	id_Spot = @id_Spot



create procedure [logdel_DeliveryMedicament]
@id_DeliveryMedicament int,
@id_Medicament int,
@Amount_Use int
as
if ( @Amount_Use > (
SELECT DISTINCT dbo.Storage.occupiedSpace
FROM            
	dbo.DeliveryMedicament INNER JOIN
	dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
	dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
WHERE DeliveryMedicament.id_Medicament = @id_Medicament and Medicament.Medicament_Logical_Delete = 0))
THROW 50656,' На данный момент на складе отсутствует данное количество лекарственных средств',1
Update [dbo].[Storage]
set
	occupiedSpace -= @Amount_Use
where
id_spot = (SELECT DISTINCT dbo.Storage.id_spot
FROM            
	dbo.DeliveryMedicament INNER JOIN
	dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
	dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
WHERE DeliveryMedicament.id_Medicament = @id_Medicament and Medicament.Medicament_Logical_Delete = 0)
Update [dbo].[DeliveryMedicament]
set
	DeliveryMedicament_Logical_Delete = 1
where
id_DeliveryMedicament = @id_DeliveryMedicament



create procedure [logdel_Manufacturer]
@id_Manufacturer int
as
Update [dbo].[Manufacturer]
set
	Manufacturer_Logical_Delete = 1
where
id_Manufacturer = @id_Manufacturer
Update [dbo].[Medicament]
set
	id_Manufacturer = null
where
id_Manufacturer = @id_Manufacturer



create procedure [logdel_Medicament]
@id_Medicament int
as
Update [dbo].[Storage]
set
	occupiedSpace = 0
where
id_Spot = (SELECT DISTINCT DeliveryMedicament.id_spot
FROM 
	dbo.DeliveryMedicament INNER JOIN
	dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament
WHERE Medicament.id_Medicament = @id_Medicament and Medicament.Medicament_Logical_Delete = 0 and DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0
)
Update [dbo].[Medicament]
set
	Medicament_Logical_Delete = 1
where
id_Medicament = @id_Medicament



create procedure [logdel_Storage_If_AmountZero]
@id_Spot int
as
Update [dbo].[Storage]
set
	Storage_Logical_Delete = 1
where
id_Spot = @id_Spot


create procedure [logdel_Storage]
@id_Spot_OLD int,
@id_Spot_New int
as
if (EXISTS(Select DeliveryMedicament.id_DeliveryMedicament From DeliveryMedicament WHERE DeliveryMedicament.id_spot = @id_Spot_New and DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0))
THROW 50564, 'Данныя чейка склада уже используется', 1
Update [dbo].[Storage]
set
	Storage_Logical_Delete = 1
where
id_Spot = @id_Spot_OLD

Update [dbo].[DeliveryMedicament]
set
	id_spot = @id_Spot_New
where
id_Spot = @id_Spot_OLD



create Procedure Search_DeliveryMedicamen
@Date_DeliveryMedicament varchar(10)
as
SELECT 
	dbo.DeliveryMedicament.id_DeliveryMedicament, 
	Medicament.id_Medicament, 
	dbo.Medicament.Name_Medicament as 'Лекарство', 
	dbo.DeliveryMedicament.Amount as 'Количество', 
	dbo.DeliveryMedicament.DateOfDelivery 'Дата поставки', 
	dbo.Personal.NamePers + ' ' + dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers as 'Принял поставку'
FROM            
	dbo.DeliveryMedicament INNER JOIN
	dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
	dbo.Personal ON dbo.DeliveryMedicament.id_worker = dbo.Personal.id_worker
where DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0 and DeliveryMedicament.DateOfDelivery like '%' + @Date_DeliveryMedicament + '%' 




create Procedure Search_Medicament
@Name_Medicament varchar(50)
as
SELECT DISTINCT   
	dbo.Medicament.id_Medicament, 
	Storage.id_spot as 'Ячейка склада' , 
	dbo.Medicament.Name_Medicament as 'Название', 
	dbo.CategoryOfMedicament.Name_MedCategory as 'Категория',
	dbo.Storage.occupiedSpace as 'Количество в наличии', 
	ISNULL(dbo.Manufacturer.Name_Manufacturer, 'Производитель не назначен') as 'Производитель', 
	dbo.Manufacturer.Adress as 'Адрес отправки', dbo.Manufacturer.Mail as 'Mail компании'
FROM           
	dbo.CategoryOfMedicament INNER JOIN
	dbo.Medicament ON dbo.CategoryOfMedicament.id_CategoryOfMedicament = dbo.Medicament.id_CategoryOfMedicament INNER JOIN
	dbo.DeliveryMedicament ON dbo.Medicament.id_Medicament = dbo.DeliveryMedicament.id_Medicament INNER JOIN
	dbo.Manufacturer ON dbo.Medicament.id_Manufacturer = dbo.Manufacturer.id_Manufacturer INNER JOIN
	dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
WHERE dbo.Medicament.Medicament_Logical_Delete = 0 and Medicament.Name_Medicament like '%' + @Name_Medicament + '%' 



create function Answer_Select_Active_Storage
(@id_Storage int)
returns bit
as
BEGIN
if (EXISTS(SELECT     DISTINCT      dbo.Storage.id_spot
FROM            
dbo.DeliveryMedicament INNER JOIN
dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
WHERE dbo.Medicament.Medicament_Logical_Delete = 0 and Storage.id_spot = @id_Storage and DeliveryMedicament_Logical_Delete = 0))
return (1)
return (0)
END


create procedure Select_CategoriesDisease
as
SELECT CategoriesDisease.id_CategoriesDisease,  Name_CategoriesDisease
FROM            dbo.CategoriesDisease
WHERE CategoriesDisease.CategoriesDisease_Logical_Delete = 0



create procedure Select_Personal_Like_Category
as
SELECT         
	dbo.Personal.id_worker, 
	dbo.Personal.NamePers+ ' ' + dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers as 'Сотрудник',  
	dbo.SpecialityPersonal.Name_SpecialityPersonal as 'Специализация'
FROM            
	dbo.Personal INNER JOIN
	dbo.Role ON dbo.Personal.id_Role = dbo.Role.id_Role INNER JOIN
	dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal
WHERE SpecialityPersonal.Name_SpecialityPersonal not LIKE 'Админ' 
	and SpecialityPersonal.Name_SpecialityPersonal not LIKE 'Подсобный рабочий'
	and SpecialityPersonal.Name_SpecialityPersonal not LIKE 'Регистратор'
	and SpecialityPersonal.Name_SpecialityPersonal not LIKE 'Неопределенный пользователь' and
	Personal_Logical_Delete = 0



create procedure Select_TherapeuticDepartament
as
SELECT        
	dbo.TherapeuticDepartament.id_Room as 'Номер отделения', 
	dbo.TherapeuticDepartament.amountRooms as 'Всего мест', 
	dbo.TherapeuticDepartament.BusyRoom as 'Занято мест', 
	dbo.CategoriesDisease.Name_CategoriesDisease as 'Категория болезни', 
	dbo.Personal.NamePers+ ' ' + dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers as 'Заведующий',  
	dbo.SpecialityPersonal.Name_SpecialityPersonal as 'Специализация'
FROM            
	dbo.Role INNER JOIN
	dbo.Personal ON dbo.Role.id_Role = dbo.Personal.id_Role INNER JOIN
	dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal INNER JOIN
	dbo.TherapeuticDepartament ON dbo.Personal.id_worker = dbo.TherapeuticDepartament.id_worker INNER JOIN
	dbo.CategoriesDisease ON dbo.TherapeuticDepartament.id_CategoriesDisease = dbo.CategoriesDisease.id_CategoriesDisease
WHERE TherapeuticDepartament.TherapeuticDepartament_Logical_Delete = 0



create procedure [Add_CategoriesDisease]
@Name_CategoriesDisease varchar (50)
as
if (EXISTS(SELECT CategoriesDisease.id_CategoriesDisease FROM CategoriesDisease WHERE Name_CategoriesDisease = @Name_CategoriesDisease and CategoriesDisease_Logical_Delete = 0))
THROW 50662, 'Данная категория уже существует', 1
else if (EXISTS(SELECT CategoriesDisease.id_CategoriesDisease FROM CategoriesDisease WHERE Name_CategoriesDisease = @Name_CategoriesDisease and CategoriesDisease_Logical_Delete = 1))
UPDATE CategoriesDisease
set
	CategoriesDisease_Logical_Delete = 0
where
CategoriesDisease.Name_CategoriesDisease = @Name_CategoriesDisease
else
insert into [dbo].[CategoriesDisease] (Name_CategoriesDisease)
values (@Name_CategoriesDisease)


create procedure [Add_TherapeuticDepartament]
@amountRooms int,
@id_worker int,
@id_CategoriesDisease int
as
insert into [dbo].[TherapeuticDepartament] (amountRooms,id_worker,id_CategoriesDisease)
values (@amountRooms,@id_worker,@id_CategoriesDisease)



create procedure [UPD_CategoriesDisease]
@id_CategoriesDisease int,
@Name_CategoriesDisease varchar (50)
as
DECLARE @Answer int
SET @Answer = (Select dbo.Answer_UPD_Unique(@id_CategoriesDisease,@Name_CategoriesDisease))
if ( @Answer =  0)
THROW 50662, 'Данная категория уже существует', 1
else if (@Answer = 1)
begin
Update [dbo].[CategoriesDisease]
set
	CategoriesDisease_Logical_Delete = 0
where
ID_CategoriesDisease = (SELECT CategoriesDisease.id_CategoriesDisease FROM CategoriesDisease WHERE CategoriesDisease.Name_CategoriesDisease = @Name_CategoriesDisease and CategoriesDisease_Logical_Delete = 1)
Update [dbo].[CategoriesDisease]
set
	CategoriesDisease_Logical_Delete = 1
where
ID_CategoriesDisease = @ID_CategoriesDisease
end
else
Update [dbo].[CategoriesDisease]
set
	Name_CategoriesDisease = @Name_CategoriesDisease
where
ID_CategoriesDisease = @ID_CategoriesDisease



create procedure [UPD_TherapeuticDepartament]
@id_Room int,
@amountRooms int,
@id_worker int,
@id_CategoriesDisease int
as
DECLARE @Answer_UPD_TherapeuticDepartament_Amount bit
SET @Answer_UPD_TherapeuticDepartament_Amount = (select dbo.Answer_UPD_TherapeuticDepartament_Amount (@id_Room,@amountRooms))
if (@Answer_UPD_TherapeuticDepartament_Amount = 0)
THROW 50663, 'Количество мест не может быть меньше количества занятых', 1
else
Update [dbo].[TherapeuticDepartament]
set
	amountRooms = @amountRooms,
	id_worker = @id_worker,
	id_CategoriesDisease = @id_CategoriesDisease
where
	id_Room = @id_Room



create FUNCTION Answer_UPD_TherapeuticDepartament_Amount(@id_Room int, @amountRooms int)
RETURNS bit
AS
BEGIN
IF (@amountRooms < (Select TherapeuticDepartament.BusyRoom FROM TherapeuticDepartament Where id_Room = @id_Room))
Return (0)
Return (1)
END



create FUNCTION Answer_UPD_Unique(@id_CategoriesDisease int, @Name_CategoriesDisease varchar(50))
RETURNS int
AS
BEGIN
IF (EXISTS(SELECT CategoriesDisease.id_CategoriesDisease FROM CategoriesDisease WHERE CategoriesDisease.Name_CategoriesDisease = @Name_CategoriesDisease and CategoriesDisease_Logical_Delete = 0)
and @id_CategoriesDisease != (SELECT CategoriesDisease.id_CategoriesDisease FROM CategoriesDisease WHERE CategoriesDisease.Name_CategoriesDisease = @Name_CategoriesDisease and CategoriesDisease_Logical_Delete = 0))
Return (0)
else IF (EXISTS(SELECT CategoriesDisease.id_CategoriesDisease FROM CategoriesDisease WHERE CategoriesDisease.Name_CategoriesDisease = @Name_CategoriesDisease and CategoriesDisease_Logical_Delete = 1)
and @id_CategoriesDisease != (SELECT CategoriesDisease.id_CategoriesDisease FROM CategoriesDisease WHERE CategoriesDisease.Name_CategoriesDisease = @Name_CategoriesDisease and CategoriesDisease_Logical_Delete = 1))
Return (1)
Return (2)
END


create procedure [logdel_CategoriesDisease]
@id_CategoriesDisease int
as
Update [dbo].[CategoriesDisease]
set
	CategoriesDisease_Logical_Delete = 1
where
id_CategoriesDisease = @id_CategoriesDisease


create procedure [logdel_TherapeuticDepartament]
@id_Room int
as
Update [dbo].[TherapeuticDepartament]
set
	TherapeuticDepartament_Logical_Delete = 1
where
id_Room = @id_Room

Update [dbo].[Diagnosis]
set
	Diagnosis_Logical_Delete = 1
where
id_Room = @id_Room


use Life_of_Bionic
go

create procedure Select_Personal_Like_Category
@Name_Personal varchar (50)
as
SELECT         
	dbo.Personal.id_worker, 
	dbo.Personal.NamePers+ ' ' + dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers as 'Сотрудник',  
	dbo.SpecialityPersonal.Name_SpecialityPersonal as 'Специализация'
FROM            
	dbo.Personal INNER JOIN
	dbo.Role ON dbo.Personal.id_Role = dbo.Role.id_Role INNER JOIN
	dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal
WHERE SpecialityPersonal.Name_SpecialityPersonal not LIKE 'Админ' 
	and SpecialityPersonal.Name_SpecialityPersonal not LIKE 'Подсобный рабочий'
	and SpecialityPersonal.Name_SpecialityPersonal not LIKE 'Регистратор'
	and SpecialityPersonal.Name_SpecialityPersonal not LIKE 'Неопределенный поьзователь' and
	Personal_Logical_Delete = 0 and dbo.Personal.NamePers+ ' ' + dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers LIKE '%' + @Name_Personal + '%' 


create procedure Search_TherapeuticDepartament
@id_Room int
as
SELECT        
	dbo.TherapeuticDepartament.id_Room as 'Номер отделения', 
	dbo.TherapeuticDepartament.amountRooms as 'Всего мест', 
	dbo.TherapeuticDepartament.BusyRoom as 'Занято мест', 
	dbo.CategoriesDisease.Name_CategoriesDisease as 'Категория болезни', 
	dbo.Personal.NamePers+ ' ' + dbo.Personal.SurnamePers + ' ' + dbo.Personal.PatronymicPers as 'Заведующий',  
	dbo.SpecialityPersonal.Name_SpecialityPersonal as 'Специализация'
FROM            
	dbo.Role INNER JOIN
	dbo.Personal ON dbo.Role.id_Role = dbo.Personal.id_Role INNER JOIN
	dbo.SpecialityPersonal ON dbo.Role.id_SpecialityPersonal = dbo.SpecialityPersonal.id_SpecialityPersonal INNER JOIN
	dbo.TherapeuticDepartament ON dbo.Personal.id_worker = dbo.TherapeuticDepartament.id_worker INNER JOIN
	dbo.CategoriesDisease ON dbo.TherapeuticDepartament.id_CategoriesDisease = dbo.CategoriesDisease.id_CategoriesDisease
WHERE TherapeuticDepartament.TherapeuticDepartament_Logical_Delete = 0 and TherapeuticDepartament.id_Room = @id_Room


--ТРИГЕРЫ

alter TRIGGER InsertOnPalateNewCitizen ON [dbo].[CardTreatments] 
AFTER INSERT
as 
if ((Select TherapeuticDepartament.BusyRoom FROM inserted INNER JOIN
	dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
	dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room
where Diagnosis.id_Diagnoz = inserted.id_Diagnoz) + 1 > ((Select TherapeuticDepartament.amountRooms FROM inserted INNER JOIN
	dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
	dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room
where Diagnosis.id_Diagnoz = inserted.id_Diagnoz)))
THROW 50679, 'Палата переполненна',1 		 
else if ((SELECT     DISTINCT   dbo.Storage.occupiedSpace
FROM inserted INNER JOIN
	dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
	dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
	dbo.DeliveryMedicament ON dbo.Medicament.id_Medicament = dbo.DeliveryMedicament.id_Medicament INNER JOIN
	dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
where DiagnosiS.id_Diagnoz = inserted.id_Diagnoz and DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0 and Storage_Logical_Delete = 0)  < 
(sELECT Diagnosis.Amount FROM inserted INNER JOIN
dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz WHERE Diagnosis.id_Diagnoz = inserted.id_Diagnoz))
THROW 50680, 'На складе недостаточно лекарств',1
else
update dbo.Storage
set 
occupiedSpace -= (sELECT Diagnosis.Amount FROM        inserted INNER JOIN
dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz WHERE Diagnosis.id_Diagnoz = inserted.id_Diagnoz)
where
id_spot = (SELECT     DISTINCT   dbo.Storage.id_spot
FROM inserted INNER JOIN
	dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
	dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
	dbo.DeliveryMedicament ON dbo.Medicament.id_Medicament = dbo.DeliveryMedicament.id_Medicament INNER JOIN
	dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
where DiagnosiS.id_Diagnoz = inserted.id_Diagnoz and DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0 and Storage_Logical_Delete = 0)
update dbo.TherapeuticDepartament 
set 
BusyRoom += 1 
where id_Room = (Select TherapeuticDepartament.id_Room FROM inserted INNER JOIN
	dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
	dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room
where Diagnosis.id_Diagnoz = inserted.id_Diagnoz)


Create TRIGGER Tovar_INSERT ON dbo.DeliveryMedicament 
FOR INSERT
AS 
update dbo.Storage set 
occupiedSpace += (Select inserted.amount FROM inserted)
where id_spot = (Select inserted.id_spot FROM inserted)



Create TRIGGER Tovar_UPDATE ON dbo.DeliveryMedicament 
FOR UPDATE
AS 
update dbo.Storage set 
occupiedSpace += ((Select inserted.amount FROM inserted) - (Select deleted.amount FROM deleted))
where id_spot = (Select inserted.id_spot FROM inserted)



Create TRIGGER UpdateOnPalateNewCitizen ON [dbo].[CardTreatments] 
AFTER UPDATE
as 
if ((0 in (Select deleted.Cured FROM deleted where deleted.CardTreatments_Logical_Delete = 0) and 1 in (Select inserted.Cured FROM inserted where inserted.CardTreatments_Logical_Delete = 0))
or (0 in (Select deleted.CardTreatments_Logical_Delete FROM deleted where deleted.Cured = 0) and 1 in (Select inserted.CardTreatments_Logical_Delete FROM inserted where inserted.Cured = 0)))
update dbo.TherapeuticDepartament 
set 
BusyRoom -= 1 
where id_Room in (Select TherapeuticDepartament.id_Room FROM inserted INNER JOIN
	dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
	dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room
where Diagnosis.id_Diagnoz = inserted.id_Diagnoz)
else if ((1 in (Select deleted.CardTreatments_Logical_Delete FROM deleted where Cured = 0) and 0 in (Select inserted.CardTreatments_Logical_Delete FROM inserted where  Cured = 0)))
update dbo.TherapeuticDepartament 
set 
BusyRoom += 1 
where id_Room in (Select TherapeuticDepartament.id_Room FROM inserted INNER JOIN
	dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
	dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room
where Diagnosis.id_Diagnoz = inserted.id_Diagnoz)




Create view [dbo].[DischargeOnSchool] as
SELECT     
Distinct   
	[dbo].Discharge.id_Discharge as 'Номер выписки',
	[dbo].TypeDischarge.NameDischarge as 'Наименование выписки',  
	[dbo].DataCitizen.SurnameCit +' ' + dbo.DataCitizen.NameCit + ' ' +dbo.DataCitizen.PatronymicCit as 'ФИО пациента',
	[dbo].DataCitizen.DateBirthCit as 'Дата рождения', 
	[dbo].DirectoryDisease.Name_Disease as 'Болезнь', 
	[dbo].Diagnosis.TimeDisease as 'Срок лечения',
	[dbo].CardTreatments.Cured as 'Статус лечения',
	[dbo].WriteAppointment.times as 'Дата поступления', 
	[dbo].Discharge.DateDischarge as 'Дата выписки'
FROM 
	dbo.DataCitizen INNER JOIN
	dbo.TypeDischarge INNER JOIN
	dbo.Discharge ON dbo.TypeDischarge.id_TypeDischarge = dbo.Discharge.id_TypeDischarge INNER JOIN
	dbo.DirectoryDisease INNER JOIN
	dbo.Diagnosis ON dbo.DirectoryDisease.id_Disease = dbo.Diagnosis.id_Disease INNER JOIN
	dbo.CardTreatments ON dbo.Diagnosis.id_Diagnoz = dbo.CardTreatments.id_Diagnoz INNER JOIN
	dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment ON dbo.Discharge.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment ON 
	dbo.DataCitizen.id_Citizen = dbo.WriteAppointment.id_Citizen INNER JOIN
	dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room INNER JOIN
	dbo.Personal ON dbo.TherapeuticDepartament.id_worker = dbo.Personal.id_worker
where
NameDischarge = 'В учебное заведение' and Discharge.Discharge_Logical_Delete = 0


create VIEW [dbo].[Talon]
AS
SELECT        
	dbo.WriteAppointment.id_WriteAppointment AS [Номер талона], 
	dbo.DataCitizen.SurnameCit + dbo.DataCitizen.NameCit + dbo.DataCitizen.PatronymicCit AS [ФИО пациента], 
	dbo.DataCitizen.Snils AS Снилс, 
	dbo.FormWrite.Adress AS Адрес, dbo.FormWrite.Sites AS Сайт, dbo.FormWrite.PhoneNumber AS [Номер телефона], dbo.FormWrite.mail AS [Почтовый ящик], 
	dbo.WriteAppointment.visit AS [Было ли посещение], 
	convert(varchar, dbo.WriteAppointment.times) + ' ' + dbo.Day_of_the_week.Record_Time as 'Дата записи'
FROM            
	dbo.DataCitizen INNER JOIN
	dbo.WriteAppointment ON dbo.DataCitizen.id_Citizen = dbo.WriteAppointment.id_Citizen INNER JOIN
	dbo.FormWrite ON dbo.WriteAppointment.id_FormWrite = dbo.FormWrite.id_FormWrite INNER JOIN
	dbo.Day_of_the_week ON dbo.WriteAppointment.id_Day_of_the_week = dbo.Day_of_the_week.id_Day_of_the_week		 



CREATE view [dbo].[StorageStatus] as
SELECT     
Distinct   
	dbo.Storage.id_spot as 'Номер ячейки склада', 
	dbo.Medicament.Name_Medicament as 'Название медикамента', 
	dbo.Storage.Amount as 'Общее количество места', 
	dbo.Storage.occupiedSpace as 'Занято места'
FROM            
	dbo.DeliveryMedicament INNER JOIN
	dbo.Medicament ON dbo.DeliveryMedicament.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
	dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot		
where dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot and dbo.Medicament.Medicament_Logical_Delete = 0



CREATE view [dbo].[DocumentForDeliveryMEdicament] as
SELECT     
	dbo.DeliveryMedicament.id_DeliveryMedicament as 'Номер поставки',
	dbo.Manufacturer.Name_Manufacturer as 'Производитель',
	dbo.Medicament.Name_Medicament as 'Наименование лекарства',   
	dbo.CategoryOfMedicament.Name_MedCategory as 'Категория лекарства',
	dbo.DeliveryMedicament.Amount as 'Поступившее количество', 
	dbo.DeliveryMedicament.DateOfDelivery as 'Дата поставки', 
	dbo.Personal.SurnamePers + ' ' + dbo.Personal.NamePers  + ' ' + dbo.Personal.PatronymicPers as 'ФИО сотрудника', 
	dbo.Storage.id_spot as 'Ячейка склада', 
	dbo.Storage.Amount as 'Места в ячейке', 
	dbo.Storage.occupiedSpace as 'Занятно места'
FROM          
	dbo.CategoryOfMedicament INNER JOIN
	dbo.Medicament ON dbo.CategoryOfMedicament.id_CategoryOfMedicament = dbo.Medicament.id_CategoryOfMedicament INNER JOIN
	dbo.DeliveryMedicament ON dbo.Medicament.id_Medicament = dbo.DeliveryMedicament.id_Medicament INNER JOIN
	dbo.Manufacturer ON dbo.Medicament.id_Manufacturer = dbo.Manufacturer.id_Manufacturer INNER JOIN
	dbo.Personal ON dbo.DeliveryMedicament.id_worker = dbo.Personal.id_worker INNER JOIN
	dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
where dbo.DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0



CREATE view [dbo].[DischargeOnWork] as
SELECT        
	dbo.Discharge.id_Discharge,
	dbo.TypeDischarge.NameDischarge as 'Наименование выписки', 
	dbo.DataCitizen.SurnameCit +' ' + dbo.DataCitizen.NameCit + ' ' +dbo.DataCitizen.PatronymicCit as 'ФИО пациента', 
	convert(varchar,[dbo].DataCitizen.SeriesPassportCit) + ' ' + convert(varchar,[dbo].DataCitizen.NumberPassportCit) as 'Серия,номер паспорта',  
	dbo.DataCitizen.DateBirthCit as 'Дата рождения', 
	dbo.DirectoryDisease.Name_Disease as 'Название заболевания', 
	dbo.WriteAppointment.times as 'Дата поступления',
	dbo.Diagnosis.TimeDisease as 'Срок лечения', 
	dbo.CardTreatments.Cured as 'Статус лечения', 
	dbo.Discharge.DateDischarge as 'Дата выписки',
	dbo.Personal.SurnamePers +' '+ dbo.Personal.namePers +' '+ dbo.Personal.PatronymicPers as 'ФИО врача'
FROM            
	dbo.DataCitizen INNER JOIN
	dbo.TypeDischarge INNER JOIN
	dbo.Discharge ON dbo.TypeDischarge.id_TypeDischarge = dbo.Discharge.id_TypeDischarge INNER JOIN
	dbo.DirectoryDisease INNER JOIN
	dbo.Diagnosis ON dbo.DirectoryDisease.id_Disease = dbo.Diagnosis.id_Disease INNER JOIN
	dbo.CardTreatments ON dbo.Diagnosis.id_Diagnoz = dbo.CardTreatments.id_Diagnoz INNER JOIN
	dbo.WriteAppointment ON dbo.CardTreatments.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment ON dbo.Discharge.id_WriteAppointment = dbo.WriteAppointment.id_WriteAppointment ON 
	dbo.DataCitizen.id_Citizen = dbo.WriteAppointment.id_Citizen INNER JOIN
	dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room INNER JOIN
	dbo.Personal ON dbo.TherapeuticDepartament.id_worker = dbo.Personal.id_worker
where
NameDischarge = 'Рабочая выписка' and Discharge.Discharge_Logical_Delete = 0