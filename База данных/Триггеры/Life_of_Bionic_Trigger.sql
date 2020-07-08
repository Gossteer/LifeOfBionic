use Life_of_Bionic
go

Create TRIGGER Tovar_INSERT ON dbo.DeliveryMedicament 
FOR INSERT
AS 
update dbo.Storage set 
occupiedSpace += (Select inserted.amount FROM inserted)
where id_spot = (Select inserted.id_spot FROM inserted)
go

Create TRIGGER Tovar_UPDATE ON dbo.DeliveryMedicament 
FOR UPDATE
AS 
update dbo.Storage set 
occupiedSpace += ((Select inserted.amount FROM inserted) - (Select deleted.amount FROM deleted))
where id_spot = (Select inserted.id_spot FROM inserted)
go

create TRIGGER UpdateOnPalateNewCitizen ON [dbo].[CardTreatments] 
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
						 go

create trigger [dbo].[InsertOnPalateNewCitizen] ON [dbo].[CardTreatments] 
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
						 else if ((sELECT Diagnosis.Amount FROM inserted INNER JOIN
                         dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz WHERE Diagnosis.id_Diagnoz = inserted.id_Diagnoz) > (SELECT     DISTINCT   dbo.Storage.occupiedSpace
FROM            inserted INNER JOIN
                         dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.DeliveryMedicament ON dbo.Medicament.id_Medicament = dbo.DeliveryMedicament.id_Medicament INNER JOIN
                         dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
						 where DiagnosiS.id_Diagnoz = inserted.id_Diagnoz and DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0 and Storage_Logical_Delete = 0)  
						 )
						 THROW 50680, 'На складе недостаточно лекарств',1
						 else
update dbo.Storage
set 
occupiedSpace -= (sELECT Diagnosis.Amount FROM        inserted INNER JOIN
                         dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz WHERE Diagnosis.id_Diagnoz = inserted.id_Diagnoz)
where
id_spot = (SELECT     DISTINCT   dbo.Storage.id_spot
FROM            inserted INNER JOIN
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
						 go

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
go

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
go

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
go

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
go

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
go
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

go
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

go
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

go
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

go
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
go

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
go

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
go

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
go

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
go

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
go

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
go

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
go

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
go

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
go
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
go

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
go

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
go