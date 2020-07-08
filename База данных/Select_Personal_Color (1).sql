create procedure [Select_Personal_Color]
@id_worker int
as
Select color from Personal where id_worker = @id_worker