use Life_of_Bionic
go

alter procedure Select_Diagnos_For_Name_Disease
@Name_Disease varchar (50)
as
Select dbo.DirectoryDisease.Name_Disease as 'Название болезни', dbo.Diagnosis.TimeDisease as 'Срок лечения', dbo.Medicament.Name_Medicament as 'Назначаемое лекарство', dbo.Diagnosis.Amount as 'Количество', dbo.TypeUse.Name_Use as 'Способ применения', dbo.Diagnosis.ID_Room as 'Номер палаты лечения'
FROM dbo.Diagnosis INNER JOIN
dbo.DirectoryDisease ON dbo.Diagnosis.id_Disease = dbo.DirectoryDisease.id_Disease INNER JOIN
dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
dbo.TypeUse ON dbo.Diagnosis.id_TypeUse = dbo.TypeUse.id_TypeUse
WHERE dbo.DirectoryDisease.Name_Disease like '%' + @Name_Disease + '%' and Diagnosis.Diagnosis_Logical_Delete = 0



