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
-- ������� �� ��������� ������� � ��������, ��� ��� ������� ������ ���������
-- ��������� �������
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
end -- ���������� if
-- ���������� dbo.changes_persons
