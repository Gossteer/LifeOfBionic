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
						 THROW 50679, '������ ������������',1 		 
						 else if ((sELECT Diagnosis.Amount FROM inserted INNER JOIN
                         dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz WHERE Diagnosis.id_Diagnoz = inserted.id_Diagnoz) > (SELECT     DISTINCT   dbo.Storage.occupiedSpace
FROM            inserted INNER JOIN
                         dbo.Diagnosis ON inserted.id_Diagnoz = dbo.Diagnosis.id_Diagnoz INNER JOIN
                         dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                         dbo.DeliveryMedicament ON dbo.Medicament.id_Medicament = dbo.DeliveryMedicament.id_Medicament INNER JOIN
                         dbo.Storage ON dbo.DeliveryMedicament.id_spot = dbo.Storage.id_spot
						 where DiagnosiS.id_Diagnoz = inserted.id_Diagnoz and DeliveryMedicament.DeliveryMedicament_Logical_Delete = 0 and Storage_Logical_Delete = 0)  
						 )
						 THROW 50680, '�� ������ ������������ ��������',1
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

--- ������� ������������� ��������� ���������������� ���������
create trigger dbo.changes_CardTreatments_trigger on  dbo.CardTreatments
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end
         
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'����� �'+ Convert(varchar (4),id_card) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'����� �'+ Convert(varchar (4),id_card) from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'����� �'+ Convert(varchar (4),id_card)  from inserted
    end
end
go

--- ������� ������������� ��������� ��������� ������������
create trigger dbo.changes_CategoriesDisease_trigger on  dbo.CategoriesDisease
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end         
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'��������� ��������: '+Name_CategoriesDisease from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'��������� ��������: '+Name_CategoriesDisease from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		 '��������� ��������: '+Name_CategoriesDisease from inserted
    end
end 
go

--- ������� ������������� ��������� ��������� ������������
create trigger dbo.changes_CategoryOfMedicament_trigger on  dbo.CategoryOfMedicament
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end
         
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'��������� ������������: '+Name_MedCategory from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'��������� ������������: '+Name_MedCategory from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		 '��������� ������������: '+Name_MedCategory from inserted
    end
end
go

--- ������� ������������� ��������� ��������� ������������
create trigger dbo.changes_DataCitizen_trigger on  dbo.DataCitizen
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end       
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'���������: '+NameCit+' '+SurnameCit+' '+PatronymicCit from deleted
end
else
begin

    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'���������: '+NameCit+' '+SurnameCit+' '+PatronymicCit from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'���������: '+NameCit+' '+SurnameCit+' '+PatronymicCit from inserted
    end
end
go

--- ������� ������������� ��������� ���������
create trigger dbo.changes_DeliveryMedicament_trigger on  dbo.DeliveryMedicament
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end       
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'�������� �'+ Convert(varchar (4),id_DeliveryMedicament) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'�������� �'+ Convert(varchar (4),id_DeliveryMedicament) from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'�������� �'+ Convert(varchar (4),id_DeliveryMedicament)  from inserted
    end
end
go
--- ������� ������������� ��������� ���������������� ���������
create trigger dbo.changes_Diagnosis_trigger on  dbo.Diagnosis
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end         
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'������� �'+ Convert(varchar (4),id_Diagnoz) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'������� �'+ Convert(varchar (4),id_Diagnoz) from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'������� �'+ Convert(varchar (4),id_Diagnoz)  from inserted
    end
end

go
--- ������� ������������� ��������� ����������� ��������
create trigger dbo.changes_DirectoryDisease_trigger on  dbo.DirectoryDisease
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end       
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'�������� �������: '+ Name_Disease from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'�������� �������: '+ Name_Disease from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'�������� �������: '+ Name_Disease from inserted
    end
end

go
--- ������� ������������� ��������� ���������������� ���������
create trigger dbo.changes_Discharge_trigger on  dbo.Discharge
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end       
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'������� �'+ Convert(varchar (4),[id_Discharge]) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'������� �'+ Convert(varchar (4),[id_Discharge]) from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'������� �'+ Convert(varchar (4),[id_Discharge])  from inserted
    end
end

go
--- ������� ������������� ��������� ���������
create trigger dbo.changes_FormWrite_trigger on  dbo.FormWrite
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'����� �� ������ �'+ Convert(varchar (4),id_FormWrite) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'����� �� ������ �'+ Convert(varchar (4),id_FormWrite) from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'������ �� ������ �'+ Convert(varchar (4),id_FormWrite)  from inserted
    end
end 

go
--- ������� ������������� ��������� �������������
create trigger dbo.changes_manufacturer_trigger on  dbo.Manufacturer
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end         
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'�������������: '+Name_Manufacturer from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'�������������: '+Name_Manufacturer from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		 '�������������: '+Name_Manufacturer from inserted
    end
end
go

--- ������� ������������� ��������� ������� ���������
create trigger dbo.changes_Medicament_trigger on  dbo.Medicament
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end      
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'����������: '+ Name_Medicament from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'����������: '+ Name_Medicament from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'����������: '+ Name_Medicament from inserted
    end
end 
go

--- ������� ������������� ��������� ���������
create trigger dbo.changes_Personal_trigger on  dbo.Personal
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end        
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'���������: '+ SurnamePers+' '+NamePers+' '+PatronymicPers from deleted
end
else
begin

    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'���������: '+ SurnamePers+' '+NamePers+' '+PatronymicPers from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'���������: '+ SurnamePers+' '+NamePers+' '+PatronymicPers from inserted
    end
end
go

--- ������� ������������� ��������� ������� ���������
create trigger dbo.changes_Regulation_trigger on  dbo.Regulation
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end      
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'������� �'+ CONVERT(varchar (4),id_Regulation) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'������� �'+ CONVERT(varchar (4),id_Regulation) from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'������� �'+ CONVERT(varchar (4),id_Regulation) from inserted
    end
end
go

--- ������� ������������� ��������� ������� ���������
create trigger dbo.changes_Role_trigger on  dbo.[Role]
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end     
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'���� �'+ CONVERT(varchar (4),id_Role) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'���� �'+ CONVERT(varchar (4),id_Role) from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'���� �'+ CONVERT(varchar (4),id_Role) from inserted
    end
end
go

--- ������� ������������� ��������� �������������� ���������
create trigger dbo.changes_SpecialityPersonal_trigger on  dbo.SpecialityPersonal
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end       
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'�������� �������������: '+ Name_SpecialityPersonal from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'�������� �������������: '+ Name_SpecialityPersonal from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'�������� �������������: '+ Name_SpecialityPersonal from inserted
    end
end
go

--- ������� ������������� ��������� ���������
create trigger dbo.changes_Storage_trigger on  dbo.Storage
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end      
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'������ ������ �'+ CONVERT(varchar (4),id_spot) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'������ ������ �'+ CONVERT(varchar (4),id_spot) from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'������ ������ �'+ CONVERT(varchar (4),id_spot) from inserted
    end
end
go

--- ������� ������������� ��������� ���������������� ���������
create trigger dbo.changes_TherapeuticDepartament_trigger on  dbo.TherapeuticDepartament
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end  
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'������ �'+ Convert(varchar (4),id_Room) from deleted
end
else
begin

    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'������ �'+ Convert(varchar (4),id_Room) from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'������ �'+ Convert(varchar (4),id_Room)  from inserted
    end
end
go

--- ������� ������������� ��������� ������� ���������
create trigger dbo.changes_TypeDischarge_trigger on  dbo.TypeDischarge
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end         
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'��� �������: '+ NameDischarge from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'��� �������: '+ NameDischarge from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'��� �������: '+ NameDischarge from inserted
    end
end
go

--- ������� ������������� ��������� ��������� ������������
create trigger dbo.changes_TypeUse_trigger on  dbo.TypeUse
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end       
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'���� �������������: '+ Name_Use from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'���� �������������: '+ Name_Use from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'���� �������������: '+ Name_Use from inserted
    end
end
go
--- ������� ������������� ��������� ��������� ������������
create trigger dbo.changes_TypeWrite_trigger on  dbo.TypeWrite
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end   
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'���� ������: '+Name_Write from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'���� ������: '+Name_Write from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		 '���� ������: '+Name_Write from inserted
    end
end
go

--- ������� ������������� ��������� ������� ���������
create trigger dbo.changes_WorkSchedulel_trigger on  dbo.WorkSchedule
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end     
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'������: '+ weekdays from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'������: '+ weekdays from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'������: '+ weekdays from inserted
    end
end
go

--- ������� ������������� ��������� ���������
create trigger dbo.changes_WriteAppointment_trigger on  dbo.WriteAppointment
FOR INSERT, UPDATE, DELETE 
as
set NOCOUNT ON;
declare @change_type as varchar(15)
declare @count as int
-- ����������� ��� ������������ ��������� INSERT,UPDATE, ��� DELETE
set @change_type = 'inserted'
select @count = COUNT(*) FROM DELETED
if @count > 0
begin
    set @change_type = 'deleted'
    select @count = COUNT(*) from INSERTED
    if @Count > 0
        set @change_type = 'updated'
end       
-- ��������� ��������
if @change_type = 'deleted'
begin
    insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '������� �� ', 
	'������ �'+ Convert(varchar (4),id_WriteAppointment) from deleted
end
else
begin
    if @change_type = 'inserted'
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '��������� � ',
		'������ �'+ Convert(varchar (4),id_WriteAppointment) from inserted
    end
-- ��������� ����������
    else
    begin
        insert into [dbo].[LogChange] (CHANGE_TYPE, Change_Info) select '�������� � ',
		'������ �'+ Convert(varchar (4),id_WriteAppointment)  from inserted
    end
end 
go