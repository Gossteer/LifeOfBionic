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
-- триггер не различает вставку и удаление, так что добавим ручную обработку
-- обработка вставки
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
end -- завершение if
-- завершение dbo.changes_persons
