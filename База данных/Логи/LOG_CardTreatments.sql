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
-- триггер не различает вставку и удаление, так что добавим ручную обработку
-- обработка вставки
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
end -- завершение if
-- завершение dbo.changes_persons
